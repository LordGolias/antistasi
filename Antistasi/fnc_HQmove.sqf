#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQmove.sqf");

petros enableAI "MOVE";
petros enableAI "AUTOTARGET";
petros forceSpeed -1;

[[petros, "remove"], "AS_fnc_addAction"] call BIS_fnc_MP;
call fnc_rearmPetros;
[petros] join AS_commander;
petros setBehaviour "AWARE";

if isMultiplayer then {
	{_x hideObjectGlobal true} forEach AS_permanent_HQplacements;
} else {
	{_x hideObject true} forEach AS_permanent_HQplacements;
};

"delete" call AS_fnc_HQaddObject;

sleep 5;

[[Petros, "buildHQ"],"AS_fnc_addAction"] call BIS_fnc_MP;
