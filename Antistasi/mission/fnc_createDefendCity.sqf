#include "../macros.hpp"
AS_SERVER_ONLY("fnc_createDefendCity");
params ["_location"];

private _mission = ["defend_city", _location] call AS_mission_fnc_add;
_mission call AS_mission_fnc_activate;
