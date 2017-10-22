#include "macros.hpp"
// _this: a location
private _ok = false;
{
	private _position = _x call AS_location_fnc_position;
	if ((_this distance _position < 3500)) then {
		private _location = _x call AS_location_fnc_nearest;
		if (_location call AS_location_fnc_side == "AAF") then {
			_ok = true;
		};
	};
	if _ok exitWith {};  // shortcircuit loop
} forEach AS_P("antenasPos_alive");
_ok
