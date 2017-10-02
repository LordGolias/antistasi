#include "macros.hpp"
params ["_unit", ["_spawned", true]];

[_unit, "AAF"] call AS_fnc_setSide;

[_unit] call AS_debug_fnc_initUnit;

if (typeOf _unit == "Fin_random_F") exitWith {};  // dog

[_unit] call AS_medical_fnc_initUnit;
if (_spawned) then {
	_unit setVariable ["OPFORSpawn",true,true];
};

_skillAAF = AS_P("skillAAF");
[_unit, _skillAAF] call AS_fnc_setDefaultSkill;

if (round random 13 > _skillAAF) then {
	_unit unassignItem indNVG;
	_unit removeItem indNVG;

	_unit unassignItem indLaser;
	_unit removePrimaryWeaponItem indLaser;
	_unit addPrimaryWeaponItem indFL;

	if (sunOrMoon < 1) then {
		_unit enableGunLights "forceOn";
	};
}
else {
	if (sunOrMoon < 1) then {
		if (indLaser in primaryWeaponItems _unit) then {
			if (random 1 > 0.6) then {
				_unit enableIRLasers true;
			}
			else {
				_unit enableIRLasers false;
			};
		};
	};
};

_unit addEventHandler ["killed", AS_fnc_EH_AAFKilled];
