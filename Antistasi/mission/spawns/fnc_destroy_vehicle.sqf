#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _tiempolim = 120;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
	private _fechalimnum = dateToNumber _fechalim;

	private _vehicleType = "";
	private _texto = "";

	if (["tanks"] call AS_AAFarsenal_fnc_count > 0) then {
		_vehicleType = selectRandom (["tanks"] call AS_AAFarsenal_fnc_valid);
		_texto = "Enemy Tank";
	} else {
		_vehicleType = selectRandom (["apcs"] call AS_AAFarsenal_fnc_valid);
		_texto = "Enemy APC";
	};

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = format [localize "STR_tskDesc_DesVehicle",
		[_location] call AS_fnc_location_name,
		numberToDate [2035,_fechalimnum] select 3,
		numberToDate [2035,_fechalimnum] select 4,
		_texto
	];

	[_mission, [_tskDesc,_tskTitle,_location], _position, "Destroy"] call AS_mission_spawn_fnc_saveTask;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	[_mission, "resources", [_task, [], [], []]] call AS_spawn_fnc_set;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "vehicleType", _vehicleType] call AS_spawn_fnc_set;
};

private _fnc_wait_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	waitUntil {sleep 1; False or _fnc_missionFailedCondition or {_location call AS_location_fnc_spawned}};

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		// we set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	};
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _vehicleType = [_mission, "vehicleType"] call AS_spawn_fnc_get;

	// spawn vehicle and crew
	private _pos = _position findEmptyPosition [10,60,_vehicleType];
	private _veh = createVehicle [_vehicleType, _pos, [], 0, "NONE"];
	_veh setDir random 360;
	[_veh, "AAF"] call AS_fnc_initVehicle;

	private _group = createGroup side_red;
	for "_i" from 1 to 3 do {
		private _unit = ([_pos, 0, ["AAF", "crew"] call AS_fnc_getEntity, _group] call bis_fnc_spawnvehicle) select 0;
		[_unit] spawn AS_fnc_initUnitAAF;
	};

	private _task = ([_mission, "resources"] call AS_spawn_fnc_get) select 0;
	[_mission, "resources", [_task, [_group], [_veh], []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _group = (([_mission, "resources"] call AS_spawn_fnc_get) select 1) select 0;
	private _veh = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};

	private _fnc_missionSuccessfulCondition = {
		(not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)
	};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission, getPos _veh] remoteExec ["AS_mission_fnc_success", 2];
	};

	private _fnc_becomeAwareCondition = {
		// condition for the crew to become aware of danger
		({leader _group knowsAbout _x > 1.4} count ([AS_P("spawnDistance"), leader _group, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0)
	};

	waitUntil {sleep 1;
		False or _fnc_becomeAwareCondition or _fnc_missionSuccessfulCondition or _fnc_missionFailedCondition
	};

	if (call _fnc_becomeAwareCondition) then {
		_group addVehicle _veh;
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_destroyVehicle_states = ["initialize", "wait_spawn", "spawn", "run", "clean"];
AS_mission_destroyVehicle_state_functions = [
	_fnc_initialize,
	_fnc_wait_spawn,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
