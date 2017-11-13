#include "macros.hpp"
params ["_location"];

private _power = ["powerplant" call AS_location_fnc_T, _location call AS_location_fnc_position] call BIS_fnc_nearestPosition;

if (_power in AS_P("destroyedLocations")) exitWith {false};

(_location call AS_location_fnc_side) == (_power call AS_location_fnc_side)
