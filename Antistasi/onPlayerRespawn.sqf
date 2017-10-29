#include "macros.hpp"
if (isDedicated) exitWith {};
params ["_new", "_old"];

if (player call AS_fnc_controlsAI) exitWith {
	hint "The unit you were controlling died";
	call AS_fnc_completeDropAIcontrol;
	deleteVehicle _new;
};

// temporarly set the commander locally. It is meant to be overwritten by AS_fnc_spawnPlayer.
if (_old == AS_commander) then {
	AS_commander = _new;
};
private _type = player call AS_fnc_getFIAUnitType;
private _unit = [_type, "delete"] call AS_fnc_spawnPlayer;

waitUntil {player == _unit};

if isMultiplayer then {
	private _money = [player, "money"] call AS_players_fnc_get;
	[player, "money", -round (0.1*_money)] remoteExec ["AS_players_fnc_change", 2];
	[player, "score", -10] remoteExec ["AS_players_fnc_change", 2];
} else {
	private _money = AS_P("resourcesFIA");
	[-1, -0.1*_money] remoteExec ["AS_fnc_changeFIAmoney", 2];
};
