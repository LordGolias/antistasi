private ["_unit","_enemigos"];

_unit = _this select 0;

[_unit] call AS_DEBUG_initUnit;

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
		[-1,-1,getPos _muerto] remoteExec ["citySupportChange",2];
	} else {
		if (isPlayer _killer) then {
			if (!isMultiPlayer) then {
				[0,-20] remoteExec ["resourcesFIA",2];
				_killer addRating -500;
			} else {
				if (typeOf _muerto == "C_man_w_worker_F") then {_killer addRating -1000};
				[-10,_killer] call playerScoreAdd;
			};
		};
		_multiplicador = 1;
		if (typeOf _muerto == "C_journalist_F") then {_multiplicador = 10};
		if (side _killer == side_blue) then {
			[-1*_multiplicador,0] remoteExec ["prestige",2];
			[1,0,getPos _muerto] remoteExec ["citySupportChange",2];
		} else {
			if (side _killer == side_green) then {
				[1*_multiplicador,0] remoteExec ["prestige",2];
				[0,1,getPos _muerto] remoteExec ["citySupportChange",2];
			} else {
				if (side _killer == side_red) then {
					[2*_multiplicador,0] remoteExec ["prestige",2];
					[-1,1,getPos _muerto] remoteExec ["citySupportChange",2];
				};
			};
		};
	};
}];
