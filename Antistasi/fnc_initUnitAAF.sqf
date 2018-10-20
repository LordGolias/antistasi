#include "macros.hpp"
params ["_unit", ["_spawned", true]];

[_unit, "AAF"] call AS_fnc_setSide;

[_unit] call AS_debug_fnc_initUnit;

if (_unit call AS_fnc_isDog) exitWith {};

[_unit] call AS_medical_fnc_initUnit;
if (_spawned) then {
	_unit setVariable ["OPFORSpawn",true,true];
};

private _skillAAF = AS_P("skillAAF");
[_unit, _skillAAF] call AS_fnc_setDefaultSkill;

_unit call AS_fnc_removeNightEquipment;

if (SunOrMoon < 1) then {
	if ((floor random 100)/100 < _skillAAF/AS_maxSkill) then {
		_unit linkItem selectRandom (AS_allNVGs arrayIntersect AAFItems);
		_unit addPrimaryWeaponItem selectRandom (AS_allLasers arrayIntersect AAFItems);
	} else {
		_unit addPrimaryWeaponItem selectRandom (AS_allFlashlights arrayIntersect AAFItems);
	};
};

_unit addEventHandler ["killed", AS_fnc_EH_AAFKilled];

_unit enableIRLasers true;
_unit enableGunLights "AUTO";
