#include "../macros.hpp"
params ["_position"];

private _threat = 0;
{if (_x in unlockedWeapons) then {_threat = 3};} forEach genATLaunchers;

// roadblocks
_threat = _threat + 2 * (
	{(_x call AS_fnc_location_position) distance _position < AS_P("spawnDistance")} count (["roadblock", "FIA"] call AS_fnc_location_TS));

// bases
{
	private _otherPosition = _x call AS_fnc_location_position;
	private _size = _x call AS_fnc_location_size;
	private _garrison = _x call AS_fnc_location_garrison;
	if (_otherPosition distance _position < AS_P("spawnDistance")) then {
		_threat = _threat + (2*({(_x == "Ammo Bearer")} count _garrison)) + (floor((count _garrison)/8));
		private _estaticas = staticsToSave select {_x distance _otherPosition < _size};
		if (count _estaticas > 0) then {
			_threat = _threat + ({typeOf _x in allStatMortars} count _estaticas) + (2*({typeOf _x in allStatATs} count _estaticas));
		};
	};
} forEach ([["base", "airfield", "watchpost"], "FIA"] call AS_fnc_location_TS);

_threat
