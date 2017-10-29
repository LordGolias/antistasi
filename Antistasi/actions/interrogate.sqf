#include "../macros.hpp"
params ["_unit", "_player"];

[[_unit,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;

if (!alive _unit) exitWith {};

_player globalChat "You souvlaki! Tell me what you know!";

private _chance = AS_P("NATOsupport") - AS_P("CSATsupport");

_chance = _chance + 20;

if (_chance < 20) then {_chance = 20};

if (floor random 100 < _chance) then {
	_unit globalChat "Okay, I'll tell you everything I know";
	[_unit] call AS_fnc_showFoundIntel;
} else {
	_unit globalChat "Screw you!";
};
