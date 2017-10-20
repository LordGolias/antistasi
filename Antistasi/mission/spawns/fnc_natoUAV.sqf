private _fnc_initialize = {
	params ["_mission"]; // spawn name = mission name
	private _airports = (["airfield", "FIA"] call AS_location_fnc_TS) + ["spawnNATO"];

	private _origin = [_airports, AS_commander] call BIS_fnc_nearestPosition;

	private _tiempolim = 30;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _nombreorig = format ["the %1 Carrier", (["NATO", "name"] call AS_fnc_getEntity)];
	private _position = getMarkerPos _origin;
	if (_origin != "spawnNATO") then {
		_nombreorig = [_origin] call AS_fnc_location_name;
		_position = _origin call AS_location_fnc_position;
	};
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;

	private _tskDesc = format ["%1 is providing a UAV from %2. It will be under our command in a few seconds and until %3:%4.",
	                           (["NATO", "name"] call AS_fnc_getEntity),
							   _nombreorig,
							   numberToDate [2035,dateToNumber _fechalim] select 3,
							   numberToDate [2035,dateToNumber _fechalim] select 4];
	private _tskTitle = (["NATO", "name"] call AS_fnc_getEntity) + " UAV";

	[_mission, [_tskDesc,_tskTitle,_origin], _position, "Attack"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_spawn_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _groups = [];
	private _vehicles = [];

	private _grupoHeli = createGroup side_blue;
	_groups pushBack _grupoHeli;
	_grupoHeli setGroupId ["UAV"];

	private _helifn = [_position, 0, selectRandom (["NATO", "uavs_attack"] call AS_fnc_getEntity), side_blue] call bis_fnc_spawnvehicle;
	private _heli = _helifn select 0;
	_vehicles pushBack _heli;
	createVehicleCrew _heli;
	{[_x] call AS_fnc_initUnitNATO; [_x] join _grupoHeli} forEach (crew _heli);
	_heli setPosATL [getPosATL _heli select 0, getPosATL _heli select 1, 1000];
	_heli flyInHeight 300;

	sleep 5;

	AS_commander hcSetGroup [_grupoHeli];
	_grupoHeli setVariable ["isHCgroup", true, true];

	[_mission, "resources", [_task, _groups, _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _vehicles = ([_mission, "resources"] call AS_spawn_fnc_get) select 2;
	waitUntil {sleep 1;
		(dateToNumber date > _max_date) or
		({alive _x or canMove _x} count _vehicles == 0)
	};

	if (dateToNumber date > _max_date) then {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
};

AS_mission_natoUAV_states = ["initialize", "spawn", "run", "clean"];
AS_mission_natoUAV_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
