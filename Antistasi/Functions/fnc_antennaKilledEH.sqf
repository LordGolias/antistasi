params ["_antenna"];
antenas = antenas - [getPos _antenna];
antenasmuertas = antenasmuertas + [getPos _antenna];
publicVariable "antenas";
publicVariable "antenasmuertas";
[["TaskSucceeded", ["", "Radio Tower Destroyed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
_antenna removeAllEventHandlers "Killed";
