#include "../macros.hpp"
private _resourcesFIA = AS_P("resourcesFIA");
if (_resourcesFIA < 100) exitWith {hint "FIA has not enough resources to grab"};
[100] call resourcesPlayer;
[0,-100] remoteExec ["resourcesFIA",2];
//[-2,AS_commander] call playerScoreAdd;
["scorePlayer", player getVariable "score"] call fn_SaveStat;

//hint "You grabbed 100 € from the FIA Money Pool.\n\nThis will affect your prestige and status among FIA forces";
hint "You grabbed 100 € from the FIA Money Pool.\n\nDon't spend it all on hookers and blackjack.";
