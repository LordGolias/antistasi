#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith{};

private _pLarge = ["puesto_2","puesto_6","puesto_11","puesto_17","puesto_23"];

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _frontera = _location call isFrontline;

private _buildings = nearestObjects [_posicion, AS_destroyable_buildings, _size*1.5];

private _grupo = createGroup side_green;
_grupos pushBack _grupo;

([_location, side_green, _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
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

	([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
	_soldados append _units1;
	_vehiculos append _vehicles1;
};

// spawn truck
([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
_vehiculos append _vehicles1;

// Create an AA team
_grupo = [_posicion, side_green, [infAA, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
_grupos pushBack _grupo;
{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x;} forEach units _grupo;
[leader _grupo, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";

private _groupsCount = (round (_size/50)) max 1;
if (_frontera) then {_groupsCount = _groupsCount * 2};

if !(_location in _pLarge) then {
	_groupsCount = (round _groupsCount/2) max 1;

	_grupo = [_posicion, side_green, [infAA, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
	_grupos pushBack _grupo;
	{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x;} forEach units _grupo;
	[leader _grupo, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
};

for "_i" from 1 to _groupsCount do {
	if (!(_location call AS_fnc_location_spawned) or
		(diag_fps < AS_P("minimumFPS") and _i != 1)) exitWith {};
	_grupo = [_posicion, side_green, [infTeam, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
	private _stance = "RANDOM";
	if (_i == 1) then {_stance = "RANDOMUP"};
	[leader _grupo, _location, "SAFE","SPAWNED",_stance,"NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	_grupos pushBack _grupo;
	{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
};

private _journalist = [_location, _grupos] call AS_fnc_createJournalist;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

waitUntil {sleep 1;
	(not (_location call AS_fnc_location_spawned)) or
	(({(!(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) >
	 3*({(alive _x) and !(captive _x) and (_x distance _posicion < _size)} count _soldados))
};

if ((_location call AS_fnc_location_spawned) and (_location call AS_fnc_location_side == "AAF")) then {
	[_location] remoteExec ["AS_fnc_location_win",2];
};

waitUntil {sleep 1; (not (_location call AS_fnc_location_spawned))};

[_buildings] remoteExec ["AS_fnc_updateDestroyedBuildings", 2];

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{
	if (not(_x in AS_P("vehicles"))) then {
		if (!([AS_P("spawnDistance")-_size,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
	};
} forEach _vehiculos;
