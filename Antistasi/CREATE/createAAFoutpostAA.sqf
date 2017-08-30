#include "../macros.hpp"

private _fnc_spawn = {
	params ["_location"];
	private _pLarge = ["puesto_2","puesto_6","puesto_11","puesto_17","puesto_23"];

	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];

	private _posicion = _location call AS_fnc_location_position;
	private _size = _location call AS_fnc_location_size;
	private _frontera = _location call isFrontline;

	private _grupo = createGroup side_red;
	_grupos pushBack _grupo;

	([_location, side_red, _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
	_soldados append _gunners;
	_vehiculos append _vehicles;

	// flag and crate
	private _bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
	_bandera allowDamage false;
	_vehiculos pushBack _bandera;
	private _caja = "I_supplyCrate_F" createVehicle _posicion;
	_vehiculos pushBack _caja;

	{[_x, "AAF"] call AS_fnc_initVehicle;} forEach _vehiculos;

	if (_frontera) then {
		private _validBases = [["base"], "FIA"] call AS_fnc_location_TS;
		if (count _validBases > 0) then {
			private _base = [_validBases,_posicion] call BIS_fnc_nearestPosition;
			private _position = _base call AS_fnc_location_position;
			if (_position distance _posicion > 1000) then {
				private _pos = [_posicion] call mortarPos;
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
		([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
		_soldados append _units1;
		_vehiculos append _vehicles1;
	};

	// spawn truck
	([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
	_vehiculos append _vehicles1;

	// Create an AA team
	_grupo = [_posicion, side_red, [infAA, "AAF"] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
	_grupos pushBack _grupo;
	{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x;} forEach units _grupo;
	[leader _grupo, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";

	private _groupsCount = (round (_size/50)) max 1;
	if (_frontera) then {_groupsCount = _groupsCount * 2};

	if !(_location in _pLarge) then {
		_groupsCount = (round _groupsCount/2) max 1;

		_grupo = [_posicion, side_red, [infAA, "AAF"] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
		_grupos pushBack _grupo;
		{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x;} forEach units _grupo;
		[leader _grupo, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	};

	for "_i" from 1 to _groupsCount do {
		if !(_location call AS_fnc_location_spawned) exitWith {};
		_grupo = [_posicion, side_red, [infTeam, "AAF"] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
		private _stance = "RANDOM";
		if (_i == 1) then {_stance = "RANDOMUP"};
		[leader _grupo, _location, "SAFE","SPAWNED",_stance,"NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_grupos pushBack _grupo;
		{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
	};

	[_location, _grupos] call AS_fnc_createJournalist;

	[_location, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

AS_spawn_createAAFoutpostAA_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFoutpostAA_state_functions = [
	_fnc_spawn,
	AS_spawn_fnc_AAFwait_capture,
	AS_spawn_fnc_AAFlocation_clean
];
