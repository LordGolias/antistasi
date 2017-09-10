params ["_unit", "_part", "_dam", "_injurer"];

if (isPlayer _unit) then {
	private _owner = player getVariable ["owner",player];
	if (_owner != player) then {
		if ((isNull _injurer) and (_unit distance fuego < 10)) then {
			_dam = 0;
		} else {
			removeAllActions _unit;
			selectPlayer _owner;
			_unit setVariable ["owner",_owner,true];
			{[_x] joinsilent group player} forEach units group player;
			group player selectLeader player;
			hint "Returned to original Unit as controlled AI received damage";
		};
	};
} else {
	if (local _unit) then {
		private _owner = _unit getVariable "owner";
		if (!isNil "_owner") then {
			if (_owner==_unit) then {
				if ((isNull _injurer) and (_unit distance fuego < 10)) then {
					_dam = 0;
				} else {
					removeAllActions player;
					selectPlayer _owner;
					{[_x] joinsilent group player} forEach units group player;
					group player selectLeader player;
					hint "Returned to original Unit as it received damage";
				};
			};
		};
	};
};

private _currentTime = [time, serverTime] select isMultiplayer;
if ((_part == "head") and not (_unit call AS_fnc_isUnconscious)) then {
	_unit setVariable ["firstHitTime", _currentTime, false];
};

if not (_part in ["hand_l","hand_r","leg_l","leg_r","arms"]) then {
	private _sameHit = (_unit getVariable ["firstHitTime", _currentTime]) + 0.5 >= _currentTime;
	if not _sameHit then {
        if (_unit call AS_fnc_isUnconscious and _dam > 2) then {
			if isPlayer _unit then {
				[_unit] spawn respawn;
			} else {
				[_unit, true] call ACE_medical_fnc_setDead;
			};
        };
	};
};
// this handler is only used to kill unconscious people or people
0
