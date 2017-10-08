#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_spawnName"];
	private _location = [_spawnName, "location"] call AS_spawn_fnc_get;

	if (_location call AS_location_fnc_type != "city") exitWith {
		diag_log format ["[AS] ERROR: createCIV called with non-city: '%1'", _location];
	};

	private _numCiv = [_location, "population"] call AS_location_fnc_get;
	private _numVeh = _numCiv/10;

	private _posicion = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _roads = [_location, "roads"] call AS_location_fnc_get;

	private _grupos = [];
	private _vehiculos = [];

	if (_location in AS_P("destroyedLocations")) then {
		_numCiv = _numCiv / 10;
		_numVeh = _numVeh / 10;
	};
	_numVeh = round (_numVeh * AS_P("civPerc"));
	if (_numVeh < 1) then {_numVeh = 1};

	_numCiv = round (_numCiv * AS_P("civPerc"));
	if ((daytime < 8) or (daytime > 21)) then {
		_numCiv = round (_numCiv/4);
		_numVeh = round (_numVeh * 1.5)
	};
	if (_numCiv < 1) then {_numCiv = 1};

	private _grupo = createGroup civilian;
	_grupos pushBack _grupo;

	for "_i" from 1 to _numCiv do {
		private _pos = [];
		while {true} do {
			_pos = [_posicion, round (random _size), random 360] call BIS_Fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
		};
		private _civ = _grupo createUnit [selectRandom (["CIV", "units"] call AS_fnc_getEntity), _pos, [],0, "NONE"];
		[_civ] spawn AS_fnc_initUnitCIV;
	};

	// spawn parked cars
	private _counter = 0;  // how many vehicles were already spawned.
	while {_counter < _numVeh} do {
		private _p1 = selectRandom _roads;
		private _road = (_p1 nearRoads 5) select 0;
		if (!isNil "_road") then {
			private _p2 = getPos ((roadsConnectedto _road) select 0);
			private _dirveh = [_p1,_p2] call BIS_fnc_DirTo;
			private _pos = [_p1, 3, _dirveh + 90] call BIS_Fnc_relPos;
			private _type = (arrayCivVeh call BIS_Fnc_selectRandom);
			if (count (_pos findEmptyPosition [0,5,_type]) > 0) then {
				private _veh = _type createVehicle _pos;
				_veh setDir _dirveh;
				_vehiculos pushBack _veh;
				[_veh] spawn AS_fnc_initVehicleCiv;
				_counter = _counter + 1;
			};
		};
	};

	[_location, _grupos] call AS_fnc_spawnJournalist;

	[leader _grupo, _location, "SAFE", "SPAWNED","NOFOLLOW", "NOVEH2","NOSHARE","DoRelax"] spawn UPSMON;

	private _patrolCiudades = _location call AS_fnc_getCitiesToCivPatrol;

	// spawn moving cars
	for "_i" from 1 to _numVeh do {
		if !(_location call AS_location_fnc_spawned) exitwith {};
		private _road = selectRandom _roads;
		private _p1 = getPos _road;
		private _grupoP = createGroup civilian;
		_grupos pushBack _grupoP;
		private _p2 = getPos ((roadsConnectedto _road) select 0);
		private _dirveh = [_p1,_p2] call BIS_fnc_DirTo;

		private _veh = (arrayCivVeh call BIS_Fnc_selectRandom) createVehicle _p1;
		[_veh] spawn AS_fnc_initVehicleCiv;
		_veh setDir _dirveh;
		_vehiculos pushBack _veh;

		// spawn driver
		private _civ = _grupoP createUnit [selectRandom (["CIV", "units"] call AS_fnc_getEntity), _p1, [],0, "NONE"];
		[_civ] spawn AS_fnc_initUnitCIV;
		_civ moveInDriver _veh;
		_grupoP addVehicle _veh;

		// set waypoints
		_grupoP setBehaviour "CARELESS";
		private _wp = _grupoP addWaypoint [(selectRandom _patrolCiudades) call AS_location_fnc_position,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointTimeout [30, 45, 60];
		_wp = _grupoP addWaypoint [_posicion,1];
		_wp setWaypointType "MOVE";
		_wp setWaypointTimeout [30, 45, 60];
		private _wp1 = _grupoP addWaypoint [_posicion,0];
		_wp1 setWaypointType "CYCLE";
		_wp1 synchronizeWaypoint [_wp];
	};

	[_spawnName, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
};

private _fnc_clean = {
	params ["_spawnName"];
	private _location = [_spawnName, "location"] call AS_spawn_fnc_get;
	waitUntil {sleep 1;not (_location call AS_location_fnc_spawned)};

	([_spawnName, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
};

AS_spawn_createCIVcity_states = ["spawn", "clean"];
AS_spawn_createCIVcity_state_functions = [
	_fnc_spawn,
	_fnc_clean
];
