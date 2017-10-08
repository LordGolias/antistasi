#include "../macros.hpp"
private _isJip = false;
if isNull player then {
    _isJip = true;
};

if _isJip then {
    diag_log "[AS] client: JIP: waiting for player";
    waitUntil {!isNull player and {player == player}};
};
diag_log "[AS] client: starting";
[player] call AS_fnc_emptyUnit;

call compile preprocessFileLineNumbers "briefing.sqf";

if not isServer then {
    call compile preprocessFileLineNumbers "initVar.sqf";
} else {
    waitUntil {(!isNil "serverInitVarsDone")};
};

private _introShot = 0 spawn {};
private _titulo = 0 spawn {};

// the fancy starting script, called outside debug mode
if not AS_debug_flag then {
    _introShot = [
        getMarkerPos "FIA_HQ", // Target position
        worldName + " Island", // SITREP text
        50, //  altitude
        50, //  radius
        90, //  degrees viewing angle
        0 // clockwise movement
    ] spawn BIS_fnc_establishingShot;

    _titulo = ["Antistasi", "by Golias"] spawn BIS_fnc_infoText;
};

waitUntil {scriptdone _introshot and scriptDone _titulo};

if (isNil "serverInitDone") then {
    disableUserInput true;
    cutText ["Waiting for Players and Server Init","BLACK",0];
    diag_log "[AS] client: waiting for serverInitDone";
    waitUntil {(!isNil "serverInitDone")};
    cutText ["Starting Mission","BLACK IN",0];
    disableUserInput false;
};
diag_log "[AS] client: initialized";

musicON = true;
[] execVM "musica.sqf";

if isMultiplayer then {
	diag_log format ["[AS] client: isJIP: %1", _isJip];
} else {
	AS_commander = player;
	private _group = group player;
	_group setGroupId ["Stavros","GroupColor4"];
	player setUnitRank "COLONEL";
	player hcSetGroup [_group];
};

if not hayACE then {
	tags = [] execVM "tags.sqf";
	if ((cadetMode) and (isMultiplayer)) then {
        [] execVM "playerMarkers.sqf"
    };
} else {
	[] execVM "playerMarkers.sqf";
};

player setvariable ["compromised", 0];  // Used by undercover mechanics
player setVariable ["punish",0,true];  // punish time for Team kill
player setVariable ["money",100,true];  // initial money
player setVariable ["BLUFORSpawn",true,true];  // means that the unit triggers spawn of zones.
player setUnitRank (AS_ranks select 0);
player setVariable ["rank", (AS_ranks select 0), true];
private _score = 0;
if (player == AS_commander) then {_score = 25}; // so the commander does not lose the position immediately.
player setVariable ["score", _score, true];
player setVariable ["garage", [], true];

if isMultiplayer then {
    musicON = false;
    player setVariable ["elegible",true,true];
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
};

call AS_fnc_initPlayer;

player addEventHandler ["GetInMan", {
    params ["_unit", "_seat", "_vehicle"];
	private _exit = false;
	if isMultiplayer then {
		private _owner = _vehicle getVariable "AS_vehOwner";
		if (!isNil "_owner" and
            {{getPlayerUID _x == _owner} count (units group player) == 0}) then {
			hint "You can only enter in other's vehicle if you are in its group";
			moveOut _unit;
			_exit = true;
		};
	};
	if not _exit then {
		if (((typeOf _vehicle) in arrayCivVeh) or ((typeOf _vehicle) == civHeli)) then {
			if (!(_vehicle in AS_S("reportedVehs"))) then {
				[] spawn AS_fnc_activateUndercover;
			};
		};
		if (_seat == "driver" and _vehicle isKindOf "Truck_F") then {
			if ((not (_vehicle isKindOf "C_Van_01_fuel_F")) and (not (_vehicle isKindOf "I_Truck_02_fuel_F")) and (not (_vehicle isKindOf "B_G_Van_01_fuel_F"))) then {
				private _EHid = [_vehicle, "transferFrom"] call AS_fnc_addAction;
				player setVariable ["transferID", _EHid];
			};
		};
	};
}];

player addEventHandler ["GetOutMan", {
    params ["_unit", "_seat", "_vehicle"];
	if ((player getVariable ["transferID", -1]) != -1) then {
		_vehicle removeAction (player getVariable "transferID");
		player setVariable ["transferID", nil];
	};
}];

