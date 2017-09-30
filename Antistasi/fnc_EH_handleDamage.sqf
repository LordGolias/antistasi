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
	if (_dam > 0.95) exitWith {
		private _sameHit = (_unit getVariable ["firstHitTime", _currentTime]) + 0.5 >= _currentTime;
		if (_sameHit and _dam < 10) then {
			_dam = 0.9;
			if not (_unit call AS_medical_fnc_isUnconscious) then {
				[_unit,true] call AS_medical_fnc_setUnconscious;
			};
		} else {
			// very high damage (the unit is killed regardless)
			if (isPlayer _unit) then {
				// players do not die, they respawn
				hint "The hit was so violent that you died instantly...";
				_dam = 0;
				[_unit] spawn AS_fnc_respawnPlayer;
				if (isPlayer _injurer and {_injurer != _unit}) then {
					// a player killed another player
					[_injurer,60] remoteExec ["AS_fnc_penalizePlayer",_injurer]
				};
			};
		};
	};
	if ((not (_unit call AS_medical_fnc_isUnconscious)) and _dam > 0.2) then {
		[_unit,_unit] spawn AS_AI_fnc_smokeCover;
	};
};
_dam
