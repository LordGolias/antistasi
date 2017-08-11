#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith{};

if (_location call AS_fnc_location_type != "city") exitWith {
	diag_log format ["[AS] ERROR: createCIV called with non-city: '%1'", _location];
};

private ["_datos","_numCiv","_numVeh","_roads","_civs","_grupos","_vehiculos","_civsPatrol","_gruposPatrol","_vehPatrol","_tipoCiv","_tipoVeh","_dirVeh","_cuenta","_grupo","_size","_road"];
private ["_civ","_grupo","_cuenta","_veh","_dirVeh","_roads","_roadcon"];

private _numCiv = [_location, "population"] call AS_fnc_location_get;
private _numVeh = _numCiv/10;

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _roads = [_location, "roads"] call AS_fnc_location_get;

private _civs = [];
private _grupos = [];
private _vehiculos = [];
private _civsPatrol = [];
private _gruposPatrol = [];
private _vehPatrol = [];

_tipociv = "";
_tipoveh = "";
_dirveh = 0;

if (_location in AS_P("destroyedLocations")) then {
	_numCiv = _numCiv / 10;
	_numVeh = _numVeh / 10;
};
_numVeh = round (_numVeh * AS_P("civPerc"));
if (_numVeh < 1) then {_numVeh = 1};

_numCiv = round (_numCiv * AS_P("civPerc"));
if ((daytime < 8) or (daytime > 21)) then {_numCiv = round (_numCiv/4); _numVeh = round (_numVeh * 1.5)};
if (_numCiv < 1) then {_numCiv = 1};

private _grupo = createGroup civilian;
_grupos = _grupos + [_grupo];

for "_i" from 1 to _numCiv do {
	if (diag_fps < AS_P("minimumFPS")) exitWith {};

	private _pos = [];
	while {true} do {
		_pos = [_posicion, round (random _size), random 360] call BIS_Fnc_relPos;
		if (!surfaceIsWater _pos) exitWith {};
	};
	private _civ = _grupo createUnit [arrayCivs call BIS_Fnc_selectRandom, _pos, [],0, "NONE"];
	[_civ] spawn AS_fnc_initUnitCIV;
	_civs pushBack _civ;
};

// spawn parked cars
private _counter = 0;  // how many vehicles were already spawned.
while {_counter < _numVeh} do {
	if (diag_fps < AS_P("minimumFPS")) exitWith {};

	private _p1 = selectRandom _roads;
	private _road = (_p1 nearRoads 5) select 0;
	if (!isNil "_road") then {
		_p2 = getPos ((roadsConnectedto _road) select 0);
		_dirveh = [_p1,_p2] call BIS_fnc_DirTo;
		_pos = [_p1, 3, _dirveh + 90] call BIS_Fnc_relPos;
		if (count (_pos findEmptyPosition [0,5,_tipoveh]) > 0) then {
			private _veh = (arrayCivVeh call BIS_Fnc_selectRandom) createVehicle _pos;
			_veh setDir _dirveh;
			_vehiculos pushBack _veh;
			[_veh] spawn civVEHinit;
			_counter = _counter + 1;
		};
	};
};

private _journalist = [_location, _grupos] call AS_fnc_createJournalist;

[leader _grupo, _location, "SAFE", "SPAWNED","NOFOLLOW", "NOVEH2","NOSHARE","DoRelax"] execVM "scripts\UPSMON.sqf";

private _patrolCiudades = _location call citiesToCivPatrol;

private _cuentaPatrol = 0;

// spawn moving cars
for "_i" from 1 to _numVeh do {
	if !(_location call AS_fnc_location_spawned) exitwith {};
	_road = selectRandom _roads;
	_p1 = getPos _road;
	_grupoP = createGroup civilian;
	_gruposPatrol pushBack _grupoP;
	_p2 = getPos ((roadsConnectedto _road) select 0);
	_dirveh = [_p1,_p2] call BIS_fnc_DirTo;

	_veh = (arrayCivVeh call BIS_Fnc_selectRandom) createVehicle _p1;
	[_veh] spawn civVEHinit;
	_veh setDir _dirveh;
	_vehPatrol pushBack _veh;

	// spawn driver
	_tipociv = arrayCivs call BIS_Fnc_selectRandom;
	_civ = _grupoP createUnit [_tipociv, _p1, [],0, "NONE"];
	[_civ] spawn AS_fnc_initUnitCIV;
	_civsPatrol pushBack _civ;
	_civ moveInDriver _veh;
	_grupoP addVehicle _veh;

	// set waypoints
	_grupoP setBehaviour "CARELESS";
	_wp = _grupoP addWaypoint [(selectRandom _patrolCiudades) call AS_fnc_location_position,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointTimeout [30, 45, 60];
	_wp = _grupoP addWaypoint [_posicion,1];
	_wp setWaypointType "MOVE";
	_wp setWaypointTimeout [30, 45, 60];
	_wp1 = _grupoP addWaypoint [_posicion,0];
	_wp1 setWaypointType "CYCLE";
	_wp1 synchronizeWaypoint [_wp];
	sleep 5;
};

waitUntil {sleep 1;not (_location call AS_fnc_location_spawned)};

{deleteVehicle _x} forEach _civs;

{deleteGroup _x} forEach _grupos;
{
if (!([AS_P("spawnDistance")-_size,1,_x,"BLUFORSpawn"] call distanceUnits)) then
	{
	if (_x in reportedVehs) then {reportedVehs = reportedVehs - [_x]; publicVariable "reportedVehs"};
	deleteVehicle _x;
	}
} forEach _vehiculos;
{
waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x} forEach _civsPatrol;
{
if (!([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)) then
	{
	if (_x in reportedVehs) then {reportedVehs = reportedVehs - [_x]; publicVariable "reportedVehs"};
	deleteVehicle _x
	}
else
	{
	[_x] spawn civVEHinit
	};
} forEach _vehPatrol;
{deleteGroup _x} forEach _gruposPatrol;
