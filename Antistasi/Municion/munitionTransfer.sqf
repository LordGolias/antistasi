if (!isServer) exitWith {};
private ["_subCosa","_municion"];
_origin = _this select 0;
_destiny = _this select 1;

_cargoArray = [_origin] call AS_fnc_getBoxArsenal;
_cargo_w = _cargoArray select 0;
_cargo_m = _cargoArray select 1;
_cargo_i = _cargoArray select 2;
_cargo_b = _cargoArray select 3;

_restrict_to_locked = false;
if (_destiny == caja) then {
	_restrict_to_locked = true;
};
[_destiny, _cargo_w, _cargo_m, _cargo_i, _cargo_b, _restrict_to_locked] call AS_fnc_populateBox;

clearWeaponCargoGlobal _origin;
clearMagazineCargoGlobal _origin;
clearItemCargoGlobal _origin;
clearBackpackCargoGlobal _origin;

if (_destiny == caja) then {
	if (isMultiplayer) then {{if (_x distance caja < 10) then {[petros,"hint","Ammobox Loaded"] remoteExec ["commsMP",_x]}} forEach playableUnits} else {hint "Ammobox Loaded"};
}
else {
	[petros,"hint","Truck Loaded"] remoteExec ["commsMP", driver _destiny];
};