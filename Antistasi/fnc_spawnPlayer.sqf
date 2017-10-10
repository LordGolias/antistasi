#include "macros.hpp"
AS_CLIENT_ONLY("fnc_spawnPlayer");
params ["_type", ["_oldFate", "delete"]];

call AS_fnc_completeDropAIcontrol;

private _isCommander = (player == AS_commander);
private _default_score = 0;
if _isCommander then {_default_score = 25}; // so the commander does not lose the position immediately.

private _group = createGroup side_blue; // the player starts as civ, so this changes player's side

private _old_player = player;
private _position = position player;
private _compromised = player getvariable ["compromised", 0];
private _punish = player getVariable ["punish", 0];
private _money = player getVariable ["money", 0];
private _eligible = player getVariable ["elegible", true];
private _rank = player getVariable ["rank", AS_ranks select 0];
private _score = player getVariable ["score", _default_score];
private _garage = player getVariable ["elegible", true];

private _unit = [_type, _position, _group] call AS_fnc_spawnFIAunit;
[_unit] call AS_fnc_emptyUnit;
_unit setVariable ["BLUFORSpawn", true, true]; // players make things spawn

_unit setvariable ["compromised", _compromised];
_unit setVariable ["punish", _punish, true];
_unit setVariable ["money", _money, true];
_unit setVariable ["elegible", _eligible, true];
_unit setUnitRank _rank;
_unit setVariable ["rank", _rank, true];
_unit setVariable ["score", _score, true];
_unit setVariable ["garage", _garage, true];

selectPlayer _unit;

if _isCommander then {
	[_unit] remoteExec ["AS_fnc_setCommander", 2];
};

// init event handlers, medic, etc.
call AS_fnc_initPlayer;

if (_oldFate == "delete") then {
    {deleteVehicle _x} forEach units group _old_player;
    deleteGroup group _old_player;
};
if (_oldFate == "kill") then {
    {[_x] joinsilent group player} forEach units group _old_player;
    group player selectLeader player;
    _old_player setVariable ["BLUFORSpawn",nil,true];
    _old_player setDamage 1;
    [_old_player] remoteExec ["AS_fnc_activateCleanup", 2];
};

// remove any progress bar the player had
[0,true] remoteExec ["AS_fnc_showProgressBar",player];

_unit
