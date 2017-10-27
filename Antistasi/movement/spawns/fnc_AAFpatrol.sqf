#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_spawnName"];
	private _location = [_spawnName, "location"] call AS_spawn_fnc_get;
	private _base = [_spawnName, "base"] call AS_spawn_fnc_get;
	private _aeropuerto = [_spawnName, "airfield"] call AS_spawn_fnc_get;
	private _useCSAT = [_spawnName, "useCSAT"] call AS_spawn_fnc_get;
	private _isDirectAttack = [_spawnName, "isDirectAttack"] call AS_spawn_fnc_get;
	private _threatEval = [_spawnName, "threatEval"] call AS_spawn_fnc_get;

	private _isLocation = false;
	private _position = "";
	if (typeName _location == typeName "") then {
		_isLocation = true;
		_position = _location call AS_location_fnc_position;
	} else {
		_position = _location;
	};

	// lists of spawned stuff to delete in the end.
	private _vehiculos = [];
	private _grupos = [];
	private _markers = [];

	// save the marker or position
	if _isLocation then {
		AS_Pset("patrollingLocations", AS_P("patrollingLocations") + [_location]);
	} else {
		AS_Pset("patrollingPositions", AS_P("patrollingPositions") + [_position]);

		// for a position, we need marker for the patrolling
		_location = createMarkerLocal [format ["%1patrolarea", random 100], _position];
		_location setMarkerShapeLocal "RECTANGLE";
		_location setMarkerSizeLocal [200, 200];
		_location setMarkerTypeLocal "hd_warning";
		_location setMarkerColorLocal "ColorRed";
		_location setMarkerBrushLocal "DiagGrid";
		_location setMarkerAlphaLocal 0;
		_markers pushBack _location;
	};

	if (_base != "") then {
		private _posorigen = _base call AS_location_fnc_position;
		_aeropuerto = "";
		if (!_isDirectAttack) then {[_base,20] call AS_location_fnc_increaseBusy;};

		private _toUse = "trucks";
		if (_threatEval > 3 and {"apcs" call AS_AAFarsenal_fnc_count > 0}) then {
			_toUse = "apcs";
		};
		if (_threatEval > 5 and {"tanks" call AS_AAFarsenal_fnc_count > 0}) then {
			_toUse = "tanks";
		};

		([_toUse, _posorigen, _location, _threatEval] call AS_fnc_spawnAAFlandAttack) params ["_groups1", "_vehicles1"];
		_grupos append _groups1;
		_vehiculos append _vehicles1;
	};

	if (_aeropuerto != "") then {
		if (!_isDirectAttack) then {[_aeropuerto,20] call AS_location_fnc_increaseBusy;};
		private _posorigen = _aeropuerto call AS_location_fnc_position;
		private _cuenta = 1;
		if (_isLocation) then {_cuenta = 2};
		for "_i" from 1 to _cuenta do {  // the attack has 2 units for a non-marker
			private _toUse = "helis_transport";  // last attack is always a transport

			// first attack (1/2) can be any unit, stronger the higher the treat
			if (_i < _cuenta) then {
				if ("helis_armed" call AS_AAFarsenal_fnc_count > 0) then {
					_toUse = "helis_armed";
				};
				if (_threatEval > 15 and ("planes" call AS_AAFarsenal_fnc_count > 0)) then {
					_toUse = "planes";
				};
			};
			([_toUse, _posorigen, _position] call AS_fnc_spawnAAFairAttack) params ["_groups1", "_vehicles1"];
			_grupos = _grupos + _groups1;
			_vehiculos = _vehiculos + _vehicles1;
			sleep 30;
		};
	};

	if _useCSAT then {
		([_location, 3, _threatEval] call AS_fnc_spawnCSATattack) params ["_groups1", "_vehicles1"];
		_grupos append _groups1;
		_vehiculos append _vehicles1;
	};

	[_spawnName, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_spawnName"];
	private _location = [_spawnName, "location"] call AS_spawn_fnc_get;
	private _isLocation = false;
	private _position = "";
	if (typeName _location == typeName "") then {
		_isLocation = true;
		_position = _location call AS_location_fnc_position;
	} else {
		_position = _location;
		_location = (([_spawnName, "resources"] call AS_spawn_fnc_get) select 2) select 0;
	};
	private _groups = (([_spawnName, "resources"] call AS_spawn_fnc_get) select 1);

	private _soldados = [];
	{
		_soldados append (units _x);
	} forEach _groups;

	if _isLocation then {
		private _tiempo = time + 3600;

		waitUntil {sleep 5;
			(({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or
			{{_x call AS_fnc_canFight} count _soldados == 0} or
			{_location call AS_location_fnc_side == "AAF"} or
			{time > _tiempo}
		};

		AS_Pset("patrollingLocations", AS_P("patrollingLocations") - [_location]);
		waitUntil {sleep 1; not (_location call AS_location_fnc_spawned)};
	} else {
		waitUntil {sleep 1; !([AS_P("spawnDistance"), _position, "BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance)};
		AS_Pset("patrollingPositions", AS_P("patrollingPositions") - [_position]);
	};
};

private _fnc_clean = {
	params ["_spawnName"];
	private _groups = (([_spawnName, "resources"] call AS_spawn_fnc_get) select 1);
	private _vehicles = (([_spawnName, "resources"] call AS_spawn_fnc_get) select 2);
	[_groups, _vehicles, []] call AS_fnc_cleanResources;
};

AS_spawn_patrolAAF_states = ["spawn", "run", "clean"];
AS_spawn_patrolAAF_state_functions = [
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
