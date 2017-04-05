#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};

private ["_marcador","_datos","_numCiv","_numVeh","_roads","_civs","_grupos","_vehiculos","_civsPatrol","_gruposPatrol","_vehPatrol","_tipoCiv","_tipoVeh","_dirVeh","_cuenta","_grupo","_size","_road"];
private ["_civ","_grupo","_cuenta","_veh","_dirVeh","_roads","_roadcon"];

_marcador = _this select 0;

_data = [_marcador, ["population", "vehicles"]] call AS_fnc_getCityAttrs;
_numCiv = _data select 0;
_numVeh = _data select 1;

_roads = carreteras getVariable _marcador;

_civs = [];
_grupos = [];
_vehiculos = [];
_civsPatrol = [];
_gruposPatrol = [];
_vehPatrol = [];
_size = [_marcador] call sizeMarker;

_tipociv = "";
_tipoveh = "";
_dirveh = 0;

_posicion = getMarkerPos (_marcador);

_area = [_marcador] call sizeMarker;

if (_marcador in destroyedCities) then
	{
	_numCiv = _numCiv / 10;
	_numVeh = _numVeh / 10;
	};
_cuenta = 0;
_numVeh = round (_numVeh * AS_P("civPerc"));
if (_numVeh < 1) then {_numVeh = 1};
_numCiv = round (_numCiv * AS_P("civPerc"));
if ((daytime < 8) or (daytime > 21)) then {_numCiv = round (_numCiv/4); _numVeh = round (_numVeh * 1.5)};
if (_numCiv < 1) then {_numCiv = 1};

_grupo = createGroup civilian;
_grupos = _grupos + [_grupo];

for "_i" from 0 to _numCiv - 1 do {
	if (diag_fps < minimoFPS) exitWith {};

	_pos = [];
	while {true} do {
		_pos = [_posicion, round (random _area), random 360] call BIS_Fnc_relPos;
		if (!surfaceIsWater _pos) exitWith {};
	};
	_tipociv = arrayCivs call BIS_Fnc_selectRandom;
	_civ = _grupo createUnit [_tipociv, _pos, [],0, "NONE"];
	[_civ] spawn CIVinit;
	_civs pushBack _civ;
};

_counter = 0;  // how many vehicles were already spawned.
while {_counter < _numVeh} do {
	if (diag_fps < minimoFPS) exitWith {};

	_p1 = selectRandom _roads;
	_road = (_p1 nearRoads 5) select 0;
	if (!isNil "_road") then {
		_p2 = getPos ((roadsConnectedto _road) select 0);
		_dirveh = [_p1,_p2] call BIS_fnc_DirTo;
		_pos = [_p1, 3, _dirveh + 90] call BIS_Fnc_relPos;
		_tipoveh = arrayCivVeh call BIS_Fnc_selectRandom;
		if (count (_pos findEmptyPosition [0,5,_tipoveh]) > 0) then {
			_veh = _tipoveh createVehicle _pos;
			_veh setDir _dirveh;
			_vehiculos pushBack _veh;
			[_veh] spawn civVEHinit;
			_counter = _counter + 1;
		};
	};
};

private _journalist = [_marcador, _grupos] call AS_fnc_createJournalist;

[leader _grupo, _marcador, "SAFE", "SPAWNED","NOFOLLOW", "NOVEH2","NOSHARE","DoRelax"] execVM "scripts\UPSMON.sqf";

_patrolCiudades = [_marcador] call citiesToCivPatrol;

_cuentaPatrol = 0;

_andanadas = round (_numCiv / 30);
if (_andanadas < 1) then {_andanadas = 1};

for "_i" from 1 to _andanadas do
	{
	while {(spawner getVariable _marcador) and (_cuentaPatrol < (count _patrolCiudades - 1))} do
		{
		//_p1 = getPos (_roads select _cuenta);
		_p1 = _roads select _cuenta;
		_road = (_p1 nearRoads 5) select 0;
		if (!isNil "_road") then
			{
			_grupoP = createGroup civilian;
			_gruposPatrol = _gruposPatrol + [_grupoP];
			_roadcon = roadsConnectedto _road;
			//_p1 = getPos (_roads select _cuenta);
			_p2 = getPos (_roadcon select 0);
			_dirveh = [_p1,_p2] call BIS_fnc_DirTo;
			_tipoveh = arrayCivVeh call BIS_Fnc_selectRandom;
			_veh = _tipoveh createVehicle _p1;
			_veh setDir _dirveh;
			_veh addEventHandler ["HandleDamage",{if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0;} else {(_this select 2);};}];
			_vehPatrol = _vehPatrol + [_veh];
			_tipociv = arrayCivs call BIS_Fnc_selectRandom;
			_civ = _grupoP createUnit [_tipociv, _p1, [],0, "NONE"];
			[_civ] spawn CIVinit;
			_civsPatrol = _civsPatrol + [_civ];
			_civ moveInDriver _veh;
			_grupoP addVehicle _veh;
			_grupoP setBehaviour "CARELESS";
			_wp = _grupoP addWaypoint [getMarkerPos (_patrolCiudades select _cuentaPatrol),0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointTimeout [30, 45, 60];
			_wp = _grupoP addWaypoint [_posicion,1];
			_wp setWaypointType "MOVE";
			_wp setWaypointTimeout [30, 45, 60];
			_wp1 = _grupoP addWaypoint [_posicion,0];
			_wp1 setWaypointType "CYCLE";
			_wp1 synchronizeWaypoint [_wp];
			};
		if (_cuenta < (count _roads)) then {_cuenta = _cuenta + 1} else {_cuenta = 0};
		_cuentaPatrol = _cuentaPatrol + 1;
		sleep 5;
		};
	};

waitUntil {sleep 1;not (spawner getVariable _marcador)};

{deleteVehicle _x} forEach _civs;
if (!isNull _journalist) then {deleteVehicle _journalist};
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