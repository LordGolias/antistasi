private _fnc_initialize = {
	params ["_mission"];
	private _support = [_mission, "NATOsupport"] call AS_mission_fnc_get;
	private _aeropuertos = (["airfield", "FIA"] call AS_location_fnc_TS) + ["spawnNATO"];

	private _origin = [_aeropuertos,AS_commander] call BIS_fnc_nearestPosition;
	private _position = _origin call AS_location_fnc_position;

	private _tiempolim = _support;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _nombreorig = format ["the %1 Carrier", (["NATO", "name"] call AS_fnc_getEntity)];
	if (_origin != "spawnNATO") then {
		_nombreorig = [_origin] call AS_fnc_location_name
	};

	private _tskTitle = (["NATO", "name"] call AS_fnc_getEntity) + " CAS";
	private _tskDesc = format [(["NATO", "name"] call AS_fnc_getEntity) + " is providing air support from %1. They will be under our command in 30s and until %2:%3.",
		_nombreorig,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4
	];

	private _mission = ["nato_cas", ""] call AS_mission_fnc_add;
	[_mission, "status", "active"] call AS_mission_fnc_set;

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_origin], _position, "Attack"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_spawn_fnc_get;
	private _support = [_mission, "NATOsupport"] call AS_mission_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _groups = [];
	private _vehicles = [];

	private _tipoVeh = bluHeliArmed;
	if (_support > 70) then {
		_tipoVeh = bluCASFW;
	} else {
		if (_support > 30) then {
			_tipoVeh = bluHeliGunship;
		};
	};

	private _grupoHeli = createGroup side_blue;
	_grupoHeli setGroupId ["CAS"];
	_groups pushBack _grupoHeli;

	for "_i" from 1 to 3 do {
		private _helifn = [_position, 0, selectRandom _tipoVeh, side_blue] call bis_fnc_spawnvehicle;
		private _heli = _helifn select 0;
		_vehicles pushBack _heli;
		private _heliCrew = _helifn select 1;
		private _grupoheliTmp = _helifn select 2;
		{[_x] spawn AS_fnc_initUnitNATO; [_x] join _grupoHeli} forEach _heliCrew;
		deleteGroup _grupoheliTmp;
		[_heli, "NATO"] call AS_fnc_initVehicle;
		_heli setPosATL [getPosATL _heli select 0, getPosATL _heli select 1, 1000];
		_heli flyInHeight 300;
		sleep 10;
	};
	AS_commander hcSetGroup [_grupoHeli];
	_grupoHeli setVariable ["isHCgroup", true, true];

	[_mission, "resources", [_task, _groups, _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _vehicles = ([_mission, "resources"] call AS_spawn_fnc_get) select 2;

	private _fnc_missionFailedCondition = {({alive _x} count _vehicles == 0) or ({canMove _x} count _vehicles == 0)};
	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
	private _fnc_missionSuccessfulCondition = {dateToNumber date > _max_date};
	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_natoCAS_states = ["initialize", "spawn", "run", "clean"];
AS_mission_natoCAS_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
