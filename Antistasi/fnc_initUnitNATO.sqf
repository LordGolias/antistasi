params ["_unit"];
[_unit] call AS_DEBUG_initUnit;

_unit allowFleeing 0;

[_unit] call AS_fnc_setDefaultSkill;

_unit addEventHandler ["killed", {
	private _muerto = _this select 0;
	[0.25,0,getPos _muerto] remoteExec ["citySupportChange",2];
	[_muerto] remoteExec ["postmortem",2];
	}];

if (sunOrMoon < 1) then {
	if (bluIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};
