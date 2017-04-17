#include "../macros.hpp"
params ["_type", "_location"];

private _enemiesClose = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and
		(_x distance (_location call AS_fnc_location_position) < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;
if (_enemiesClose) exitWith {Hint "There are enemies within 500m of the zone. You can not dismiss units."};

[1,AS_data_allCosts getVariable _type] remoteExec ["resourcesFIA",2];

private _garrison = [_location, "garrison"] call AS_fnc_location_get;
_garrison deleteAt (_garrison find _type);
[_location, "garrison", _garrison] call AS_fnc_location_set;
_location call AS_fnc_location_updateMarker;
