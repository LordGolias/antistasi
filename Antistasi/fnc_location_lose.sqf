#include "macros.hpp"
AS_SERVER_ONLY("AS_fnc_location_lose.sqf");
params ["_location"];

if (_location call AS_fnc_location_side == "AAF") exitWith {
	diag_log format ["[AS] Error: AS_fnc_location_lose called for AAF location '%1'", _location];
};

private _posicion = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
private _size = _location call AS_fnc_location_size;

[_location,"side","AAF"] call AS_fnc_location_set;

["territory", -1] call fnc_BE_update;


// remove all garrison
// todo: transfer alive garrison to FIA_HQ
[_location, "garrison", []] call AS_fnc_location_set;

// Remove all statics there
private _staticsRemoved = [];
{
	if ((position _x) distance _posicion < _size) then {
		_staticsRemoved pushBack _x;
		deleteVehicle _x;
	};
} forEach AS_P("vehicles");
[_staticsRemoved, false] call AS_fnc_changePersistentVehicles;


if (_type in ["outpost", "seaport"]) then {
	[10,-10,_posicion] call citySupportChange;
	if (_type == "outpost") then {
		[["TaskFailed", ["", "Outpost Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Sea Port Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
};
if (_type == "powerplant") then {
	[0,-5] call AS_fnc_changeForeignSupport;
	[["TaskFailed", ["", "Powerplant Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[_location] call powerReorg;
};
if (_type in ["resource", "factory"]) then {
	[10,-10,_posicion] call citySupportChange;
	[0,-5] call AS_fnc_changeForeignSupport;

	if (_type == "resource") then {
		[["TaskFailed", ["", "Resource Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Factory Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
};
if (_type in ["base", "airfield"]) then {
	[20,-20,_posicion] call citySupportChange;
	[0,-10] call AS_fnc_changeForeignSupport;
	[_location,60] call AS_fnc_location_increaseBusy;

	if (_type == "base") then {
		[["TaskFailed", ["", "Base Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Airport Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
    };
};

waitUntil {sleep 1;
	(not (_location call AS_fnc_location_spawned)) or
	(({(not(vehicle _x isKindOf "Air")) and (alive _x)} count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance)) >
	3*({(alive _x) and (!fleeing _x)} count ([_size, _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance)))
};

if (_location call AS_fnc_location_spawned) then {
	[_location] spawn AS_fnc_location_win;
} else {
	[_location] call AS_fnc_location_addRoadblocks;
};
