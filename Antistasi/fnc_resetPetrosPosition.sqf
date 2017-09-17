#include "macros.hpp"
AS_SERVER_ONLY("fnc_resetPetrosPosition.sqf");
private _dir = fuego getdir cajaVeh;
private _defPos = [getPos fuego, 3, _dir + 45] call BIS_Fnc_relPos;

petros setPos _defPos;
petros setDir (petros getDir fuego);

diag_log "[AS] Server: Petros repositioned";
