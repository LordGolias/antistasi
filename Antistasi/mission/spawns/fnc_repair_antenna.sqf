#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = [AS_P("antenasPos_dead"), _location call AS_location_fnc_position] call BIS_fnc_nearestPosition;

	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = format [localize "STR_tskDesc_repAntenna",
		[_location] call AS_fnc_location_name,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4,
		AS_AAFname
	];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, "Destroy"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_wait_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	// wait location to be spawned to spawn everything
	waitUntil {sleep 1; False or _fnc_missionFailedCondition or (_location call AS_location_fnc_spawned)};

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 4] call AS_spawn_fnc_set;
	};
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_spawn_fnc_get;

	private _vehicleType = selectRandom (["AAF", "repairVehicles"] call AS_fnc_getEntity);

	private _pos = _position findEmptyPosition [10,60,_vehicleType];
	private _veh = createVehicle [_vehicleType, _pos, [], 0, "NONE"];
	_veh allowdamage false;
	_veh setDir random 360;
	_veh allowDamage true;
	[_veh, "AAF"] call AS_fnc_initVehicle;

	// repair soldiers
	private _group = createGroup side_red;
	for "_i" from 1 to 3 do {
		private _unit = ([_pos, 0, ["AAF", "crew"] call AS_fnc_getEntity, _group] call bis_fnc_spawnvehicle) select 0;
		[_unit] call AS_fnc_initUnitAAF;
	};

	private _task = ([_mission, "resources"] call AS_spawn_fnc_get) select 0;
	[_mission, "resources", [_task, [[_group], [_veh], []]]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;

	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _veh = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;

	private _fnc_missionSuccessfulCondition = {not alive _veh or (_location call AS_location_fnc_side == "FIA")};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	};

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_repairAntenna_states = ["initialize", "spawn_wait_spawn", "wait_spawn", "spawn", "run", "clean"];
AS_mission_repairAntenna_state_functions = [
	_fnc_initialize,
	AS_mission_spawn_fnc_wait_spawn,
	_fnc_wait_spawn,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
