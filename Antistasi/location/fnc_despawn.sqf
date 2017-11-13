// despawns a location
// use `_location` to normal despawn,
// use `[_location, true]` to forced despawn
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_despawn");
params ["_location", ["_forced", false]];

if _forced then {
    [_location,"forced_spawned",false] call AS_location_fnc_set;
} else {
    [_location,"spawned",false] call AS_location_fnc_set;
};
