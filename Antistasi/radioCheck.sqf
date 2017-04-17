private _ok = false;
{
	if ((alive _x) and (_this distance _x < 3500)) then {
		private _base = [call AS_fnc_location_all,_x] call BIS_fnc_nearestPosition;
		if (_base call AS_fnc_location_side == "AAF") then {
			_ok = true;
		};
	};
	if (_ok) exitWith {};  // shortcircuit loop
} forEach antenas;
_ok
