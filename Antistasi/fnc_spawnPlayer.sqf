#include "macros.hpp"
AS_CLIENT_ONLY("fnc_spawnPlayer");
params ["_type", ["_oldFate", "delete"]];

call AS_fnc_completeDropAIcontrol;

private _isCommander = (player == AS_commander);
/*private _default_score = 0;
if _isCommander then {_default_score = 25}; // so the commander does not lose the position immediately.*/

private _group = createGroup ("FIA" call AS_fnc_getFactionSide);

private _old_player = player;
private _position = position player;
private _compromised = player getvariable ["compromised", 0];
private _punish = player getVariable ["punish", 0];

private _unit = [_type, _position, _group] call AS_fnc_spawnFIAunit;
[_unit] call AS_fnc_emptyUnit;
_unit call AS_fnc_equipDefault;
_unit setVariable ["BLUFORSpawn", true, true]; // players make things spawn

_unit setvariable ["compromised", _compromised];
_unit setVariable ["punish", _punish, true];

selectPlayer _unit;

if _isCommander then {
	[_unit] remoteExec ["AS_fnc_setCommander", 2];
};

// loads traits, rank, etc.
call AS_players_fnc_loadLocal;

// init event handlers, medic, etc.
call AS_fnc_initPlayer;

// Reassign player tasks (temporary fix for tasks disappearing after respawn)
private _tasks = _old_player call BIS_fnc_tasksUnit;
{
	_x call BIS_fnc_taskSetCurrent;
} foreach _tasks;

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
