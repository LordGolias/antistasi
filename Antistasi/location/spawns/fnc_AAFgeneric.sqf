#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];
	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];

	private _posicion = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _isDestroyed = _location in AS_P("destroyedLocations");

	// spawn flag
	private _flag = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
	_flag allowDamage false;
	_vehiculos pushBack _flag;

	// spawn 2 patrols
	// _mrk => to be deleted at the end
	([_location, 2] call AS_fnc_spawnAAF_patrol) params ["_units1", "_groups1", "_mrk"];
	_soldados append _units1;
	_grupos append _groups1;

	// spawn workers
	if !(_isDestroyed) then {
		if ((daytime > 8) and (daytime < 18)) then {
			private _grupo = createGroup civilian;
			_grupos pushBack _grupo;

			private _civs = [];
			for "_i" from 1 to 8 do {
				private _civ = _grupo createUnit ["C_man_w_worker_F", _posicion, [],0, "NONE"];
				[_civ] call AS_fnc_initUnitCIV;
				_civs pushBack _civ;
			};
			[_location, _civs] spawn AS_fnc_location_canBeDestroyed;
			[leader _grupo, _location, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX","NOVEH2"] spawn UPSMON;
		};
	};

	// spawn truck
	([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
	_vehiculos append _vehicles1;

	// spawn guarding squads
	private _groupCount = round (_size/50);
	if (_location call AS_fnc_location_isFrontline) then {_groupCount = _groupCount * 2};
	_groupCount = _groupCount max 1;

	([_location, _groupCount] call AS_fnc_spawnAAF_patrolSquad) params ["_units1", "_groups1"];
	_soldados append _units1;
	_grupos append _groups1;

	[_location, _grupos] call AS_fnc_spawnJournalist;

	[_location, "resources", [taskNull, _grupos, _vehiculos, [_mrk]]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

AS_spawn_createAAFgeneric_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFgeneric_state_functions = [
	_fnc_spawn,
	AS_location_spawn_fnc_AAFwait_capture,
	AS_location_spawn_fnc_AAFlocation_clean
];
