if (!isServer) exitWith {};
private ["_subCosa","_municion"];
_origin = _this select 0;
_destiny = _this select 1;

([_origin] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];

_restrict_to_locked = false;
if (_destiny == caja) then {
	_restrict_to_locked = true;
};
[_destiny, _cargo_w, _cargo_m, _cargo_i, _cargo_b, _restrict_to_locked] call AS_fnc_populateBox;

[_origin] call emptyCrate;
