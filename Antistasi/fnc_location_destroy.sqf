#include "macros.hpp"
AS_SERVER_ONLY("fnc_location_destroy.sqf");

params ["_location"];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;

private _buildings = _posicion nearObjects ["house",_size];

{
	if (random 100 < 70) then {
		for "_i" from 1 to 7 do {
			_x sethit [format ["dam%1",_i],1];
			_x sethit [format ["dam %1",_i],1];
		};
	} else {
		_x setDamage 1;
	};
} forEach _buildings;
