params ["_unit", ["_spawned", true]];

if (typeOf _unit == "Fin_random_F") exitWith {};  // dog

if (_spawned) then {
	_unit setVariable ["OPFORSpawn",true,true];
};

[_unit, skillAAF] call AS_fnc_setDefaultSkill;

if (round random 13 > skillAAF) then {
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

_unit addEventHandler ["HandleDamage",handleDamageAAF];
_unit addEventHandler ["killed", AAFKilledEH];
