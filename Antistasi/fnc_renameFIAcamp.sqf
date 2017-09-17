#include "macros.hpp"
AS_SERVER_ONLY("fnc_renameFIAcamp.sqf");
private ["_camp","_name"];

[_camp, "name", _name] call AS_location_fnc_set;
