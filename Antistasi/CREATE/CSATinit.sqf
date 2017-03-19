params ["_unit"];
private ["_tipo"];

_unit setVariable ["OPFORSpawn",true,true];

[_unit] call AS_fnc_setDefaultSkill;

_tipo = typeOf _unit;

if (sunOrMoon < 1) then {
	if (opIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};


if (hayRHS) then {
	switch _tipo do {
		case opI_AAR: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_AR2: {};
		case opI_AR: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_CREW: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_GL: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_LAT: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_MED: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_MK2: {};
		case opI_MK: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_OFF2: {};
		case opI_OFF: {};
		case opI_PIL: {};
		case opI_RFL1: {};
		case opI_RFL2: {};
		case opI_SL: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
		case opI_SP: {[_unit, _tipo] call fnc_gear_loadoutCSAT};
	};
};

_unit addEventHandler ["HandleDamage",handleDamageAAF];
_unit addEventHandler ["killed",AAFKilledEH];
