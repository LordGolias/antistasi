params ["_unit"];
private ["_tipo"];

_unit setVariable ["OPFORSpawn",true,true];

[_unit] call AS_fnc_setDefaultSkill;

_tipo = typeOf _unit;

if (sunOrMoon < 1) then {
	if (opIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};

_unit addEventHandler ["HandleDamage",handleDamageAAF];
_unit addEventHandler ["killed",AAFKilledEH];
