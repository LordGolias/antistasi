#include "macros.hpp"
params ["_unit"];


if (not isNil "AS_respawning") exitWith {
	diag_log "[AS] Error: unit was respawned while respawning";
};
if not (call AS_fnc_controlsAI) exitWith {
	diag_log "[AS] Error: unit was respawned while controlling an AI";
	call AS_fnc_completeDropAIcontrol;
};
if not isPlayer _unit exitWith {
	diag_log "[AS] Error: non-player was respawned";
};
AS_respawning = true; // avoids double-respawn

["Respawning",0,0,3,0,0,4] spawn bis_fnc_dynamicText;
titleText ["", "BLACK IN", 0];

if isMultiplayer then {
	_unit setDamage 1; // triggers onPlayerRespawn.sqf
} else {
	[objNull] call compile preprocessFileLineNumbers "onPlayerRespawn.sqf";
};
AS_respawning = nil;
