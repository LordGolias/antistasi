#include "../macros.hpp"
params ["_type", "_location"];

private _enemiesClose = false;
{
	if ((side _x == side_red) and
		(_x distance (_location call AS_location_fnc_position) < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;
if (_enemiesClose) exitWith {Hint "There are enemies within 500m of the zone. You can not dismiss units."};

[1,AS_data_allCosts getVariable _type] remoteExec ["AS_fnc_changeFIAmoney",2];

private _garrison = [_location, "garrison"] call AS_location_fnc_get;
_garrison deleteAt (_garrison find _type);
[_location, "garrison", _garrison] call AS_location_fnc_set;
