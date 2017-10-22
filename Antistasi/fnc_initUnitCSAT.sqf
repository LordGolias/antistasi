params ["_unit"];

_unit setVariable ["OPFORSpawn",true,true];

[_unit, "CSAT"] call AS_fnc_setSide;

[_unit] call AS_debug_fnc_initUnit;

[_unit] call AS_medical_fnc_initUnit;

[_unit] call AS_fnc_setDefaultSkill;

if (SunOrMoon > 1) then {
	_unit call AS_fnc_removeNightEquipment;
};

_unit addEventHandler ["killed",AS_fnc_EH_AAFKilled];

_unit enableIRLasers true;
_unit enableGunLights "AUTO";