if (_isJip) then {
    hint format ["Welcome back %1", name player];
    if (count playableUnits == 1) then {
        [] remoteExec ["AS_fnc_chooseCommander", 2];
    };

	{
	if (_x isKindOf "FlagCarrier") then {
		private _location = [call AS_location_fnc_all, getPos _x] call BIS_fnc_nearestPosition;
		if !((_location call AS_location_fnc_type) in ["hill", "roadblock"]) then {
			if (_location call AS_location_fnc_side == "FIA") then {
				_x addAction [localize "STR_act_recruitUnit", {call AS_fnc_UI_recruitUnit_menu;},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
				_x addAction [localize "STR_act_buyVehicle", {call AS_fnc_UI_buyVehicle_menu;},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
				_x addAction [localize "STR_act_persGarage", {nul = [true] spawn AS_fnc_accessGarage},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
			};
		};
	};
	} forEach vehicles - [bandera,fuego,caja,cajaVeh];

	{
	if ([_x] call AS_fnc_getFIAUnitType == "Survivor") then {
		if (!isPlayer (leader group _x)) then {
			_x addAction [localize "STR_act_orderRefugee", "AI\liberaterefugee.sqf",nil,0,false,true];
		};
	};
	} forEach allUnits;

	if ((player == AS_commander) and (isNil "placementDone")) then {
        [] spawn AS_database_fnc_UI_loadSaveMenu;
	};

	// sync the inventory content to the JIP.
	[false] remoteExec ["AS_fnc_refreshArsenal", 2];
};

private _texto = "";

if (hayTFAR) then {
	_texto = "TFAR Detected\n\nAntistasi detects TFAR in the server config.\nAll players will start with TFAR default radios.\nDefault revive system will shut down radios while players are inconscious.\n\n";
};
if (hayACE) then {
	_texto = _texto + "ACE 3 Detected\n
                       \nACE items added.
                       \nDefault AI control disabled.";
    if (hayACEMedical) then {
        _texto = _texto + "\nACE Medical being used: default revive system disabled.";
    };
    if (hayACEhearing) then {
        _texto = _texto + "\nACE Hearing being used: default earplugs disabled.";
    };
};
if (hayRHS) then {
	_texto = _texto + "\n\nRHS Detected:\n\nAAF -> VDV\nCSAT -> VMF\nNATO -> USMC";
};

if (hayTFAR or hayACE or hayRHS) then {
	hint format ["%1",_texto];
};

removeAllActions petros;
[petros, "mission"] call AS_fnc_addAction;

removeAllActions caja;
[caja,"arsenal"] call AS_fnc_addAction;
[caja,"transferFrom"] call AS_fnc_addAction;

removeAllActions mapa;
mapa addAction [localize "str_act_gameOptions", {CreateDialog "game_options_commander";},nil,0,false,true,"","(isPlayer _this) and (_this == AS_commander) and (_this == _this getVariable ['owner',_this])"];
mapa addAction [localize "str_act_gameOptions", {CreateDialog "game_options_player";},nil,0,false,true,"","(isPlayer _this) and !(_this == AS_commander) and (_this == _this getVariable ['owner',_this])"];
mapa addAction [localize "str_act_mapInfo", "actions\fnc_location_mapInfo.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',_this])"];
mapa addAction [localize "str_act_tfar", {CreateDialog "tfar_menu";},nil,0,false,true,"","(isClass (configFile >> ""CfgPatches"" >> ""task_force_radio""))", 5];

removeAllActions bandera;
[bandera,"unit"] call AS_fnc_addAction;
[bandera,"vehicle"] call AS_fnc_addAction;
[bandera,"garage"] call AS_fnc_addAction;

bandera addAction [localize "str_act_hqOptions",AS_fnc_UI_manageHQ_menu,nil,0,false,true,"","(isPlayer _this) and (player == AS_commander) and (_this == _this getVariable ['owner',_this]) and (petros == leader group petros)"];

removeAllActions cajaVeh;
cajaVeh addAction [localize "str_act_healRepair", "actions\healandrepair.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',_this])"];

removeAllActions fuego;
fuego addAction [localize "str_act_rest", "actions\skiptime.sqf",nil,0,false,true,"","(_this == AS_commander)"];

{
    [_x,"moveObject"] call AS_fnc_addAction;
} forEach [caja, mapa, bandera, cajaVeh, fuego];

if (isNil "placementDone") then {
    waitUntil {!isNil "AS_commander"};
    if (player == AS_commander) then {
        HC_comandante synchronizeObjectsAdd [player];
        player synchronizeObjectsAdd [HC_comandante];
        if not AS_debug_flag then {
            [] spawn AS_database_fnc_UI_loadSaveMenu;
        } else {
            [getMarkerPos "FIA_HQ"] remoteExec ["AS_fnc_HQplace", 2];
        };
    };
};

diag_log "[AS] client: ready";
