#include "macros.hpp"
AS_CLIENT_ONLY("fnc_selectNewHQ");

AS_commander allowDamage false;
"Petros is Dead" hintC "Petros has been killed. You lost part of your assets and need to select a new HQ position far from the enemies.";

private _position = [false] call AS_fnc_UI_newGame_selectHQ;

[_position, false] remoteExec ["AS_fnc_HQplace", 2];
