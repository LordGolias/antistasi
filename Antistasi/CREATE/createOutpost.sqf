#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _frontera = _location call isFrontline;

private _buildings = nearestObjects [_posicion, listMilBld, _size*1.5];

private _grupo = createGroup side_green;
_grupos pushBack _grupo;

([_location, side_green, _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
_soldados append _gunners;
_vehiculos append _vehicles;

// create flag
_bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_bandera allowDamage false;
[[_bandera,"take"],"flagaction"] call BIS_fnc_MP;
_vehiculos pushBack _bandera;
_caja = "I_supplyCrate_F" createVehicle _posicion;
_vehiculos pushBack _caja;
{[_x, "AAF"] call AS_fnc_initVehicle;} forEach _vehiculos;

if (_location call AS_fnc_location_type == "seaport") then {
	private _pos = [_posicion,_size,_size*3,10,2,0,0] call BIS_Fnc_findSafePos;
	([_pos, 0,"I_Boat_Armed_01_minigun_F", side_green] call bis_fnc_spawnvehicle) params ["_veh", "_vehCrew", "_grupoVeh"];
	[_veh, "AAF"] call AS_fnc_initVehicle;
	{[_x, false] spawn AS_fnc_initUnitAAF} forEach _vehCrew;
	_soldados append _vehCrew;
	_grupos pushBack _grupoVeh;
	_vehiculos pushBack _veh;
	sleep 1;
} else {
	if (_frontera) then {
		private _validBases = [["base"], "FIA"] call AS_fnc_location_TS;
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

	if ((_location call AS_fnc_location_spawned) and _frontera) then {
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

private _journalist = [_location, _grupos] call AS_fnc_createJournalist;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

// AAF units (alive, not far and not captive) are not 3 times more than FIA units
waitUntil {sleep 1;
	!(_location call AS_fnc_location_spawned) or
	(({(!(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) >
	 3*({(alive _x) and !(captive _x) and (_x distance _posicion < _size)} count _soldados))
};

// all other conditions were fulfilled => captured
if ((_location call AS_fnc_location_spawned) and (_location call AS_fnc_location_side == "AAF")) then {
	[_bandera] remoteExec ["mrkWIN",2];
};

waitUntil {sleep 1; !(_location call AS_fnc_location_spawned)};

[_buildings] remoteExec ["AS_fnc_updateDestroyedBuildings", 2];

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{
	if !(_x in AS_P("vehicles")) then {
		if !([AS_P("spawnDistance")-_size,1,_x,"BLUFORSpawn"] call distanceUnits) then {
			deleteVehicle _x;
		};
	};
} forEach _vehiculos;
