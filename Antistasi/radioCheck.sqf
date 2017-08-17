#include "macros.hpp"
// _this: a location
private _ok = false;
{
	if ((_this distance _x < 3500)) then {
		private _location = _x call AS_fnc_location_nearest;
		if (_location call AS_fnc_location_side == "AAF") then {
			_ok = true;
		};
	};
	if _ok exitWith {};  // shortcircuit loop
} forEach AS_P("antenasPos_alive");
_ok
