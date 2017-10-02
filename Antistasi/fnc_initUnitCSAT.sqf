params ["_unit"];

_unit setVariable ["OPFORSpawn",true,true];

[_unit, "CSAT"] call AS_fnc_setSide;

[_unit] call AS_debug_fnc_initUnit;

[_unit] call AS_medical_fnc_initUnit;

[_unit] call AS_fnc_setDefaultSkill;

if (sunOrMoon < 1) then {
	if (opIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};

_unit addEventHandler ["killed",AS_fnc_EH_AAFKilled];
