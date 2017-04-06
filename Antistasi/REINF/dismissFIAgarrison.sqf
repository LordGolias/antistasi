#include "../macros.hpp"
params ["_type", "_marker"];

private _enemiesClose = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance (getMarkerPos _marker) < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;
if (_enemiesClose) exitWith {Hint "There are enemies within 500m of the zone. You can not dismiss units."};

[1,AS_data_allCosts getVariable _type] remoteExec ["resourcesFIA",2];
private _garrison = garrison getVariable [_marker,[]];
_garrison deleteAt (_garrison find _type);
garrison setVariable [_marker,_garrison,true];
[_marker] call mrkUpdate;
