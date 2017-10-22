#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];
	private _pLarge = ["puesto_2","puesto_6","puesto_11","puesto_17","puesto_23"];

	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];

	_vehiculos append (_location call AS_fnc_spawnComposition);

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

	// flag and crate
	private _bandera = createVehicle [["AAF", "flag"] call AS_fnc_getEntity, _posicion, [],0, "CAN_COLLIDE"];
	_bandera allowDamage false;
	_vehiculos pushBack _bandera;
	private _caja = (["AAF", "box"] call AS_fnc_getEntity) createVehicle _posicion;
	_vehiculos pushBack _caja;

	{[_x, "AAF"] call AS_fnc_initVehicle;} forEach _vehiculos;

	if (_frontera) then {
		private _validBases = [["base"], "FIA"] call AS_location_fnc_TS;
		if (count _validBases > 0) then {
			private _base = [_validBases,_posicion] call BIS_fnc_nearestPosition;
			private _position = _base call AS_location_fnc_position;
			if (_position distance _posicion > 1000) then {
				private _pos = [_posicion] call AS_fnc_findMortarCreatePosition;
				private _static_mortar = ["AAF", "static_mortar"] call AS_fnc_getEntity;
				private _gunnerType = ["AAF", "gunner"] call AS_fnc_getEntity;
				private _veh = _static_mortar createVehicle _pos;
				[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
				private _unit = ([_posicion, 0, _gunnerType, _grupo] call bis_fnc_spawnvehicle) select 0;
				[_unit, false] spawn AS_fnc_initUnitAAF;
				[_veh, "AAF"] call AS_fnc_initVehicle;
				_unit moveInGunner _veh;
				_soldados pushBack _unit;
				_vehiculos pushBack _veh;
				sleep 1;
			};
		};
		([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
		_soldados append _units1;
		_vehiculos append _vehicles1;
	};

	// spawn truck
	([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
	_vehiculos append _vehicles1;

	// Create an AA team
	_grupo = [_posicion, side_red, [["AAF", "teamsAA"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;
	_grupos pushBack _grupo;
	{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x;} forEach units _grupo;
	[leader _grupo, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] spawn UPSMON;

	private _groupsCount = (round (_size/50)) max 1;
	if (_frontera) then {_groupsCount = _groupsCount * 2};

	if !(_location in _pLarge) then {
		_groupsCount = (round _groupsCount/2) max 1;

		_grupo = [_posicion, side_red, [["AAF", "teamsAA"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;
		_grupos pushBack _grupo;
		{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x;} forEach units _grupo;
		[leader _grupo, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] spawn UPSMON;
	};

	for "_i" from 1 to _groupsCount do {
		if !(_location call AS_location_fnc_spawned) exitWith {};
		_grupo = [_posicion, side_red, [["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;
		private _stance = "RANDOM";
		if (_i == 1) then {_stance = "RANDOMUP"};
		[leader _grupo, _location, "SAFE","SPAWNED",_stance,"NOVEH2","NOFOLLOW"] spawn UPSMON;
		_grupos pushBack _grupo;
		{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
	};

	[_location, _grupos] call AS_fnc_spawnJournalist;

	[_location, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

AS_spawn_createAAFoutpostAA_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFoutpostAA_state_functions = [
	_fnc_spawn,
	AS_location_spawn_fnc_AAFwait_capture,
	AS_location_spawn_fnc_AAFlocation_clean
];
