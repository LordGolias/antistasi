params ["_unit", ["_place", nil]];

if (!isNil "_place") then {_unit setVariable ["marcador", _place]};

[_unit] call initRevive;
_unit allowFleeing 0;

[_unit, server getVariable "skillFIA"] call AS_fnc_setDefaultSkill;

[_unit] call randomRifle;

_EHkilledIdx = _unit addEventHandler ["killed", {
	_muerto = _this select 0;
	_killer = _this select 1;
	[_muerto] remoteExec ["postmortem",2];
	if (isPlayer _killer) then {
		if (!isMultiPlayer) then {
			[0,20] remoteExec ["resourcesFIA",2];
			_killer addRating 1000;
		};
	};
	[0,-0.25,getPos _muerto] remoteExec ["citySupportChange",2];
	_marcador = _muerto getVariable "marcador";
	if (!isNil "_marcador") then {
		if (_marcador in mrkFIA) then {
			_garrison = garrison getVariable [_marcador,[]];
			for "_i" from 0 to (count _garrison -1) do {
				if (typeOf _muerto == (_garrison select _i)) exitWith {_garrison deleteAt _i};
			};
			garrison setVariable [_marcador,_garrison,true];
			[_marcador] call mrkUpdate;
		};
	};
}];
