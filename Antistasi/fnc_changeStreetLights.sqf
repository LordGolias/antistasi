#include "macros.hpp"
AS_SERVER_ONLY("fnc_changeStreetLights.sqf");
params ["_location", "_onoff"];

private _position = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;

private _damage = 0;
if (not _onoff) then {_damage = 0.95;};

{
    private _lamps = _position nearObjects [_x, _size];
    {sleep 0.5; _x setDamage _damage} forEach _lamps;
} forEach AS_lampTypes;
