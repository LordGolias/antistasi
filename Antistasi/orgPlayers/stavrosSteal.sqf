#include "../macros.hpp"
private _resourcesFIA = AS_P("resourcesFIA");
if (_resourcesFIA < 100) exitWith {hint "FIA has not enough resources to grab"};
[100] call resourcesPlayer;
[0,-100] remoteExec ["resourcesFIA",2];
[-2, AS_commander] remoteExec ["AS_fnc_changePlayerScore", 2];

hint "You grabbed 100 € from the FIA Money Pool.\n\nThis will affect your status among FIA forces";
