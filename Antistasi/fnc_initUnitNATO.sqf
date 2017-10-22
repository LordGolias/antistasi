params ["_unit"];
[_unit, "NATO"] call AS_fnc_setSide;

[_unit] call AS_debug_fnc_initUnit;

[_unit] call AS_medical_fnc_initUnit;
_unit allowFleeing 0;

[_unit] call AS_fnc_setDefaultSkill;

_unit setVariable ["BLUFORSpawn",true,true];

_unit addEventHandler ["killed", {
	private _muerto = _this select 0;
	[0.25,0,getPos _muerto] remoteExec ["AS_fnc_changeCitySupport",2];
	[_muerto] remoteExec ["AS_fnc_activateCleanup",2];
	}];

if (sunOrMoon > 1) then {
	_unit call AS_fnc_removeNightEquipment;
};

_unit enableIRLasers true;
_unit enableGunLights "AUTO";
