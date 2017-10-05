private _fnc_initialize = {
	params ["_mission"];
	private _location = [_mission, "origin"] call AS_mission_fnc_get;
	private _position = _location call AS_location_fnc_position;
	private _support = [_mission, "NATOsupport"] call AS_mission_fnc_get;

	private _tiempolim = _support;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = AS_NATOname + " Artillery support";
	private _tskDesc = format [AS_NATOname + " has given us control over their artillery at %1. They will be under our command until %2:%3.",
		[_location] call AS_fnc_location_name,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4
	];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, "target"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_spawn_fnc_get;
	private _support = [_mission, "NATOsupport"] call AS_mission_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _group = createGroup WEST;
	private _vehicles = [];

	_group setVariable ["esNATO",true,true];
	_group setGroupOwner (owner AS_commander);
	_group setGroupId ["N.Arty"];
	AS_commander hcSetGroup [_group];
	_group setVariable ["isHCgroup", true, true];

	private _tipoVeh = ["NATO", "static_mortar"] call AS_fnc_getEntity;
	private _units = 1;
	private _spread = 0;
	if (_support < 33) then {
		_units = 4;
		_spread = 15;
	} else {
		if (_support < 66) then {
			_tipoVeh = selectRandom (["NATO", "artillery1"] call AS_fnc_getEntity);
		} else {
			_units = 2;
			_spread = 20;
			_tipoVeh = selectRandom (["NATO", "artillery2"] call AS_fnc_getEntity);
		};
	};

	private _gunnerType = ["NATO", "gunner"] call AS_fnc_getEntity;
	for "_i" from 1 to _units do {
		private _unit = ([_position, 0, _gunnerType, _group] call bis_fnc_spawnvehicle) select 0;
		[_unit] call AS_fnc_initUnitNATO;
		private _pos = [_position] call AS_fnc_findSpawnSpots;
		private _veh = createVehicle [_tipoVeh, _pos, [], _spread, "NONE"];
		[_veh, "NATO"] call AS_fnc_initVehicle;
		_unit moveInGunner _veh;
		_vehicles pushBack _veh;
	};

	[_mission, "resources", [_task, [_group], _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _vehicles = ([_mission, "resources"] call AS_spawn_fnc_get) select 2;

	waitUntil {sleep 10; (dateToNumber date > _max_date) or ({alive _x} count _vehicles == 0)};

	if ({alive _x} count _vehicles == 0) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	} else {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	};
};

AS_mission_natoArtillery_states = ["initialize", "spawn", "run", "clean"];
AS_mission_natoArtillery_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
