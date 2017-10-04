#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _origin = [_mission, "origin"] call AS_mission_fnc_get;
	private _position = _origin call AS_location_fnc_position;

	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = AS_NATOname + " Armor column";
	private _tskDesc = format ["%1 is sending an armored section departing from %2. They will stay until %3:%4.",
		AS_NATOname,
		[_origin] call AS_fnc_location_name,
		numberToDate [2035, dateToNumber _fechalim] select 3,numberToDate [2035, dateToNumber _fechalim] select 4];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_origin], _position, "Attack"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_spawn_fnc_get;
	private _destinationPos = [_mission, "destinationPos"] call AS_mission_fnc_get;
	private _support = [_mission, "NATOsupport"] call AS_mission_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _group = createGroup side_blue;
	private _vehicles = [];

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
			_roads = _position nearRoads _tam;
			_tam = _tam + 10;
		};

		private _type = selectRandom (["NATO", "mbts"] call AS_fnc_getEntity);
		private _vehicle = [position (_roads select 0), 0, _type, _group] call bis_fnc_spawnvehicle;
		private _veh = _vehicle select 0;
		[_veh, "NATO"] call AS_fnc_initVehicle;
		[_veh, "NATO Armor"] call AS_fnc_setConvoyImmune;
		private _vehCrew = _vehicle select 1;
		{[_x] call AS_fnc_initUnitNATO} forEach _vehCrew;
		_vehicles pushBack _veh;
		_veh allowCrewInImmobile true;
		sleep 1;
	};

	[_mission, "resources", [_task, [_group], _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _vehicles = ([_mission, "resources"] call AS_spawn_fnc_get) select 2;

	waitUntil {sleep 10;
		(dateToNumber date > _max_date) or
		{alive _x and canMove _x} count _vehicles == 0
	};

	if (dateToNumber date > _max_date) then {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
};

AS_mission_natoArmor_states = ["initialize", "spawn", "run", "clean"];
AS_mission_natoArmor_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
