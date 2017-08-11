// Cleans up unneeded resources once they are far from any BLUFOR.
#include "../macros.hpp"
params [["_groups", []], ["_vehicles", []], ["_markers", []]];

{
    deleteMarker _x;
} forEach _markers;

{
    private _group = _x;
    {
        _x spawn {
            params ["_unit"];
            waitUntil {sleep (5 + random 5); not ([AS_P("spawnDistance"), 1, _unit, "BLUFORSpawn"] call distanceUnits)};

            if (count units group _unit == 1) then {
                // clean group after last unit
                deleteVehicle _unit;
                deleteGroup (group _unit);
            } else {
                deleteVehicle _unit;
            };
        };
    } forEach units _group;
} forEach _groups;

{
    [_x] spawn vehicle_despawn;
} forEach _vehicles;
