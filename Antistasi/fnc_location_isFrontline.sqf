#include "macros.hpp"
params ["_location"];

private _position = _location call AS_location_fnc_position;

private _locations = [["airfield", "base", "watchpost", "fia_hq"], "FIA"] call AS_location_fnc_TS;

private _isfrontier = false;
{
	private _otherPosition = _x call AS_location_fnc_position;
	if (_position distance _otherPosition < AS_P("spawnDistance")) exitWith {
		_isFrontier = true;
	};
} forEach _locations;

_isfrontier
