#include "macros.hpp"
AS_SERVER_ONLY("mrkLOOSE.sqf");
params ["_location"];

if (_location call AS_fnc_location_side == "AAF") exitWith {
	diag_log format ["[AS] Error: mrkLOOSE called for AAF location '%1'", _location];
};

private _posicion = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
private _size = _location call AS_fnc_location_size;

[_location,"side","AAF"] call AS_fnc_location_set;
_location call AS_fnc_location_updateMarker;

["territory", -1] remoteExec ["fnc_BE_update", 2];

// todo: transfer alive garrison to FIA_HQ
[_location, "garrison", []] call AS_fnc_location_set;

// update flag
private _flag = objNull;
private _dist = 10;
while {isNull _flag} do {
	_dist = _dist + 10;
	_flag = (nearestObjects [_posicion, ["FlagCarrier"], _dist]) select 0;
};
[[_flag,"take"],"AS_fnc_addAction"] call BIS_fnc_MP;

if (_type in ["outpost", "seaport"]) then {
	[10,-10,_posicion] remoteExec ["citySupportChange",2];
	if (_type == "outpost") then {
		[["TaskFailed", ["", "Outpost Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Sea Port Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
};
if (_type == "powerplant") then {
	[0,-5] call AS_fnc_changeForeignSupport;
	[["TaskFailed", ["", "Powerplant Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[_location] remoteExec ["powerReorg",2];
};
if (_type in ["resource", "factory"]) then {
	[10,-10,_posicion] remoteExec ["citySupportChange",2];
	[0,-5] call AS_fnc_changeForeignSupport;

	if (_type == "resource") then {
		[["TaskFailed", ["", "Resource Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Factory Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
};
if (_type in ["base", "airfield"]) then {
	[20,-20,_posicion] remoteExec ["citySupportChange",2];
	[0,-10] call AS_fnc_changeForeignSupport;
	server setVariable [_location,dateToNumber date,true];
	[_location,60] call AS_fnc_location_increaseBusy;

	if (_type == "base") then {
		[["TaskFailed", ["", "Base Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Airport Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
    };
};

waitUntil {isNil "AS_vehiclesChanging"};
AS_vehiclesChanging = true;
private _staticsRemoved = [];
{
	if ((position _x) distance _posicion < _size) then {
		_staticsRemoved pushBack _x;
		deleteVehicle _x;
	};
} forEach AS_P("vehicles");

if (count _staticsRemoved > 0) then {
	AS_Pset("vehicles", AS_P("vehicles") - _staticsRemoved);
};
AS_vehiclesChanging = nil;

waitUntil {sleep 1;
	(not (_location call AS_fnc_location_spawned)) or
	(({(not(vehicle _x isKindOf "Air")) and (alive _x)} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) >
	3*({(alive _x) and (!fleeing _x)} count ([_size,0,_posicion,"OPFORSpawn"] call distanceUnits)))
};

if (_location call AS_fnc_location_spawned) then {
	[_flag] spawn mrkWIN;
};
