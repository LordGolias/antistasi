params ["_unit"];

_unit setVariable ["OPFORSpawn",true,true];

_unit setVariable ["AS_side", "CSAT", true];

[_unit] call AS_medical_fnc_initUnit;

[_unit] call AS_fnc_setDefaultSkill;

if (sunOrMoon < 1) then {
	if (opIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};

_unit addEventHandler ["killed",AS_fnc_EH_AAFKilled];
