#include "../macros.hpp"
params ["_mission"];

private _origin = [_mission, "origin"] call AS_fnc_mission_get;
private _destinationPos = [_mission, "destinationPos"] call AS_fnc_mission_get;
private _support = [_mission, "NATOsupport"] call AS_fnc_mission_get;

private _originPos = _origin call AS_fnc_location_position;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = "NATO Armor";
private _tskDesc = format ["NATO is sending an armored section departing from %1. They will stay until %2:%3.",
	[_origin] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origin],_originPos,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;

private _group = createGroup side_blue;
private _vehicles = [];

private _fnc_clean = {
	[[_group], _vehicles] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

_group setVariable ["esNATO",true,true];

private _wp0 = _group addWaypoint [_destinationPos, 0];
_wp0 setWaypointType "SAD";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";

private _tanks = (round(_support/20)) min 4;
for "_i" from 1 to _tanks do {
	private _tam = 10;
	private _roads = [];
	while {count _roads == 0} do {
		_roads = _originPos nearRoads _tam;
		_tam = _tam + 10;
	};

	private _vehicle = [position (_roads select 0), 0, selectRandom bluMBT, _group] call bis_fnc_spawnvehicle;
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
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origin],_originPos,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
} else {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origin],_originPos,"SUCCEEDED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
};

call _fnc_clean;
