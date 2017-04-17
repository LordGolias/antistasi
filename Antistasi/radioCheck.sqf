private _position = _this;

private _ok = false;
{
	if ((alive _x) and (_this distance _x < 3500)) then {
		private _base = [marcadores,_x] call BIS_fnc_nearestPosition;
		if (_base in mrkAAF) then {
			_ok = true;
		};
	};
	if (_ok) exitWith {};  // shortcircuit loop
} forEach antenas;
_ok
