#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];
	private _soldadosFIA = [];

	_vehiculos append (_location call AS_fnc_spawnComposition);

	private _posicion = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _prestigio = AS_P("NATOsupport")/100;

	private _grupo = createGroup ("NATO" call AS_fnc_getFactionSide);
	_grupos pushBack _grupo;

	([_location, "NATO", _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
	{[_x, false] call AS_fnc_initUnitNATO} forEach _gunners;
	{[_x, "NATO"] call AS_fnc_initVehicle} forEach _vehicles;
	_soldados append _gunners;
	_vehiculos append _vehicles;

	// create flag
	private _veh = createVehicle [(["NATO", "flag"] call AS_fnc_getEntity), _posicion, [],0, "CAN_COLLIDE"];
	_veh allowDamage false;
	[[_veh,"unit"],"AS_fnc_addAction"] call BIS_fnc_MP;
	[[_veh,"vehicle"],"AS_fnc_addAction"] call BIS_fnc_MP;
	[[_veh,"garage"],"AS_fnc_addAction"] call BIS_fnc_MP;
	_vehiculos pushBack _veh;

	private _nVeh = round ((_size / 30)*_prestigio);
	if (_nVeh > 4) then {_nVeh = 4;};

	// spawn mortars
	for "_i" from 1 to _nVeh do {
		if !(_location call AS_location_fnc_spawned) exitWith {};
		([_posicion, "NATO"] call AS_fnc_spawnMortar) params ["_mortar_units", "_mortar_groups", "_mortar_vehicles"];
		_soldados append _mortar_units;
		_vehiculos append _mortar_vehicles;
		_grupos append _mortar_groups;
		sleep 1;
	};

	_nVeh = round ((_size/30)*_prestigio);
	if (_nVeh < 1) then {_nVeh = 1};

	private _pos = _posicion;
	for "_i" from 1 to _nVeh do {
		if !(_location call AS_location_fnc_spawned) exitWith {};

		_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;

		private _type = selectRandom (["NATO", "other_vehicles"] call AS_fnc_getEntity);
		_veh = createVehicle [_type, _pos, [], 0, "NONE"];
		_veh setDir random 360;

		[_veh, "NATO"] call AS_fnc_initVehicle;
		_vehiculos pushBack _veh;
	};

	private _tipoGrupo = [["NATO", "squads"] call AS_fnc_getEntity, "NATO"] call AS_fnc_pickGroup;
	private _grupo = [_posicion, ("NATO" call AS_fnc_getFactionSide), _tipoGrupo] call BIS_Fnc_spawnGroup;
	[leader _grupo, _location, "SAFE", "RANDOMUP","SPAWNED", "NOVEH2", "NOFOLLOW"] spawn UPSMON;
	_grupos pushBack _grupo;
	{[_x] spawn AS_fnc_initUnitNATO; _soldados pushBack _x} forEach units _grupo;

	for "_i" from 1 to _nVeh do {
		if !(_location call AS_location_fnc_spawned) exitWith {};
		while {true} do {
			_pos = [_posicion, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
		};
		_tipoGrupo = [["NATO", "squads"] call AS_fnc_getEntity, "NATO"] call AS_fnc_pickGroup;
		_grupo = [_pos, ("NATO" call AS_fnc_getFactionSide), _tipoGrupo] call BIS_Fnc_spawnGroup;
		sleep 1;
		if (_i == 0) then {
			[leader _grupo, _location, "SAFE","SPAWNED","FORTIFY","NOVEH","NOFOLLOW"] spawn UPSMON;
		} else {
			[leader _grupo, _location, "SAFE","SPAWNED", "RANDOM","NOVEH", "NOFOLLOW"] spawn UPSMON;
		};
		_grupos pushBack _grupo;
		{[_x] spawn AS_fnc_initUnitNATO; _soldados pushBack _x} forEach units _grupo;
	};

	// Create FIA garrison
	(_location call AS_fnc_createFIAgarrison) params ["_soldados1", "_grupos1", "_vehiculos1"];
	_soldadosFIA append _soldados1;
	_grupos append _grupos1;
	_vehiculos append _vehiculos1;

	[_location, _grupos] call AS_fnc_spawnJournalist;

	[_location, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
	[_location, "FIAsoldiers", _soldadosFIA] call AS_spawn_fnc_set;
};

AS_spawn_createFIAbase_states = ["spawn", "run", "clean"];
AS_spawn_createFIAbase_state_functions = [
	_fnc_spawn,
	AS_location_spawn_fnc_FIAwait_capture,
	AS_location_spawn_fnc_FIAlocation_clean
];
