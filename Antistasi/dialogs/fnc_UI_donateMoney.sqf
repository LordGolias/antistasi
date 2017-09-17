params ["_toCursorTarget"];

if (call AS_fnc_controlsAI) exitWith {
	hint "You can't donate when you are controlling an AI";
};

if ((player getVariable "money") < 100) exitWith {
	hint "You have less than 100 € to donate";
};

if not _toCursorTarget exitWith {
	[-100] call AS_fnc_changePlayerMoney;
	[0, 100] remoteExec ["AS_fnc_changeFIAmoney", 2];
	player setVariable ["score", (player getVariable ["score", 0]) + 2,true];

	hint "You have donated 100 € to FIA. This will raise your status among FIA forces";
};

private _target = cursortarget;

if (!isPlayer _target) exitWith {
	hint "You must be looking to a player in order to give him money (and he must not be controlling an AI)";
};
if (_target != _target getVariable ["owner", _target]) exitWith {
	hint "You can't donate to a controlled AI";
};

[-100] call AS_fnc_changePlayerMoney;
_target setVariable ["money", (_target getVariable "money") + 100, true];
hint format ["You donated 100 € to %1", name _target];
