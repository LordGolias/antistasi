#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;
private _tanks = [_mission, "tanks"] call AS_fnc_object_get;

private _bases = [["base"], "FIA"] call AS_fnc_location_TS;
_bases = _bases select {not (_x call AS_fnc_location_spawned)};

private _debug_prefix = "NATOarmor: ";
if (count _bases == 0) exitWith {
	private _debug_message = "cancelled: no valid bases";
	AS_ISDEBUG(_debug_prefix + _debug_message);
    _mission call AS_fnc_mission_remove;
};

private _origin = [_bases, _location] call bis_fnc_nearestPosition;
private _originPos = _origin call AS_fnc_location_position;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = "NATO Armor";
private _tskDesc = format ["Our Commander asked NATO for an armored column departing from %2 with destination %1. Help them in order to have success in this operation. They will stay on mission until %3:%4.",
	[_location] call localizar,[_origin] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;

private _group = createGroup side_blue;
private _vehicles = [];

private _fnc_clean = {
	[[_group], _vehicles] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _group = createGroup side_blue;
_group setVariable ["esNATO",true,true];

private _wp0 = _group addWaypoint [_position, 0];
_wp0 setWaypointType "SAD";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";

private _tam = 10;
private _roads = [];
while {count _roads < _tanks} do {
	_roads = _originPos nearRoads _tam;
	_tam = _tam + 10;
};

for "_i" from 1 to _tanks do {
	private _vehicle = [position (_roads select (_i - 1)), 0, selectRandom bluMBT, _group] call bis_fnc_spawnvehicle;
	private _veh = _vehicle select 0;
	[_veh, "NATO"] call AS_fnc_initVehicle;
	[_veh, "NATO Armor"] call inmuneConvoy;
	private _vehCrew = _vehicle select 1;
	{[_x] call NATOinitCA} forEach _vehCrew;
	_vehicles pushBack _veh;
	_veh allowCrewInImmobile true;
	sleep 1;
};

waitUntil {sleep 10; (dateToNumber date > _fechalimnum) or {alive _x and canMove _x} count _vehicles == 0};

if ({alive _x and canMove _x} count _vehicles == 0) then {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
} else {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
};

call _fnc_clean;
