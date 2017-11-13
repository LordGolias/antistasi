#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	private _posicion = _location call AS_location_fnc_position;
	private _grupo = createGroup side_blue;

	// find road
	private _tam = 1;
	private _roads = [];
	while {count _roads == 0} do {
		_roads = _posicion nearRoads _tam;
		_tam = _tam + 5;
	};
	private _road = (_roads select 0);

	private _dirveh = [_road, (roadsConnectedto _road) select 0] call BIS_fnc_DirTo;

	// spawn the structures
	private _objs = [getpos _road, _dirveh, call AS_fnc_bluRoadblock] call BIS_fnc_ObjectsMapper;

	private _vehArray = [];
	private _turretArray = [];
	private _tempPos = [];
	{
		call {
			if (typeOf _x in bluAPC) exitWith {_vehArray pushBack _x;};
			if (typeOf _x in bluStatHMG) exitWith {_turretArray pushBack _x;};
			if (typeOf _x in bluStatAA) exitWith {_turretArray pushBack _x;};
			if (typeOf _x == "Land_Camping_Light_F") exitWith {_tempPos = _x;};
		};
	} forEach _objs;

	// spawn crew for statics
	{
		// AAs are not spawned below 50
		if (AS_P("NATOsupport") < 50 and (typeOf _x in bluStatAA)) then {
			_x enableSimulation false;
		    _x hideObjectGlobal true;
		} else {
			private _unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
			_unit moveInGunner _x;
			[_x, "NATO"] call AS_fnc_initVehicle;
		};
	} forEach _turretArray;

	// spawn crew for vehicles
	{
		[_x, "NATO"] call AS_fnc_initVehicle;
		_x allowCrewInImmobile true;
		private _unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _x;
		_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInCommander _x;
	} forEach _vehArray;

	// init units
	{[_x] spawn AS_fnc_initUnitNATO} forEach units _grupo;

	// spawn infantry group
	private _grupoInf = [getpos _tempPos, side_blue, [bluATTeam, "NATO"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;

	private _infdir = _dirveh + 180;
	if (_infdir >= 360) then {_infdir = _infdir - 360};
	_grupoInf setFormDir _infdir;

	{[_x] spawn AS_fnc_initUnitNATO} forEach units _grupoInf;

	[_location, "resources", [taskNull, [_grupo, _grupoInf], _objs, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", units _grupoInf + units _grupo] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_location"];
	private _posicion = _location call AS_location_fnc_position;

	private _soldiers = [_location, "soldiers"] call AS_spawn_fnc_get;

	private _fnc_isDestroyed = {
		{alive _x and not (_x call AS_medical_fnc_isUnconscious)} count _soldiers == 0
	};

	waitUntil {sleep 1;
		!(_location call AS_location_fnc_spawned) or
		!(_location call AS_location_fnc_exists) or
		(call _fnc_isDestroyed)
	};

	// Lost the outpost
	if (call _fnc_isDestroyed) then {
		_location call AS_location_fnc_remove;
		[5,-5,_posicion] remoteExec ["AS_fnc_changeCitySupport",2];
		[["TaskFailed", ["", "Roadblock Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
};

private _fnc_clean = {
	params ["_location"];
	waitUntil {sleep 1; not (_location call AS_location_fnc_spawned)};

	([_location, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
};

AS_spawn_createNATOroadblock_states = ["spawn", "run", "clean"];
AS_spawn_createNATOroadblock_state_functions = [
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
