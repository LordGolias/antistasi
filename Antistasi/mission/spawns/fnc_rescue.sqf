
private _fnc_initialize = {
	params ["_mission"];
	private _missionType = _mission call AS_mission_fnc_type;
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _tiempolim = 30;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = call {
		if (_missionType == "rescue_prisioners") exitWith {
			format [localize "STR_tskDesc_resPrisoners",
				[_location] call AS_fnc_location_name,
				numberToDate [2035,dateToNumber _fechalim] select 3,
				numberToDate [2035,dateToNumber _fechalim] select 4
			]
		};
		if (_missionType == "rescue_refugees") exitWith {
			format [localize "STR_tskDesc_resRefugees", [_location] call AS_fnc_location_name, A3_STR_INDEP]
		};
		""
	};

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, "run"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _missionType = _mission call AS_mission_fnc_type;
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _initSurvivor = {
		params ["_unit"];
		_unit allowDamage false;
		_unit setCaptive true;
		_unit disableAI "MOVE";
		_unit disableAI "AUTOTARGET";
		_unit disableAI "TARGET";
		_unit setBehaviour "CARELESS";
		_unit allowFleeing 0;
		removeAllWeapons _unit;
		removeAllAssignedItems _unit;
		_unit setUnitPos "UP";
	};

	private _grpPOW = createGroup side_blue;
	if (_missionType == "rescue_prisioners") then {
		private _prisioners = 5 + round random 10;

		for "_i" from 1 to _prisioners do {
			private _unit = _grpPOW createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, [_position, 5, random 360] call BIS_Fnc_relPos, [], 0, "NONE"];
			_unit call _initSurvivor;
			[[_unit, "prisionero"],"AS_fnc_addAction"] call BIS_fnc_MP;
			sleep 1;
		};
	};
	if (_missionType == "rescue_refugees") then {
		// get a house with at least 5 positions
		private _size = _location call AS_location_fnc_size;
		private _houses = nearestObjects [_position, ["house"], _size];
		private _house_positions = [];
		private _house = _houses select 0;
		while {count _house_positions < 5} do {
			_house = selectRandom _houses;
			_house_positions = [_house] call BIS_fnc_buildingPositions;
			if (count _house_positions < 5) then {
				_houses = _houses - [_house]
			};
		};
		// update position
		_position = position _house;

		private _num = (count _house_positions) max 8;
		for "_i" from 0 to _num - 1 do {
			private _unit = _grpPOW createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, _house_positions select _i, [], 0, "NONE"];
			_unit call _initSurvivor;
			_unit setSkill 0;
			[[_unit,"refugiado"],"AS_fnc_addAction"] call BIS_fnc_MP;
			sleep 1;
		};

		// send a patrol
		[_position, _mission] spawn {
			params ["_position", "_mission"];
			sleep (5*60 + random (15*60));
			if (_mission call AS_mission_fnc_status == "active") then {
				[[_position], "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];
			};
		};
	};
	{_x allowDamage true} forEach units _grpPOW;

	private _task = ([_mission, "CREATED", "", _position] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	[_mission, "resources", [_task, [_grpPOW], [], []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _grpPOW = (([_mission, "resources"] call AS_spawn_fnc_get) select 1) select 0;
	private _pows = units _grpPOW;

	private _fnc_missionFailedCondition = {{alive _x} count _pows < (count _pows)/2};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission,  {not alive _x or captive _x} count _pows] remoteExec ["AS_mission_fnc_fail", 2];

		{_x setCaptive false} forEach _pows;
	};

	private _fnc_missionSuccessfulCondition = {
		{(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _pows >
		 ({alive _x} count _pows) / 2
	 };

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission,  {alive _x} count _pows] remoteExec ["AS_mission_fnc_success", 2];

		{[_x] join _grpPOW; [_x] orderGetin false} forEach _pows;
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};


AS_mission_rescue_states = ["initialize", "spawn", "run", "clean"];
AS_mission_rescue_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
