#include "../macros.hpp"
params ["_veh","_posicion"];
private ["_grupos","_conocidos","_grupo","_lider"];

while {alive _veh} do
	{
	_conocidos = [];
	_grupos = [];
	_enemigos = [AS_P("spawnDistance"), _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance;
	sleep 60;
	{
	_lider = leader _x;
	if ((_lider in _enemigos) and (vehicle _lider != _lider)) then {_grupos pushBack _x};
	} forEach allGroups;
	{
	if ((side _x == ("FIA" call AS_fnc_getFactionSide)) and (alive _x) and (_x distance _posicion < 500)) then
		{
		_conocidos pushBack _x;
		};
	} forEach allUnits;
	{
	_grupo = _x;
		{
		_grupo reveal [_x,4];
		} forEach _conocidos;
	} forEach _grupos;

	};
