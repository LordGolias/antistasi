#include "macros.hpp"
AS_SERVER_ONLY("AS_fnc_startGame.sqf");
params ["_side", "_guerrilla", "_pro_guerrilla", "_state", "_pro_state"];

if (_side == "west") then {
    side_blue = west;
    side_red = east;
} else {
    side_blue = east;
    side_red = west;
};
publicVariable "side_blue";
publicVariable "side_red";

AS_Pset("faction_guerrilla", _guerrilla);
AS_Pset("faction_pro_guerrilla", _pro_guerrilla);
AS_Pset("faction_state", _state);
AS_Pset("faction_pro_state", _pro_state);

AS_Pset("player_side", _side);

[] remoteExec ["AS_fnc_HQselect", AS_commander];
