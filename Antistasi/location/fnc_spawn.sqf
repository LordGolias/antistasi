// Spawns a location
// use `_location` to normal spawn,
// use `[_location, true]` to forced spawn
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_spawn");
params ["_location", ["_forced", false]];
if _forced then {
    [_location,"forced_spawned",true] call AS_location_fnc_set;
} else {
    [_location,"spawned",true] call AS_location_fnc_set;
};
