#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQbuild.sqf");

[petros] join grupoPetros;
[[petros,"remove"],"flagaction"] call BIS_fnc_MP;
[[petros,"mission"],"flagaction"] call BIS_fnc_MP;
petros forceSpeed 0;

["fia_hq", "position", getPos petros] call AS_fnc_location_set;
"fia_hq" call AS_fnc_location_updateMarker;

// place everything on its place
call AS_fnc_HQdeploy;

// and then show everything
if isMultiplayer then {
	{_x hideObjectGlobal false} forEach AS_permanent_HQplacements;
} else {
	{_x hideObject false} forEach AS_permanent_HQplacements;
};
