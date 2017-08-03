#include "macros.hpp"
AS_SERVER_ONLY("mrkWIN.sqf");
params ["_bandera", ["_player", objnull]];

if ((!isNull _player) and (captive _player)) exitWith {hint "You cannot Capture the Flag while in Undercover Mode"};
if (!isServer) exitWith {diag_log "[AS] Error: mrkWIN called from non-player and non-server";};

private _location = [call AS_fnc_location_all,getPos _bandera] call BIS_fnc_nearestPosition;
if (_location call AS_fnc_location_side == "FIA") exitWith {
	diag_log format ["[AS] Error: mrkWIN called from FIA location '%1'", _location];
};
private _posicion = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
private _size = _location call AS_fnc_location_size;

{
	if (isPlayer _x) then {
		[5,_x] call AS_fnc_changePlayerScore;
		[[_location], "intelFound.sqf"] remoteExec ["execVM", _x];
		if (captive _x) then {[_x,false] remoteExec ["setCaptive",_x]};
	}
} forEach ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits);

[[_bandera,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;
_bandera setFlagTexture "\A3\Data_F\Flags\Flag_FIA_CO.paa";

sleep 5;
[[_bandera,"unit"],"AS_fnc_addAction"] call BIS_fnc_MP;
[[_bandera,"vehicle"],"AS_fnc_addAction"] call BIS_fnc_MP;
[[_bandera,"garage"],"AS_fnc_addAction"] call BIS_fnc_MP;

[_location,"side","FIA"] call AS_fnc_location_set;
_location call AS_fnc_location_updateMarker;

[_location] remoteExec ["patrolCA", HCattack];

if (_type == "airfield") then {
	[0,10,_posicion] remoteExec ["citySupportChange",2];
	[["TaskSucceeded", ["", "Airport Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[20,10] call AS_fnc_changeForeignSupport;
   	["con_bas"] remoteExec ["fnc_BE_XP", 2];
};
if (_type == "base") then {
	[0,10,_posicion] remoteExec ["citySupportChange",2];
	[["TaskSucceeded", ["", "Base Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[20,10] call AS_fnc_changeForeignSupport;
	["con_bas"] remoteExec ["fnc_BE_XP", 2];

	// discover nearby minefields
	{
		if ((_x call AS_fnc_location_position) distance _posicion < 400) then {
			[_x,"found",true] call AS_fnc_location_set;
		};
	} forEach (["minefield", "AAF"] call AS_fnc_location_TS);
};

if (_type == "powerplant") then {
	[["TaskSucceeded", ["", "Powerplant Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[0,5] call AS_fnc_changeForeignSupport;
	["con_ter"] remoteExec ["fnc_BE_XP", 2];
	[_location] call powerReorg;
};
if (_type == "outpost") then {
	[["TaskSucceeded", ["", "Outpost Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	["con_ter"] remoteExec ["fnc_BE_XP", 2];
};
if (_type == "seaport") then {
	[["TaskSucceeded", ["", "Seaport Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[10,10] call AS_fnc_changeForeignSupport;
	["con_ter"] remoteExec ["fnc_BE_XP", 2];
	[[_bandera,"seaport"],"AS_fnc_addAction"] call BIS_fnc_MP;
};
if (_type in ["factory", "resource"]) then {
	if (_type == "factory") then {[["TaskSucceeded", ["", "Factory Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;};
	if (_type == "resource") then {[["TaskSucceeded", ["", "Resource Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;};
	["con_ter"] remoteExec ["fnc_BE_XP", 2];
	[0,10] call AS_fnc_changeForeignSupport;
	_powerpl = [(call AS_fnc_location_all) select {_x call AS_fnc_location_type == "powerplant"}, _posicion] call BIS_fnc_nearestPosition;
	if (_powerpl call AS_fnc_location_side == "AAF") then {
		sleep 5;
		[["TaskFailed", ["", "Resource out of Power"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		[_location, false] call apagon;
	} else {
		[_location, true] call apagon;
	};
};

_location call deleteControles;

waitUntil {sleep 1;
	(not (_location call AS_fnc_location_spawned)) or
	(({(not(vehicle _x isKindOf "Air")) and (alive _x) and (!fleeing _x)} count ([_size,0,_posicion,"OPFORSpawn"] call distanceUnits)) >
	 3*({(alive _x)} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)))};

if (_location call AS_fnc_location_spawned) then {
	[_location] spawn mrkLOOSE;
};
