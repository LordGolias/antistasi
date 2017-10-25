#include "macros.hpp"
AS_SERVER_ONLY("fnc_win_location.sqf");
params ["_location", ["_player", objnull]];

if (_location call AS_location_fnc_side == "FIA") exitWith {
	diag_log format ["[AS] Error: AS_fnc_win_location called from FIA location '%1'", _location];
};
private _posicion = _location call AS_location_fnc_position;
private _type = _location call AS_location_fnc_type;
private _size = _location call AS_location_fnc_size;

{
	if (isPlayer _x) then {
		[_x, "score", 5] call AS_players_fnc_change;
		[_x, "money", 100] call AS_players_fnc_change;
		[_location] remoteExec ["AS_fnc_showFoundIntel", _x];
		if (captive _x) then {[_x,false] remoteExec ["setCaptive",_x]};
	}
} forEach ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

private _flag = objNull;
private _dist = 10;
while {isNull _flag} do {
	_dist = _dist + 10;
	_flag = (nearestObjects [_posicion, ["FlagCarrier"], _dist]) select 0;
};
[[_flag,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;
_flag setFlagTexture "\A3\Data_F\Flags\Flag_FIA_CO.paa";

sleep 5;
[[_flag,"unit"],"AS_fnc_addAction"] call BIS_fnc_MP;
[[_flag,"vehicle"],"AS_fnc_addAction"] call BIS_fnc_MP;
[[_flag,"garage"],"AS_fnc_addAction"] call BIS_fnc_MP;

[_location,"side","FIA"] call AS_location_fnc_set;

[[_location], "AS_movement_fnc_sendAAFpatrol"] call AS_scheduler_fnc_execute;

if (_type == "airfield") then {
	[0,10,_posicion] call AS_fnc_changeCitySupport;
	[["TaskSucceeded", ["", "Airport Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[20,10] call AS_fnc_changeForeignSupport;
   	["con_bas"] call fnc_BE_XP;
};
if (_type == "base") then {
	[0,10,_posicion] call AS_fnc_changeCitySupport;
	[["TaskSucceeded", ["", "Base Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[20,10] call AS_fnc_changeForeignSupport;
	["con_bas"] call fnc_BE_XP;

	// discover nearby minefields
	{
		if ((_x call AS_location_fnc_position) distance _posicion < 400) then {
			[_x,"found",true] call AS_location_fnc_set;
		};
	} forEach (["minefield", "AAF"] call AS_location_fnc_TS);
};

if (_type == "powerplant") then {
	[["TaskSucceeded", ["", "Powerplant Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[0,5] call AS_fnc_changeForeignSupport;
	["con_ter"] call fnc_BE_XP;
	[_location] call AS_fnc_recomputePowerGrid;
};
if (_type == "outpost") then {
	[["TaskSucceeded", ["", "Outpost Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	["con_ter"] call fnc_BE_XP;
};
if (_type == "seaport") then {
	[["TaskSucceeded", ["", "Seaport Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[10,10] call AS_fnc_changeForeignSupport;
	["con_ter"] call fnc_BE_XP;
	[[_flag,"seaport"],"AS_fnc_addAction"] call BIS_fnc_MP;
};
if (_type in ["factory", "resource"]) then {
	if (_type == "factory") then {[["TaskSucceeded", ["", "Factory Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;};
	if (_type == "resource") then {[["TaskSucceeded", ["", "Resource Taken"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;};
	["con_ter"] call fnc_BE_XP;
	[0,10] call AS_fnc_changeForeignSupport;
	private _powerpl = ["powerplant" call AS_location_fnc_T, _posicion] call BIS_fnc_nearestPosition;
	if (_powerpl call AS_location_fnc_side == "AAF") then {
		sleep 5;
		[["TaskFailed", ["", "Resource out of Power"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		[_location, false] spawn AS_fnc_changeStreetLights;
	} else {
		[_location, true] spawn AS_fnc_changeStreetLights;
	};
};

waitUntil {sleep 1;
	(not (_location call AS_location_fnc_spawned)) or
	(({(not(vehicle _x isKindOf "Air")) and (alive _x) and (!fleeing _x)} count ([_size, _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance)) >
	 3*({(alive _x)} count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance)))};

if (_location call AS_location_fnc_spawned) then {
	[_location] spawn AS_fnc_lose_location;
} else {
	_location call AS_location_fnc_removeRoadblocks;
	[_posicion, _size, caja] call AS_fnc_collectDroppedEquipment;
};
