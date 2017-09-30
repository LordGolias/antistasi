#include "macros.hpp"
params ["_unit", "_part", "_dam", "_injurer"];

if (captive _injurer) then {
	_injurer setCaptive 0;
};
if (_injurer isKindOf "LandVehicle" and {_injurer getVariable "side" == "FIA"}) then {
	AS_Sset("reportedVehs", AS_S("reportedVehs") + [_injurer]);
};

private _currentTime = [time, serverTime] select isMultiplayer;
if ((_part == "head") and not (_unit call AS_medical_fnc_isUnconscious)) then {
	_unit setVariable ["firstHitTime", _currentTime, false];
};

if not (_part in ["hand_l","hand_r","leg_l","leg_r","arms"]) then {
	private _sameHit = (_unit getVariable ["firstHitTime", _currentTime]) + 0.5 >= _currentTime;
	if not _sameHit then {
        if (_unit call AS_medical_fnc_isUnconscious and _dam > 2) then {
			if isPlayer _unit then {
				hint "The hit was so violent that you died instantly...";
				[_unit] spawn AS_fnc_respawnPlayer;
			} else {
				[_unit, true] call ACE_medical_fnc_setDead;
			};
        };
	};
};
// this handler is only used to kill unconscious people
0
