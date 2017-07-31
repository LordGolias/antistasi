private ["_unit","_muerto","_killer"];

_unit = _this select 0;

_unit allowFleeing 0;

[_unit] call AS_fnc_setDefaultSkill;

if (sunOrMoon < 1) then {
	if (bluIR in primaryWeaponItems _unit) then {_unit action ["IRLaserOn", _unit]};
};

_EHkilledIdx = _unit addEventHandler ["killed", {
	_muerto = _this select 0;
	_muerto setVariable ["BLUFORSpawn",nil,true];
	[_muerto] remoteExec ["postmortem",2];
	[0.25,0,getPos _muerto] remoteExec ["citySupportChange",2];
	//if (group _muerto == group player) then {namesFIASoldiers = namesFIASoldiers + [name _muerto]};
	}];
