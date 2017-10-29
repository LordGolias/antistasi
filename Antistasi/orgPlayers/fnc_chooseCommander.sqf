#include "../macros.hpp"
AS_SERVER_ONLY("orgPlayers/fnc_chooseCommander.sqf");

params [["_reason", "none"], ["_notify", True]];

private _currentScore = -100000;
private _commander = AS_commander getVariable ["AS_controller", AS_commander];
private _noCommander = (isNull _commander or _reason == "resigned" or _reason == "disconnected");

// There is a commander and switch is off => no change
if (not switchCom and not _noCommander) exitWith {};

private _members = [];
private _eligibles = [];
while {count _members == 0} do {
	{
		private _player = _x getVariable ["AS_controller", _x];
		_members pushBack _player;
		if ([_player, "elegible"] call AS_players_fnc_get) then {
			_eligibles pushBack _player;
		};
	} forEach (allPlayers - (entities "HeadlessClient_F"));

	if (count _members == 0) then {
		diag_log "[AS] Server: no player to choose for commander.";
		sleep 5;
	};
};

if (count _eligibles == 0) then {
	_eligibles = _members
};
if (count _eligibles == 1 and (AS_commander in _eligibles)) exitWith {
	[[petros, "hint", format["%1 tried to resign but is the only eligible commander, so it remains so", name AS_commander]], "AS_fnc_localCommunication"] call BIS_fnc_MP;
};

if not _noCommander then {
	_currentScore = [_commander, "score"] call AS_players_fnc_get;
	[_commander, "elegible", false] call AS_players_fnc_set;  // so it is not selected again
};

// select player with highest score (and more than 20% than commander)
_currentScore = round (_currentScore*1.2);
private _bestCandidate = objNull;
{
	private _score = [_x, "score"] call AS_players_fnc_get;
	if (_score > _currentScore) then { // this will fail for the commander, so it is never a candidate
		_bestCandidate = _x;
		_currentScore = _score;
	};
} forEach _eligibles;

if !(isNull _bestCandidate) then {
	[_bestCandidate] call AS_fnc_setCommander;

	private _text = "";
	if _noCommander then {
		_text = format ["%1 is the commander.", name _bestCandidate];
		if (_reason in ["resigned", "disconnected"]) then {
			_text = format ["The commander %1. %2 is our new commander. Greet him!", _reason, name _bestCandidate];
		};
	} else {
		_text = format ["%1 is no longer leader of the FIA.\n\n %2 is our new commander. Greet him!", name AS_commander, name _bestCandidate];
	};
	[[objNull, "hint", _text], "AS_fnc_localCommunication"] call BIS_fnc_MP;
};
