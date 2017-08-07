params ["_unit","_part","_dam","_injurer"];

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

if (_part == "") then {
	call {
		if (_dam > 0.95) exitWith {
			if (!(_unit getVariable "inconsciente")) then {
				_dam = 0.9;
				[_unit] spawn inconsciente;
			} else {
				if (isPlayer _unit) then {
					_dam = 0;
					[_unit] spawn respawn;
					if (isPlayer _injurer and {_injurer != _unit}) then {
						// a player killed another unconcious player
						[_injurer,60] remoteExec ["castigo",_injurer]
					};
				} else {
					_unit removeAllEventHandlers "HandleDamage";
				};
			};
		};
		if (_dam > 0.2) then {
			[_unit,_unit] spawn cubrirConHumo;
		};
		if (_dam > 0.25) then {
			if (isPlayer (leader group _unit)) then {
				if autoheal then {
					_unit groupChat "Injured!";
					private _ayudado = _unit getVariable "ayudado";
					if (isNil "_ayudado") then {
						[_unit] call pedirAyuda;
					};
				};
			};
		};
	};
} else {
	if (_part == "head" and {_dam > 0.95}) then {
		removeHeadgear _unit;
        _dam = 0.9;
	};
};
_dam
