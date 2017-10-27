#include "../macros.hpp"
params ["_type", "_location"];

if (AS_P("hr") < 1) exitWith {hint "You lack of HR to make a new recruitment"};

private _cost = _type call AS_fnc_getCost;

if (_cost > AS_P("resourcesFIA")) exitWith {hint format ["You do not have enough money for this unit (%1 € needed)",_cost]};

private _position = _location call AS_location_fnc_position;

if ([_position, 500] call AS_fnc_enemiesNearby) exitWith {
	hint "There are enemies within 500m of the zone. You can not recruit.";
};

[-1,-_cost] remoteExec ["AS_fnc_changeFIAmoney",2];
private _garrison = [_location, "garrison"] call AS_location_fnc_get;
_garrison pushBack _type;
[_location, "garrison", _garrison] call AS_location_fnc_set;
