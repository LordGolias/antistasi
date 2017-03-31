waitUntil {!isNull player};
waitUntil {player == player};

[] execVM "briefing.sqf";
#include "Scripts\SHK_Fastrope.sqf"

// removes everything but map, GPS, etc.
removeAllItemsWithMagazines player;
{player removeWeaponGlobal _x} forEach weapons player;
removeBackpackGlobal player;
removeVest player;

if (isMultiplayer and !isServer) then {
    call compile preprocessFileLineNumbers "initFuncs.sqf";
    call compile preprocessFileLineNumbers "initVar.sqf";
};

[] execVM "musica.sqf";

_isJip = _this select 1;
private ["_colorWest", "_colorEast"];
_colorWest = west call BIS_fnc_sideColor;
_colorEast = east call BIS_fnc_sideColor;
{
_x set [3, 0.33]
} forEach [_colorWest, _colorEast];

_introShot =
	[
    position petros, // Target position
    "Altis Island", // SITREP text
    50, //  altitude
    50, //  radius
    90, //  degrees viewing angle
    0, // clockwise movement
    [
    	["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorWest, markerPos "insertMrk", 1, 1, 0, "Insertion Point", 0],
        ["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "towerBaseMrk", 1, 1, 0, "Radio Towers", 0]
    ]
    ] spawn BIS_fnc_establishingShot;

// wait for the server to be ready to receive players (see initServer.sqf)
if (isMultiplayer) then {
    waitUntil {!isNil "serverInitVarsDone"};
    diag_log "[AS] client: serverInitVarsDone";
};

_titulo = ["A3 - Antistasi","by Barbolani",antistasiVersion] spawn BIS_fnc_infoText;

if (isMultiplayer) then {
	player setVariable ["elegible",true,true];
	musicON = false;
	waitUntil {scriptdone _introshot};
	disableUserInput true;
	cutText ["Waiting for Players and Server Init","BLACK",0];
	diag_log "[AS] client: waiting for serverInitDone";
	waitUntil {(!isNil "serverInitDone")};
	cutText ["Starting Mission","BLACK IN",0];
	diag_log "[AS] client: serverInitDone";
	diag_log format ["[AS] client: isJIP: %1", _isJip];
}
else {
	AS_commander = player;
	_group = group player;
	_group setGroupId ["Stavros","GroupColor4"];
	player setIdentity "protagonista";
	player setUnitRank "COLONEL";
	player hcSetGroup [_group];
	waitUntil {(scriptdone _introshot) and (!isNil "serverInitDone")};
};

disableUserInput false;
player addWeaponGlobal "itemmap";
player addWeaponGlobal "itemgps";
player setVariable ["owner",player,true];
player setVariable ["punish",0,true];
player setVariable ["dinero",100,true];
player setVariable ["BLUFORSpawn",true,true];
player setVariable ["rango",rank player,true];
_score = 0;
if (player==AS_commander) then {_score = 25};
player setVariable ["score", _score, true];

MIASquadUnits = creategroup WEST;  // units that are not in the squad because they lost communication with the player (no radio).

(group player) enableAttack false;
if (!hayACE) then {
	tags = [] execVM "tags.sqf";
	if ((cadetMode) and (isMultiplayer)) then {[] execVM "playerMarkers.sqf"};
}
else {
	[] execVM "playerMarkers.sqf";
};

if (hayRHS) then {[player] execVM "Municion\RHSdress.sqf"};

player setvariable ["compromised", 0];  // Used by undercover mechanics

[] call AS_fnc_initPlayer;

player addEventHandler ["GetInMan", {
	private ["_unit","_veh"];
	_unit = _this select 0;
	_veh = _this select 2;
	_exit = false;
	if (isMultiplayer) then {
		_owner = _veh getVariable "duenyo";
		if (!isNil "_owner") then {
			if (_owner isEqualType "") then {
				if ({getPlayerUID _x == _owner} count (units group player) == 0) then {
					hint "You cannot board other player vehicle if you are not in the same group";
					moveOut _unit;
					_exit = true;
				};
			};
		};
	};
	if (!_exit) then {
		if (((typeOf _veh) in arrayCivVeh) or ((typeOf _veh) == civHeli)) then {
			if (!(_veh in reportedVehs)) then {
				[] spawn undercover;
			};
		};
		if (_veh isKindOf "Truck_F") then {
			if ((not (_veh isKindOf "C_Van_01_fuel_F")) and (not (_veh isKindOf "I_Truck_02_fuel_F")) and (not (_veh isKindOf "B_G_Van_01_fuel_F"))) then {
				//if (_this select 1 == "driver") then {[_unit,"camion"] call flagaction};
				if (_this select 1 == "driver") then {
					_EHid = _unit addAction [localize "STR_act_loadAmmobox", "Municion\transfer.sqf",nil,0,false,true];
					_unit setVariable ["transferID", _EHid, true];
				};
			};
		};
	};
}];

player addEventHandler ["GetOutMan", {
	if !((player getVariable ["transferID", -1]) == -1) then {
		player removeaction (player getVariable "transferID");
		player setVariable ["transferID", nil, true];
	};
}];

if (isMultiplayer) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
	personalGarage = [];
};

if (_isJip) then {
	waitUntil {scriptdone _introshot};
	[] execVM "modBlacklist.sqf";
	//player setVariable ["score",0,true];
	//player setVariable ["owner",player,true];
	player setVariable ["punish",0,true];
	player setUnitRank "PRIVATE";
	waitUntil {!isNil "posHQ"};

	_pos = posHQ findEmptyPosition [2, 10, typeOf (vehicle player)];
	player setPos _pos;

	if (not([player] call isMember)) then {
		if (serverCommandAvailable "#logout") then {
			miembros pushBack (getPlayerUID player);
			publicVariable "miembros";
			hint "You are not in the member's list, but as you are Server Admin, you have been added up. Welcome!"
		}
		else {
			hint "Welcome Guest\n\nYou have joined this server as guest";
			//if ((count playableUnits == maxPlayers) and (({[_x] call isMember} count playableUnits) < count miembros) and (serverName in servidoresOficiales)) then {["serverFull",false,1,false,false] call BIS_fnc_endMission};
		};
	}
	else {
		hint format ["Welcome back %1", name player];

		if (serverName in servidoresOficiales) then {
			if ((count playableUnits == maxPlayers) and (({[_x] call isMember} count playableUnits) < count miembros)) then {
				{
				if (not([_x] call isMember)) exitWith {["serverFull",false,1,false,false] remoteExec ["BIS_fnc_endMission",_x]};
				} forEach playableUnits;
			};
		};
		if ({[_x] call isMember} count playableUnits == 1) then {
			[player] call stavrosInit;
			[] remoteExec ["assignStavros",2];
		};
	};
	
	{
	if (_x isKindOf "FlagCarrier") then {
		_marcador = [marcadores,getPos _x] call BIS_fnc_nearestPosition;
		if ((not(_marcador in colinas)) and (not(_marcador in controles))) then {
			if (_marcador in mrkAAF) then {
				_x addAction [localize "STR_act_takeFlag", {[[_this select 0, _this select 1],"mrkWIN"] call BIS_fnc_MP;},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
			}
			else {
				_x addAction [localize "STR_act_recruitUnit", {nul=[] execVM "Dialogs\unit_recruit.sqf";;},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
				_x addAction [localize "STR_act_buyVehicle", {nul = createDialog "vehicle_option";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
				_x addAction [localize "STR_act_persGarage", {nul = [true] spawn garage},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
			};
		};
	};
	} forEach vehicles - [bandera,fuego,caja,cajaVeh];
	
	{
	if (typeOf _x == "b_g_survivor_F") then {
		if (!isPlayer (leader group _x)) then {
			_x addAction [localize "STR_act_orderRefugee", "AI\liberaterefugee.sqf",nil,0,false,true];
		};
	};
	} forEach allUnits;

	if ((player == AS_commander) and (isNil "placementDone") and (isMultiplayer)) then {
		[] execVM "Dialogs\initMenu.sqf";
	}
	else {
		[true] execVM "Dialogs\firstLoad.sqf";
	};
	
	// sync the inventory content to the JIP.
	remoteExec ["fnc_MAINT_refillArsenal", 2];
}
else {  // not JIP
	if (isNil "placementDone") then {
		waitUntil {!isNil "AS_commander"};
		if (player == AS_commander) then {
		    if (isMultiplayer) then {
		    	HC_comandante synchronizeObjectsAdd [player];
				player synchronizeObjectsAdd [HC_comandante];
		    	[] execVM "Dialogs\initMenu.sqf";
		    }
		    else {
		    	miembros = [];
		    	 [] execVM "Dialogs\firstLoad.sqf";
		    };
		};
	};
};
waitUntil {scriptDone _titulo};

_texto = "";

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
	_texto = _texto + "RHS-AFRF Detected\n\nAntistasi detects RHS - AFRF in the server config.\nAAF will be replaced with VDV, VMF will take the place of CSAT.\n\nRecruited AI will use AFRF gear.";
};

if (hayUSAF) then {
	_texto = _texto + "RHS-USAF Detected\n\nAntistasi detects RHS - USAF in the server config.\nNATO will be replaced with USAF.";
};

if (hayTFAR or hayACE or hayRHS or hayUSAF) then {
	hint format ["%1",_texto];
	// [_texto] spawn {
		// sleep 0.5;
		// _texto = _this select 0;
		// "Integrated Mods Detected" hintC _texto;
		// hintC_arr_EH = findDisplay 72 displayAddEventHandler ["unload", {
			// 0 = _this spawn {
				// _this select 0 displayRemoveEventHandler ["unload", hintC_arr_EH];
				// hintSilent "";
			// };
			// }];
		// };
};

removeAllActions caja;
caja addaction [localize "STR_act_arsenal", {_this call accionArsenal;}, [], 6, true, false, "", "(isPlayer _this) and (_this == _this getVariable ['owner',objNull])",5];
caja addAction [localize "STR_act_unloadCargo", "[] call vaciar"];
caja addAction [localize "STR_act_moveAsset", "moveObject.sqf",nil,0,false,true,"","(_this == AS_commander)"];
diag_log "[AS] client: ready";