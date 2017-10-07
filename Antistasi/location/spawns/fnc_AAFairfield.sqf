#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];

	private _posicion = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _frontera = _location call AS_fnc_location_isFrontline;
	private _busy = _location call AS_location_fnc_busy;

	// spawn flag
	private _flag = createVehicle [["AAF", "flag"] call AS_fnc_getEntity, _posicion, [],0, "CAN_COLLIDE"];
	_flag allowDamage false;
	_vehiculos pushBack _flag;

	// spawn crate
	private _veh = "I_supplyCrate_F" createVehicle _posicion;
	[_veh, "Airbase"] call AS_fnc_fillCrateAAF;
	_vehiculos pushBack _veh;

	// spawn AT road block
	private _grupo = createGroup side_red;
	_grupos pushBack _grupo;
	if ((_location call AS_location_fnc_spawned) and _frontera) then {
		([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
		_soldados append _units1;
		_vehiculos append _vehicles1;
	};

	// spawn 4 patrols
	// _mrk => to be deleted at the end
	([_location, 4] call AS_fnc_spawnAAF_patrol) params ["_units1", "_groups1", "_mrk"];
	_grupos append _groups1;

	// spawn parked air vehicles
	if (!_busy) then {
		private _buildings = nearestObjects [_posicion, ["Land_LandMark_F"], _size / 2];
		if (count _buildings > 1) then {
			private _pos1 = getPos (_buildings select 0);
			private _pos2 = getPos (_buildings select 1);
			private _ang = [_pos1, _pos2] call BIS_fnc_DirTo;

			private _pos = [_pos1, 5,_ang] call BIS_fnc_relPos;
			private _grupo = createGroup side_red;
			_grupos pushBack _grupo;

			private _count_vehicles = ["planes", "helis_armed", "helis_transport"] call AS_AAFarsenal_fnc_count;
			private _valid_vehicles = ["planes", "helis_armed", "helis_transport"] call AS_AAFarsenal_fnc_valid;
			for "_i" from 1 to (_count_vehicles min 5) do {
				if !(_location call AS_location_fnc_spawned) exitWith {};

				private _tipoveh = selectRandom _valid_vehicles;
				private _veh = createVehicle [_tipoveh, _pos, [],3, "NONE"];
				_veh setDir (_ang + 90);
				sleep 1;
				_vehiculos pushBack _veh;
				[_veh, "AAF"] call AS_fnc_initVehicle;
				private _pos = [_pos, 20,_ang] call BIS_fnc_relPos;
				private _unit = ([_posicion, 0, ["AAF", "pilot"] call AS_fnc_getEntity, _grupo] call bis_fnc_spawnvehicle) select 0;
				[_unit, false] spawn AS_fnc_initUnitAAF;
				_soldados pushBack _unit;
			};
			[leader _grupo, _location, "SAFE","SPAWNED","NOFOLLOW","NOVEH"] spawn UPSMON;
			sleep 1;
		};
	};

	// spawn parked land vehicles
	private _groupCount = round (_size/60);
	private _count_vehicles = ["trucks", "apcs"] call AS_AAFarsenal_fnc_count;
	private _valid_vehicles = ["trucks", "apcs"] call AS_AAFarsenal_fnc_valid;
	for "_i" from 1 to (_groupCount min _count_vehicles) do {
		if !(_location call AS_location_fnc_spawned) exitWith {};

		private _tipoveh = selectRandom _valid_vehicles;
		private _pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
		_veh setDir random 360;
		_vehiculos pushBack _veh;
		[_veh, "AAF"] call AS_fnc_initVehicle;
		sleep 1;
	};

	// spawn guarding squads
	if (_frontera) then {_groupCount = _groupCount * 2};
	([_location, 1 + _groupCount] call AS_fnc_spawnAAF_patrolSquad) params ["_units1", "_groups1"];
	_soldados append _units1;
	_grupos append _groups1;

	[_location, _grupos] call AS_fnc_spawnJournalist;

	[_location, "resources", [taskNull, _grupos, _vehiculos, [_mrk]]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

AS_spawn_createAAFairfield_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFairfield_state_functions = [
	_fnc_spawn,
	AS_location_spawn_fnc_AAFwait_capture,
	AS_location_spawn_fnc_AAFlocation_clean
];
