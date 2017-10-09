#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _taskTitle = _mission call AS_mission_fnc_title;
	private _taskDesc = format [localize "STR_tskDesc_logSupply",
		[_location] call AS_fnc_location_name,
		_location,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4
	];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;
	[_mission, [_taskDesc,_taskTitle,_location], _position, "Heal"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _truckType = selectRandom (["FIA", "vans"] call AS_fnc_getEntity);
	private _pos = (getMarkerPos "FIA_HQ") findEmptyPosition [1,50,_truckType];

	private _truck = _truckType createVehicle _pos;
	[_truck, "FIA"] call AS_fnc_initVehicle;
	{_x reveal _truck} forEach (allPlayers - (entities "HeadlessClient_F"));
	[_truck,"Mission Vehicle"] spawn AS_fnc_setConvoyImmune;

	[_mission, "resources", [_task, [], [_truck], []]] call AS_spawn_fnc_set;
};

private _fnc_wait = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _truck = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _fnc_missionFailedCondition = {
		(not alive _truck) or (dateToNumber date > _max_date)
	};

	waitUntil {sleep 1; (_truck distance _position < 40) and (speed _truck < 1) or _fnc_missionFailedCondition};

	if (call _fnc_missionFailedCondition) exitWith {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	};
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _truck = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	[[_position], "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];

	private _fnc_unloadCondition = {
		// The condition to allow loading the crates into the truck
		(_truck distance _position < 20) and {speed _truck < 1} and
		{{alive _x and not (_x call AS_medical_fnc_isUnconscious)} count ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0} and
		{{(side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
	};

	private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";

	// make all FIA around the truck non-captive
	{
		private _soldierFIA = _x;
		if (captive _soldierFIA) then {
			[_soldierFIA,false] remoteExec ["setCaptive",_soldierFIA];
		};
	} forEach ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

	{
		// make all enemies around notice the truck
		if ((side _x == side_red) and {_x distance _position < AS_P("spawnDistance")}) then {
			if (_x distance _position < 300) then {
				_x doMove position _truck;
			} else {
				_x reveal [_truck, 4];
			};
		};
		// send all nearby civilians to the truck
		if ((side _x == civilian) and {_x distance _position < AS_P("spawnDistance")} and {_x distance _position < 300}) then {_x doMove position _truck};
	} forEach allUnits;

	private _fnc_missionFailedCondition = {
		(not alive _truck) or (dateToNumber date > _max_date)
	};

	// wait for the truck to unload (2m) or the mission to fail
	[_truck, 120, _fnc_unloadCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	} else {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	};

	// eject and lock truck
	{
		_x action ["eject", _truck];
	} forEach (crew _truck);
	sleep 1;
	_truck lock 2;
	{if (isPlayer _x) then {[_truck,true] remoteExec ["AS_fnc_lockVehicle",_x];}} forEach ([100, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
	_truck engineOn false;
};

AS_mission_sendMeds_states = ["initialize", "spawn", "run", "clean"];
AS_mission_sendMeds_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
