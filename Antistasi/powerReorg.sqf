#include "macros.hpp"
AS_SERVER_ONLY("powerReorg.sqf");
params ["_location"];

if (_location call AS_fnc_location_type != "powerplant") exitWith {
	diag_log format ["[AS] Error: powerReorg called for a non-powerplant '%1'", _location];
};

private _supplySide = _location call AS_fnc_location_side;

private _supply = (call AS_fnc_location_all) select {_x call AS_fnc_location_type == "powerplant"};
private _demand = (call AS_fnc_location_all) select {_x call AS_fnc_location_type in ["city", "factory", "resource"]};

{
	private _pos = _x call AS_fnc_location_position;
	private _demandSide = _x call AS_fnc_location_side;
	private _supplyingPowerplant = [_supply,_pos] call BIS_fnc_nearestPosition;
	private _powered = true;
	if (_supplyingPowerplant == _location) then {
		if ((_location in AS_P("destroyedLocations")) or _supplySide != _demandSide) then {
			_powered = false;
		};
		[_x,_powered] spawn apagon;
	};
} forEach _demand;
