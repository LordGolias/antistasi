params ["_toCursorTarget"];

if (player call AS_fnc_controlsAI) exitWith {
	hint "You can't donate when you are controlling an AI";
};

if (([player, "money"] call AS_players_fnc_get) < 100) exitWith {
	hint "You have less than 100 € to donate";
};

if not _toCursorTarget exitWith {
	[player, "money", -100] remoteExec ["AS_players_fnc_change", 2];
	[0, 100] remoteExec ["AS_fnc_changeFIAmoney", 2];
	[player, "score", 2] remoteExec ["AS_players_fnc_change", 2];

	hint "You have donated 100 € to FIA. This will raise your status among FIA forces";
};

private _target = cursortarget;

if (!isPlayer _target) exitWith {
	hint "You must be looking to a player in order to give him money (and he must not be controlling an AI)";
};
if (_target call AS_fnc_controlsAI) exitWith {
	hint "You can't donate to a controlled AI";
};

[player, "money", -100] remoteExec ["AS_players_fnc_change", 2];
[_target, "money", 100] remoteExec ["AS_players_fnc_change", 2];
hint format ["You donated 100 € to %1", name _target];
