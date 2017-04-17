#include "macros.hpp"

private _position = _this call AS_fnc_location_position;

private _locations = [["airfield", "base", "watchpost"], "AAF"]call AS_fnc_location_TS;

private _isfrontier = false;
{
	private _otherPosition = _x call AS_fnc_location_position;
	if (_posicion distance _otherPosition < AS_P("spawnDistance")) exitWith {
		_isFrontier = true;
	};
} forEach _locations;

_isfrontier
