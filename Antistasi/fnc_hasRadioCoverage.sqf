#include "macros.hpp"
// _this: a position or _location
private _position = _this;
if (typeName _this == typeName "") then {
	_position = _this call AS_location_fnc_position;
};

private _ok = false;
{
	if ((_position distance _x < 3500)) then {
		private _location = _x call AS_location_fnc_nearest;
		if (_location call AS_location_fnc_side == "AAF") then {
			_ok = true;
		};
	};
	if _ok exitWith {};  // shortcircuit loop
} forEach AS_P("antenasPos_alive");
_ok
