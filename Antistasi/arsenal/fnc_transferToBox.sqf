#include "../macros.hpp"
params ["_origin", "_destination"];

private _restrict_to_locked = false;
if (_destination == caja) then {
	_restrict_to_locked = true;
	waitUntil {not AS_S("lockTransfer")};
	AS_Sset("lockTransfer", true);
};

([_origin] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
[_destination, _cargo_w, _cargo_m, _cargo_i, _cargo_b, _restrict_to_locked] call AS_fnc_populateBox;
[_origin] call AS_fnc_emptyCrate;

if (_destination == caja) then {
	AS_Sset("lockTransfer", false);
};
