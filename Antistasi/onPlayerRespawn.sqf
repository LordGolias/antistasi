#include "macros.hpp"
if (isDedicated) exitWith {};
params ["_new"];

// if the side is still not chosen, players are the civilians they start as.
// (client.sqf will trigger spawnPlayer)
private _side = AS_P("player_side");
if isNil "_side" exitWith {};

if (call AS_fnc_controlsAI) exitWith {
	hint "The unit you were controlling died";
	call AS_fnc_completeDropAIcontrol;
	deleteVehicle _new;
};

private _type = player call AS_fnc_getFIAUnitType;
private _unit = [_type, "kill"] call AS_fnc_spawnPlayer;

waitUntil {player == _unit};

if isMultiplayer then {
	private _money = [player, "money"] call AS_players_fnc_get;
	[player, "money", -round (0.1*_money)] remoteExec ["AS_players_fnc_change", 2];
	[player, "score", -10] remoteExec ["AS_players_fnc_change", 2];
} else {
	private _money = AS_P("resourcesFIA");
	[-1, -0.1*_money] remoteExec ["AS_fnc_changeFIAmoney", 2];
};
