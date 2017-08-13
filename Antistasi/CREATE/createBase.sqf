#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _spatrol = [];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _frontera = _location call isFrontline;
private _busy = _location call AS_fnc_location_busy;
private _buildings = nearestObjects [_posicion, AS_destroyable_buildings, _size*1.5];

private _grupo = createGroup side_red;
_grupos pushBack _grupo;

([_location, side_red, _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
_soldados append _gunners;
_vehiculos append _vehicles;

// spawn flag and crate
private _bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_bandera allowDamage false;
private _veh = "I_supplyCrate_F" createVehicle _posicion;
[_veh, "Watchpost"] call AS_fnc_fillCrateAAF;
_vehiculos append [_bandera, _veh];

// spawn up to 4 mortars
for "_i" from 1 to ((round (_size / 30)) min 4) do {
	if !(_location call AS_fnc_location_spawned) exitWith {};
	private _pos = [_posicion] call mortarPos;
	private _veh = statMortar createVehicle _pos;
	[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
	[_veh, "AAF"] call AS_fnc_initVehicle;
	private _unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
	[_unit, false] spawn AS_fnc_initUnitAAF;
	_unit moveInGunner _veh;
	_soldados pushBack _unit;
	_vehiculos pushBack _veh;
	sleep 1;
};

// spawn AT road checkpoint
if ((_location call AS_fnc_location_spawned) and _frontera) then {
	([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
	_soldados append _units1;
	_vehiculos append _vehicles1;
};

// spawn parked vehicles
private _groupCount = (round (_size/30)) max 1;

if (!_busy) then {
	private _possible_vehicles = ["trucks", "apcs"] call AS_fnc_AAFarsenal_all;
	private _pos = _posicion;

	for "_i" from 1 to _groupCount do {
		if (!(_location call AS_fnc_location_spawned) or diag_fps < AS_P("minimumFPS")) exitWith {};
		if (count _possible_vehicles == 0) exitWith {};
		private _tipoVeh = selectRandom _possible_vehicles;
		_possible_vehicles deleteAt (_possible_vehicles find _tipoVeh);
		private _pos = [];
		if (_size > 40) then {
			_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		} else {
			_pos = _pos findEmptyPosition [10,60,_tipoVeh];
		};
		private _veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
		_veh setDir random 360;
		[_veh, "AAF"] call AS_fnc_initVehicle;
		_vehiculos pushBack _veh;
		sleep 1;
	};
};

// spawn patrols
// _mrk => to be deleted at the end
([_location, _groupCount] call AS_fnc_spawnAAF_patrol) params ["_units1", "_groups1", "_mrk"];
_spatrol append _units1;
_grupos append _groups1;

// spawn guarding squads
if (_frontera) then {_groupCount = _groupCount * 2};
([_location, 1 + _groupCount] call AS_fnc_spawnAAF_patrolSquad) params ["_units1", "_groups1"];
_soldados append _units1;
_grupos append _groups1;

[_location, _grupos] call AS_fnc_createJournalist;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

waitUntil {sleep 1;
	(not (_location call AS_fnc_location_spawned)) or
	(({(not(vehicle _x isKindOf "Air"))} count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance)) >
	 3*({(alive _x) and !(captive _x) and (_x distance _posicion < _size)} count _soldados))
};

if ((_location call AS_fnc_location_spawned) and (_location call AS_fnc_location_side == "AAF")) then {
	[_location] remoteExec ["AS_fnc_location_win",2];
};

waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};

[_buildings] remoteExec ["AS_fnc_updateDestroyedBuildings", 2];

[_grupos, _vehiculos, [_mrk]] call AS_fnc_cleanResources;
