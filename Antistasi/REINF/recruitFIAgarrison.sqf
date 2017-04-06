#include "../macros.hpp"
params ["_type", "_marker"];

if (AS_P("hr") < 1) exitWith {hint "You lack of HR to make a new recruitment"};

private _cost = AS_data_allCosts getVariable _type;

if (_cost > AS_P("resourcesFIA")) exitWith {hint format ["You do not have enough money for this unit (%1 € needed)",_cost]};

private _enemiesClose = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance (getMarkerPos _marker) < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;
if (_enemiesClose) exitWith {Hint "There are enemies within 500m of the zone. You can not recruit."};

[-1,-_cost] remoteExec ["resourcesFIA",2];
private _garrison = garrison getVariable [_marker,[]];
_garrison pushBack _type;
garrison setVariable [_marker,_garrison,true];
[_marker] call mrkUpdate;
