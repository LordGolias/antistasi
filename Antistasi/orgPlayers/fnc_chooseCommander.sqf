#include "../macros.hpp"
AS_SERVER_ONLY("orgPlayers/fnc_chooseCommander.sqf");

params [["_reason", "none"]];

call fnc_BE_pushVariables;

private _currentScore = -100000;
private _commander = AS_commander getVariable ["owner", AS_commander];
private _noCommander = (isNull _commander or _reason == "resigned" or _reason == "disconnected");

if not _noCommander then {
	_currentScore = [_commander, "score"] call AS_players_fnc_get;
	[_commander, "elegible", false] call AS_players_fnc_set;  // so it is not selected again
};

private _members = [];
private _eligibles = [];
{
	private _player = _x getVariable ["owner", _x];
	_members pushBack _player;
	if ([_player, "elegible"] call AS_players_fnc_get) then {
		_eligibles pushBack _player;
	};
} forEach playableUnits;

// continue if there was a disconnection or there was no disconnection and switch is activated (and there is members to select)
if not ((_noCommander or (switchCom and !_noCommander)) and count _members != 0) exitWith {};

if (count _eligibles == 0) then {
	_eligibles = _members
};
if (count _eligibles == 1 and (AS_commander in _eligibles)) exitWith {
	[[petros, "hint", format["%1 tried to resign but is the only eligible commander, so it remains so", name AS_commander]], "AS_fnc_localCommunication"] call BIS_fnc_MP;
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
	private _text = "";
	if _noCommander then {
		_text = format ["The commander disconnected. %2 is our new commander. Greet him!", name _bestCandidate];
		if (_reason in ["resigned", "disconnected"]) then {
			_text = format ["The commander %1. %2 is our new commander. Greet him!", _reason, name _bestCandidate];
		};
	} else {
		_text = format ["%1 is no longer leader of the FIA.\n\n %2 is our new commander. Greet him!", name AS_commander, name _bestCandidate];
	};
	[_bestCandidate] call AS_fnc_setCommander;
	sleep 5;
	[[petros, "hint", _text], "AS_fnc_localCommunication"] call BIS_fnc_MP;
};
