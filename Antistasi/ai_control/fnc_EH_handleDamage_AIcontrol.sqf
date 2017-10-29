params ["_unit", "_part", "_dam", "_injurer"];

// we only need this in 1 (any) body part
if (_part != "head") exitwith {};

if (isPlayer _unit) then {
	call AS_fnc_completeDropAIcontrol;
} else {
	if (local _unit) then {
		private _owner = _unit getVariable "AS_controller";
		if (not isNil "_owner" and {_owner == _unit}) then {
			removeAllActions player;
			selectPlayer _owner;
			{[_x] joinsilent group player} forEach units group player;
			group player selectLeader player;
			hint "Returned to original Unit as it received damage";
		};
	};
};
0
