#include "macros.hpp"
params ["_antenna"];
AS_Pset("antenasPos_alive", AS_P("antenasPos_alive") - [getPos _antenna]);
AS_Pset("antenasPos_dead", AS_P("antenasPos_dead") + [getPos _antenna]);
[["TaskSucceeded", ["", "Radio Tower Destroyed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
_antenna removeAllEventHandlers "Killed";
