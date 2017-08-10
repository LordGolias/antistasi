params ["_antenna"];
AS_antenasPos_alive = AS_antenasPos_alive - [getPos _antenna];
AS_antenasPos_dead = AS_antenasPos_dead + [getPos _antenna];
publicVariable "AS_antenasPos_alive";
publicVariable "AS_antenasPos_dead";
[["TaskSucceeded", ["", "Radio Tower Destroyed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
_antenna removeAllEventHandlers "Killed";
