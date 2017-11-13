params ["_unit"];
[_unit] call AS_debug_fnc_initUnit;

[_unit] call AS_medical_fnc_initUnit;
_unit allowFleeing 0;

_unit setVariable ["AS_side", "NATO", true];

[_unit] call AS_fnc_setDefaultSkill;

_unit setVariable ["BLUFORSpawn",true,true];

_unit addEventHandler ["killed", {
	private _muerto = _this select 0;
	[0.25,0,getPos _muerto] remoteExec ["AS_fnc_changeCitySupport",2];
	[_muerto] remoteExec ["AS_fnc_activateCleanup",2];
	}];

if (sunOrMoon < 1) then {
	if (bluIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};
