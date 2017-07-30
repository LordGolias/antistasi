#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQmove.sqf");

petros enableAI "MOVE";
petros enableAI "AUTOTARGET";
petros forceSpeed -1;

[[petros, "remove"], "flagaction"] call BIS_fnc_MP;
call fnc_rearmPetros;
[petros] join AS_commander;
petros setBehaviour "AWARE";

if isMultiplayer then {
	{_x hideObjectGlobal true} forEach AS_permanent_HQplacements;
} else {
	{_x hideObject true} forEach AS_permanent_HQplacements;
};

call fnc_deletePad;

sleep 5;

[[Petros, "buildHQ"],"flagaction"] call BIS_fnc_MP;
