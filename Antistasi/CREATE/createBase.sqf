#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};

private ["_pos","_marcador","_vehiculos","_grupos","_soldados","_posicion","_busy","_buildings","_grupo","_cuenta","_tipoVeh","_veh","_unit","_arrayVehAAF","_nVeh","_frontera","_spatrol","_size","_listbld","_ang","_mrk","_tipogrupo","_bandera","_tipoB","_perro"];

_marcador = _this select 0;

_vehiculos = [];
_grupos = [];
_soldados = [];
_spatrol = [];

_posicion = getMarkerPos (_marcador);
_pos = [];

_busy = if (dateToNumber date > server getVariable _marcador) then {false} else {true};

_size = [_marcador] call sizeMarker;
_frontera = [_marcador] call isFrontline;
_buildings = nearestObjects [_posicion, listMilBld, _size*1.5];

_grupo = createGroup side_green;
_grupos = _grupos + [_grupo];

([_marcador, side_green, _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
_soldados = _soldados + _gunners;
_vehiculos = _vehiculos + _vehicles;

_bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_bandera allowDamage false;
[[_bandera,"take"],"flagaction"] call BIS_fnc_MP;
_vehiculos = _vehiculos + [_bandera];
_veh = "I_supplyCrate_F" createVehicle _posicion;
_vehiculos = _vehiculos + [_veh];

_nVeh = round (_size / 30);
if (_nVeh > 4) then {_nVeh = 4};
if ( _nVeh > 0 ) then
	{
	_pos = [_posicion, random (_size / 2),random 360] call BIS_fnc_relPos;
	_cuenta = 0;
	while {(spawner getVariable _marcador) and (_cuenta < _nveh)} do
		{
		_pos = [_posicion] call mortarPos;
		_veh = statMortar createVehicle _pos;
		[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
		_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		[_unit, false] spawn AS_fnc_initUnitOPFOR;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		_vehiculos = _vehiculos + [_veh];
		sleep 1;
		_cuenta = _cuenta + 1;
		};
	};

{[_x] spawn genVEHinit} forEach _vehiculos;

if ((spawner getVariable _marcador) and _frontera) then
	{
	_roads = _posicion nearRoads _size;
	if (count _roads != 0) then
		{
		_dist = 0;
		_road = objNull;
		{if ((position _x) distance _posicion > _dist) then {_road = _x;_dist = position _x distance _posicion}} forEach _roads;
		_roadscon = roadsConnectedto _road;
		_roadcon = objNull;
		{if ((position _x) distance _posicion > _dist) then {_roadcon = _x}} forEach _roadscon;
		_dirveh = [_roadcon, _road] call BIS_fnc_DirTo;
		_pos = [getPos _road, 7, _dirveh + 270] call BIS_Fnc_relPos;
		_bunker = "Land_BagBunker_Small_F" createVehicle _pos;
		_vehiculos = _vehiculos + [_bunker];
		_bunker setDir _dirveh;
		_pos = getPosATL _bunker;
		_veh = statAT createVehicle _posicion;
		_vehiculos = _vehiculos + [_veh];
		_veh setPos _pos;
		_veh setDir _dirVeh + 180;
		_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		[_unit, false] spawn AS_fnc_initUnitOPFOR;
		[_veh] spawn genVEHinit;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		};
	};

if (!_busy) then
	{
	_arrayVehAAF = vehAPC + vehPatrol + vehAAFAT - [heli_default];
	_tipoVeh = "";
	_nVeh = round (_size/30);
	if (_nVeh < 1) then {_nVeh = 1};
	_pos = _posicion;
	_cuenta = 0;
	while {(spawner getVariable _marcador) and (_cuenta < _nveh)} do
		{
		if (diag_fps > AS_P("minimumFPS")) then
			{
			_tipoVeh = _arrayVehAAF call BIS_fnc_selectRandom;
			if (_size > 40) then {_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos} else {_pos = _pos findEmptyPosition [10,60,_tipoVeh]};
			_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
			_veh setDir random 360;
			_vehiculos = _vehiculos + [_veh];
			[_veh] spawn genVEHinit;
			};
		sleep 1;
		_cuenta = _cuenta + 1;
		};
	};

_mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _posicion];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [(AS_P("spawnDistance")/2),(AS_P("spawnDistance")/2)];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_ang = markerDir _marcador;
_mrk setMarkerDirLocal _ang;
_mrk setMarkerAlphaLocal 0;
_cuenta = 0;
while {(spawner getVariable _marcador) and (_cuenta < 4)} do
	{
	while {true} do
		{
		_pos = [_posicion, 150 + (random 350) ,random 360] call BIS_fnc_relPos;
		if (!surfaceIsWater _pos) exitWith {};
		};
	_tipoGrupo = [infPatrol, side_green] call fnc_pickGroup;
	_grupo = [_pos, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
	sleep 1;
	if (random 10 < 2.5) then {
		_perro = _grupo createUnit ["Fin_random_F",_pos,[],0,"FORM"];
		[_perro] spawn guardDog;
	};
	[leader _grupo, _mrk, "SAFE","SPAWNED", "NOVEH2"] execVM "scripts\UPSMON.sqf";
	_grupos = _grupos + [_grupo];
	{[_x, false] spawn AS_fnc_initUnitOPFOR; _spatrol = _spatrol + [_x]} forEach units _grupo;
	_cuenta = _cuenta +1;
	};

_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
if (hayRHS) then {_grupo = [_grupo, _posicion] call expandGroup};
sleep 1;
[leader _grupo, _marcador, "SAFE", "RANDOMUP","SPAWNED", "NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
_grupos = _grupos + [_grupo];
{[_x, false] spawn AS_fnc_initUnitOPFOR; _soldados = _soldados + [_x]; _x setUnitPos "MIDDLE";} forEach units _grupo;
_cuenta = 0;
if (_frontera) then {_nveh = _nveh * 2};
while {(spawner getVariable _marcador) and (_cuenta < _nveh)} do
	{
	if (diag_fps > AS_P("minimumFPS")) then
		{
		while {true} do
			{
			_pos = [_posicion, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
			};
		_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		_grupo = [_pos, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		if (hayRHS) then {_grupo = [_grupo, _posicion] call expandGroup};
		sleep 1;
		[leader _grupo, _marcador, "SAFE","SPAWNED", "NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_grupos = _grupos + [_grupo];
		{[_x, false] spawn AS_fnc_initUnitOPFOR; _soldados = _soldados + [_x]} forEach units _grupo;
		};
	sleep 1;
	_cuenta = _cuenta + 1;
	};

private _journalist = [_marcador, _grupos] call AS_fnc_createJournalist;

waitUntil {sleep 1; (not (spawner getVariable _marcador)) or (({(not(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) > 3*({(alive _x) and (!(captive _x)) and (_x distance _posicion < _size)} count _soldados))};

if ((spawner getVariable _marcador) and (not(_marcador in mrkFIA))) then
	{
	[_bandera] remoteExec ["mrkWIN",2];
	};

waitUntil {sleep 1; not (spawner getVariable _marcador)};

{if ((!alive _x) and (not(_x in destroyedBuildings))) then {destroyedBuildings = destroyedBuildings + [position _x]; publicVariableServer "destroyedBuildings"}} forEach _buildings;

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{if (alive _x) then {deleteVehicle _x}} forEach _spatrol;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{
if (not(_x in staticsToSave)) then
	{
	if (!([(AS_P("spawnDistance")-_size),1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
	};
} forEach _vehiculos;
deleteMarker _mrk;





