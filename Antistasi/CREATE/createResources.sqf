#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};

private ["_marcador","_vehiculos","_grupos","_soldados","_civs","_posicion","_pos","_tipogrupo","_tipociv","_size","_mrk","_ang","_cuenta","_grupo","_veh","_civ","_frontera","_tam","_bandera","_perro"];

_marcador = _this select 0;

_posicion = getMarkerPos _marcador;

_size = [_marcador] call sizeMarker;

_civs = [];
_soldados = [];
_grupos = [];
_vehiculos = [];

_tipociv = "";

_mrk = createMarkerLocal [format ["%1patrolarea", random 100], _posicion];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [(AS_P("spawnDistance")/2),(AS_P("spawnDistance")/2)];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_ang = markerDir _marcador;
_mrk setMarkerDirLocal _ang;
_mrk setMarkerAlphaLocal 0;
_cuenta = 0;

while {(spawner getVariable _marcador) and (_cuenta < 2)} do
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
	{[_x,false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
	_cuenta = _cuenta +1;
	};

_bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_bandera allowDamage false;
[[_bandera,"take"],"flagaction"] call BIS_fnc_MP;
_vehiculos = _vehiculos + [_bandera];

if (not(_marcador in destroyedCities)) then
	{
	if ((daytime > 8) and (daytime < 18)) then
		{
		_grupo = createGroup civilian;
		_grupos = _grupos + [_grupo];
		for "_i" from 1 to 8 do
			{
			//_tipociv = arrayCivs call BIS_Fnc_selectRandom;
			_civ = _grupo createUnit ["C_man_w_worker_F", _posicion, [],0, "NONE"];
			[_civ] spawn AS_fnc_initUnitCIV;
			_civs = _civs + [_civ];
			sleep 0.5;
			};
		[_marcador,_civs] spawn destroyCheck;
		[leader _grupo, _marcador, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX"] execVM "scripts\UPSMON.sqf";
		};
	};

_pos = _posicion findEmptyPosition [10,_size*1.5,"I_Truck_02_covered_F"];
_veh = createVehicle [selectRandom vehTrucks, _pos, [], 0, "NONE"];
_veh setDir random 360;
_vehiculos = _vehiculos + [_veh];
[_veh] spawn genVEHinit;
sleep 1;

_tam = round (_size/50);
if (_tam == 0) then {_tam = 1};
_pos = [];
_tipoGrupo = "";
_cuenta = 0;
_frontera = [_marcador] call isFrontline;
if (_frontera) then {_tam = _tam * 2};
while {(spawner getVariable _marcador) and (_cuenta < _tam)} do
	{
	if ((diag_fps > AS_P("minimumFPS")) or (_cuenta == 0)) then
		{
		_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		sleep 1;
		_stance = "RANDOM";
		if (_cuenta == 0) then
			{
			_stance = "RANDOMUP"
			};
		[leader _grupo, _marcador, "SAFE","SPAWNED",_stance,"NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_grupos = _grupos + [_grupo];
		{[_x,false] spawn AS_fnc_initUnitAAF; _soldados = _soldados + [_x]} forEach units _grupo;
		};
	_cuenta = _cuenta + 1;
	};

private _journalist = [_marcador, _grupos] call AS_fnc_createJournalist;

waitUntil {sleep 1; (not (spawner getVariable _marcador)) or (({(not(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) > 3*({(alive _x) and (!(captive _x)) and (_x distance _posicion < _size)} count _soldados))};
if ((spawner getVariable _marcador) and (not(_marcador in mrkFIA))) then
	{
	[_bandera] remoteExec ["mrkWIN",2];
	};

waitUntil {sleep 1; not (spawner getVariable _marcador)};

deleteMarker _mrk;
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteVehicle _x} forEach _civs;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{if (!([AS_P("spawnDistance")-_size,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x}} forEach _vehiculos;