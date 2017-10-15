#include "../macros.hpp"
private _isJip = false;
if isNull player then {
    _isJip = true;
};
diag_log "[AS] Client: waiting for player...";
waitUntil {sleep 0.1; !isNull player and {player == player}};

diag_log "[AS] Client: initializing...";
[player] call AS_fnc_emptyUnit;

call compile preprocessFileLineNumbers "briefing.sqf";

if not isServer then {
    diag_log "[AS] Client: initializing common variables...";
    call compile preprocessFileLineNumbers "initialization\common_variables.sqf";
} else {
    diag_log "[AS] Client: waiting for common variables...";
    waitUntil {sleep 0.1; not isNil "AS_common_variables_initialized"};
    AS_common_variables_initialized = nil;
};

if (isNil "AS_server_variables_initialized") then {
    disableUserInput true;
    diag_log "[AS] Client: waiting for AS_server_variables_initialized";
    waitUntil {sleep 0.1; (!isNil "AS_server_variables_initialized")};
    disableUserInput false;
};

musicON = true;
if isMultiplayer then {
    musicON = false;
};
[] execVM "musica.sqf";

if not hayACE then {
	tags = [] execVM "tags.sqf";
	if ((cadetMode) and (isMultiplayer)) then {
        [] execVM "playerMarkers.sqf"
    };
} else {
	[] execVM "playerMarkers.sqf";
};

if isMultiplayer then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
};

///// display what mods the client has
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

if (hayTFAR or hayACE) then {
	hint format ["%1",_texto];
};

/////////////////////////////////////////////////////////////////////////////
/////////////// Client waits for a commander to be chosen ///////////////////
/////////////////////////////////////////////////////////////////////////////
if (_isJip and {count playableUnits == 1}) then {
    [] remoteExec ["AS_fnc_chooseCommander", 2];
};

diag_log "[AS] Client: waiting for a commander...";
if isNil "AS_commander" then {
    waitUntil {sleep 0.1; not isNil "AS_commander"};
};

player setPos ((getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle player)]);
diag_log "[AS] Client: waiting for position...";

if (player == AS_commander) then {
    hint "You are the current commander";
    HC_comandante synchronizeObjectsAdd [player];
    player synchronizeObjectsAdd [HC_comandante];

    if not AS_debug_flag then {
        [] spawn AS_fnc_UI_startMenu_menu;
    } else {
        // skip menu and start new game
        ["west", "FIA", "NATO", "AAF", "CSAT"] remoteExec ["AS_fnc_startNewGame", 2];
    };
};

/////////////////////////////////////////////////////////////////////////////
/////////////// Client waits for the commander to choose a side /////////////
/////////////////////////////////////////////////////////////////////////////
diag_log "[AS] Client: waiting for commander to choose sides...";

waitUntil {sleep 0.1; private _var = AS_P("player_side"); not isNil "_var"};

if not isServer then {
    call compile preprocessFileLineNumbers "initialization\common_side_variables.sqf";
} else {
    waitUntil {sleep 0.1; not isNil "AS_common_variables_initialized"};
    AS_common_variables_initialized = nil;
};

/////////////////////////////////////////////////////////////////////////////
///////////// Client waits for the commander to choose a location ///////////
/////////////////////////////////////////////////////////////////////////////
diag_log "[AS] Client: waiting for commander to choose HQ location...";
waitUntil {not isNil "placementDone"};

[] execVM "reinitY.sqf";
[] spawn AS_fnc_UI_showTopBar;

[player] execVM "OrgPlayers\unitTraits.sqf";
[] spawn AS_fnc_activatePlayerRankLoop;

["Soldier", "delete"] call AS_fnc_spawnPlayer;

if _isJip then {
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

	// sync the inventory content to the JIP.
	[false] remoteExec ["AS_fnc_refreshArsenal", 2];
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
bandera addAction [localize "STR_act_manageTrait",AS_fnc_UI_manageTrait_menu,nil,0,false,true,"","(isPlayer _this) and {not call AS_fnc_controlsAI}"];

removeAllActions cajaVeh;
cajaVeh addAction [localize "str_act_healRepair", "actions\healandrepair.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',_this])"];

removeAllActions fuego;
fuego addAction [localize "str_act_rest", "actions\skiptime.sqf",nil,0,false,true,"","(_this == AS_commander)"];

{
    [_x,"moveObject"] call AS_fnc_addAction;
} forEach [caja, mapa, bandera, cajaVeh, fuego];

diag_log "[AS] Client: initialized";
