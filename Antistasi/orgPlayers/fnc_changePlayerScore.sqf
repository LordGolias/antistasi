#include "../macros.hpp"
AS_SERVER_ONLY("fnc_changePlayerScore.sqf");

params ["_value", "_player", ["_notify", true]];

if (not isPlayer _player or _value == 0) exitWith {};

_player = _player getVariable ["owner", _player];

// money is never taken from the player, only score
private _moneyChange = _value * 5;
if (_moneyChange < 0) then {
	_moneyChange = 0;
};

_player setVariable ["score", (_player getVariable ["score", 0]) + _value,true];
_player setVariable ["dinero", (_player getVariable ["dinero", 0]) + _moneyChange, true];
if (_notify and _moneyChange != 0) then {
	private _texto = format ["<br/><br/><br/><br/><br/><br/>Money +%1 €",_moneyChange];
	[petros, "income", _texto] remoteExec ["commsMP", _player];
};
