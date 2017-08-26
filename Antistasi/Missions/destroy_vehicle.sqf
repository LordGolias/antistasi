#include "../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _tiempolim = 120;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
	private _fechalimnum = dateToNumber _fechalim;

	private _vehicleType = "";
	private _texto = "";

	private _tanks = ["tanks"] call AS_fnc_AAFarsenal_all;
	if (count _tanks > 0) then {
		_vehicleType = selectRandom _tanks;
		_texto = "Enemy Tank";
	} else {
		_vehicleType = selectRandom (["apcs"] call AS_fnc_AAFarsenal_valid);
		_texto = "Enemy APC";
	};

	private _tskTitle = _mission call AS_fnc_mission_title;
	private _tskDesc = format [localize "STR_tskDesc_DesVehicle",
		[_location] call localizar,
		numberToDate [2035,_fechalimnum] select 3,
		numberToDate [2035,_fechalimnum] select 4,
		_texto
	];

	[_mission, [_tskDesc,_tskTitle,_location], _position, "Destroy"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "vehicleType", _vehicleType] call AS_spawn_fnc_set;
};

private _fnc_wait_spawn = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	waitUntil {sleep 1; False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

	if (dateToNumber date > _max_date) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];

		// we set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 4] call AS_spawn_fnc_set;
	};
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;
	private _vehicleType = ["_mission", "vehicleType"] call AS_spawn_fnc_get;

	// spawn vehicle and crew
	private _pos = _position findEmptyPosition [10,60,_vehicleType];
	private _veh = createVehicle [_vehicleType, _pos, [], 0, "NONE"];
	_veh setDir random 360;
	[_veh, "AAF"] call AS_fnc_initVehicle;

	private _group = createGroup side_red;
	for "_i" from 1 to 3 do {
		private _unit = ([_pos, 0, sol_CREW, _group] call bis_fnc_spawnvehicle) select 0;
		[_unit] spawn AS_fnc_initUnitAAF;
		sleep 2;
	};

	private _task = ([_mission, "resources"] call AS_spawn_fnc_get) select 0;
	[_mission, "resources", [_task, [[_group], [_veh], []]]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _group = (([_mission, "resources"] call AS_spawn_fnc_set) select 1) select 0;
	private _veh = (([_mission, "resources"] call AS_spawn_fnc_set) select 2) select 0;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];
	};

	private _fnc_missionSuccessfulCondition = {
		(not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)
	};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission, getPos _veh] remoteExec ["AS_fnc_mission_success", 2];
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

AS_mission_destroyVehicle_states = ["initialize", "spawn_wait_spawn", "wait_spawn", "spawn", "run", "clean"];
AS_mission_destroyVehicle_state_functions = [
	_fnc_initialize,
	AS_mission_fnc_spawn_wait_spawn,
	_fnc_wait_spawn,
	_fnc_spawn,
	_fnc_run,
	AS_mission_fnc_clean
];
