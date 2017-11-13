
private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _tiempolim = 60;  // 1h
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = format [localize "STR_tskDesc_logAmmo",
		[_location] call AS_fnc_location_name,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4];

	[_mission, [_tskDesc,_tskTitle,_location], _position, "rearm"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
};

private _fnc_wait_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	waitUntil {sleep 1;False or {dateToNumber date > _max_date} or (_location call AS_location_fnc_spawned)};

	if (dateToNumber date > _max_date) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		// we set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 4] call AS_spawn_fnc_set;
	};

	[_mission, "resources", [_task, [[], [], []]]] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _size = [_mission, "size"] call AS_mission_fnc_get;

	private _pos = [];
	while {count _pos > 0} do {
		_pos = _position findEmptyPosition [10,_size, vehAmmo];
		_size = _size + 20
	};

	private _vehicles = [];
	private _groups = [];

	private _truck = vehAmmo createVehicle _pos;
	_vehicles pushBack _truck;
	[_truck, "Convoy"] call AS_fnc_fillCrateAAF;

	// patrol marker. To be deleted in the end
	private _mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _pos];
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [20,20];
	_mrk setMarkerTypeLocal "hd_warning";
	_mrk setMarkerColorLocal "ColorRed";
	_mrk setMarkerBrushLocal "DiagGrid";
	_mrk setMarkerAlphaLocal 0;

	// patrol groups
	for "_i" from 1 to (2 + floor random 3) do {
		private _tipoGrupo = [infGarrisonSmall, "AAF"] call AS_fnc_pickGroup;
		private _group = [_pos, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
		_groups append _group;
		if (random 10 < 33) then {
			private _perro = _group createUnit ["Fin_random_F",_pos,[],0,"FORM"];
			[_perro] spawn AS_AI_fnc_initDog;
		};
		[leader _group, _mrk, "SAFE","SPAWNED", "NOVEH2"] spawn UPSMON;
		{[_x, false] call AS_fnc_initUnitAAF} forEach units _group;
	};

	private _task = ([_mission, "resources"] call AS_spawn_fnc_get) select 0;
	[_mission, "resources", [_task, [_groups, _vehicles, []]]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];

	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _vehicles = ([_mission, "resources"] call AS_spawn_fnc_get) select 2;

	private _truck = _vehicles select 0;
	private _fnc_missionSuccessfulCondition = {({_x getVariable ["BLUFORSpawn",false]} count crew _truck > 0)};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission, getPos _truck] remoteExec ["AS_mission_fnc_success", 2];
	};

	private _fnc_missionFailedCondition = {(not alive _truck) or {dateToNumber date > _max_date}};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
	[[position _truck], "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];
};

AS_mission_stealAmmo_states = ["initialize", "spawn_wait_spawn", "wait_spawn", "spawn", "run", "clean"];
AS_mission_stealAmmo_state_functions = [
	_fnc_initialize,
	AS_mission_spawn_fnc_wait_spawn,
	_fnc_wait_spawn,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
