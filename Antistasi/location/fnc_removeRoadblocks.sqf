#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_removeRoadblocks");
params [ "_location"];

private _roadblocks = ("roadblock" call AS_location_fnc_T) select {[_x,"location"] call AS_location_fnc_get == _location};
{
    [_x] spawn {
        params ["_roadblock"];
        waitUntil {sleep 5; !(_roadblock call AS_location_fnc_spawned)};
        _roadblock call AS_location_fnc_remove;
    };
} forEach _roadblocks;
