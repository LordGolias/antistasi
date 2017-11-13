private ["_unit","_enemigos"];

_unit = _this select 0;

[_unit] call AS_debug_fnc_initUnit;

_unit setVariable ["AS_side", "CIV", true];

_unit setSkill 0;

_EHkilledIdx = _unit addEventHandler ["killed", {
	_muerto = _this select 0;
	_killer = _this select 1;

	if (hayACE) then {
		if ((isNull _killer) || (_killer == _muerto)) then {
			_killer = _muerto getVariable ["ace_medical_lastDamageSource", _killer];
		};
	};

	if (_muerto == _killer) then {
		[-1,-1,getPos _muerto] remoteExec ["AS_fnc_changeCitySupport",2];
	} else {
		if (isPlayer _killer) then {
			[-20,_killer] remoteExec ["AS_fnc_changePlayerScore",2];
		};
		_multiplicador = 1;
		if (typeOf _muerto == "C_journalist_F") then {_multiplicador = 10};
		if (side _killer == side_blue) then {
			[-1*_multiplicador,0] remoteExec ["AS_fnc_changeForeignSupport",2];
			[1,0,getPos _muerto] remoteExec ["AS_fnc_changeCitySupport",2];
		} else {
			if (side _killer == side_red) then {
				[1*_multiplicador,0] remoteExec ["AS_fnc_changeForeignSupport",2];
				[0,1,getPos _muerto] remoteExec ["AS_fnc_changeCitySupport",2];
			};
		};
	};
}];
