#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];

	private _posicion = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _frontera = _location call AS_fnc_location_isFrontline;

	private _grupo = createGroup side_red;
	_grupos pushBack _grupo;

	([_location, "AAF", _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
	{[_x, false] call AS_fnc_initUnitAAF} forEach _gunners;
	{[_x, "AAF"] call AS_fnc_initVehicle} forEach _vehicles;
	_soldados append _gunners;
	_vehiculos append _vehicles;

	// create flag
	private _bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
	_bandera allowDamage false;
	_vehiculos pushBack _bandera;
	private _caja = "I_supplyCrate_F" createVehicle _posicion;
	_vehiculos pushBack _caja;
	{[_x, "AAF"] call AS_fnc_initVehicle;} forEach _vehiculos;

	if (_location call AS_location_fnc_type == "seaport") then {
		private _pos = [_posicion,_size,_size*3,10,2,0,0] call BIS_Fnc_findSafePos;
		([_pos, 0,vehBoat, side_red] call bis_fnc_spawnvehicle) params ["_veh", "_vehCrew", "_grupoVeh"];
		[_veh, "AAF"] call AS_fnc_initVehicle;
		{[_x, false] spawn AS_fnc_initUnitAAF} forEach _vehCrew;
		_soldados append _vehCrew;
		_grupos pushBack _grupoVeh;
		_vehiculos pushBack _veh;
		sleep 1;
	} else {
		if (_frontera) then {
			private _validBases = [["base"], "FIA"] call AS_location_fnc_TS;
			if (count _validBases > 0) then {
				private _base = [_validBases,_posicion] call BIS_fnc_nearestPosition;
				private _position = _base call AS_location_fnc_position;
				if (_position distance _posicion > 1000) then {
					private _pos = [_posicion] call AS_fnc_findMortarCreatePosition;
					private _veh = statMortar createVehicle _pos;
					[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
					private _unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
					[_unit, false] spawn AS_fnc_initUnitAAF;
					[_veh, "AAF"] call AS_fnc_initVehicle;
					_unit moveInGunner _veh;
					_soldados pushBack _unit;
					_vehiculos pushBack _veh;
					sleep 1;
				};
			};
		};

		if ((_location call AS_location_fnc_spawned) and _frontera) then {
			([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
			_soldados append _units1;
			_vehiculos append _vehicles1;
		};
	};

	// spawn truck
	([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
	_vehiculos append _vehicles1;

	private _groupCount = round (_size/50);
	if (_frontera) then {_groupCount = _groupCount * 2};
	_groupCount = _groupCount max 1;

	// spawn guarding squads
	([_location, _groupCount] call AS_fnc_spawnAAF_patrolSquad) params ["_units1", "_groups1"];
	_soldados append _units1;
	_grupos append _groups1;

	[_location, _grupos] call AS_fnc_spawnJournalist;

	[_location, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

AS_spawn_createAAFoutpost_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFoutpost_state_functions = [
	_fnc_spawn,
	AS_location_spawn_fnc_AAFwait_capture,
	AS_location_spawn_fnc_AAFlocation_clean
];
