#include "../macros.hpp"
params ["_position"];

private _location = _position call AS_fnc_location_nearest;

private _threat = 0;

{if (_x in unlockedWeapons) then {_threat = 5};} forEach genAALaunchers;

if (_location call AS_fnc_location_side == "AAF") then {
	{
			private _positionOther = _x call AS_fnc_location_position;
			if (_positionOther distance _position < (AS_P("spawnDistance")*1.5)) then {
				if ((_x call AS_fnc_location_type) in ["base", "airfield"]) then {
					_threat = _threat + 3;
				} else {
					_threat = _threat + 1;
				};
			};
	} forEach ([["base", "airfield", "watchpost", "roadblock", "hill"], "AAF"]call AS_fnc_location_TS);
} else {
	{
		private _positionOther = _x call AS_fnc_location_position;
		private _garrison = _x call AS_fnc_location_garrison;
		private _size = _x call AS_fnc_location_size;
		if (_positionOther distance _position < AS_P("spawnDistance")) then {
			_threat = _threat + (floor((count _garrison)/4));
			private _estaticas = AS_P("vehicles") select {_x distance _positionOther < _size};
			if (count _estaticas > 0) then {
				_threat = _threat + ({typeOf _x in allStatMGs} count _estaticas) + (5*({typeOf _x in allStatAAs} count _estaticas));
			};
		};
	} forEach ([["base", "airfield", "watchpost", "roadblock"], "FIA"]call AS_fnc_location_TS);
};
_threat
