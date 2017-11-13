#include "../../macros.hpp"

if not isMultiplayer exitWith {
    hint "In single player your money is FIA money";
};
if (AS_P("resourcesFIA") < 100) exitWith {
    hint "FIA does not have money"
};

[player, 100] remoteExec ["AS_fnc_changePlayerMoney", 2];
[0,-100] remoteExec ["AS_fnc_changeFIAmoney", 2];
[-2, player] remoteExec ["AS_fnc_changePlayerScore", 2];

hint "You grabbed 100 € from the FIA Money Pool.\n\nThis will affect your status among FIA forces";
closeDialog 0;
