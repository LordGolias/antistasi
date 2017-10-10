#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_persistents_start");

// modify map items consequent of the persistents
{
    private _antenna = nearestBuilding _x;
    _antenna removeAllEventHandlers "Killed";
    _antenna setDamage 1;
} forEach AS_P("antenasPos_dead");
{
    private _antenna = nearestBuilding _x;
    _antenna removeAllEventHandlers "Killed";
    _antenna setDamage 0;
    _antenna addEventHandler ["Killed", AS_fnc_antennaKilledEH];
} forEach AS_P("antenasPos_alive");

{
    [_x, false] call AS_fnc_destroy_location;
} forEach AS_P("destroyedLocations");

// destroy the buildings.
{
    private _buildings = [];
    private _dist = 5;
    while {count _buildings == 0} do {
        _buildings = nearestObjects [_x, AS_destroyable_buildings, _dist];
        _dist = _dist + 5;
    };
    (_buildings select 0) setDamage 1;
} forEach AS_P("destroyedBuildings");

// this depends on destroyed locations, so it is run here
{
    [_x] call AS_fnc_recomputePowerGrid;
} forEach ("powerplant" call AS_location_fnc_T);

// resume saved patrols
[] spawn {
   sleep 25;
   {
    [[_x], "AS_movement_fnc_sendAAFpatrol"] call AS_scheduler_fnc_execute;
   } forEach AS_P("patrollingLocations");
{
    [[_x], "AS_movement_fnc_sendAAFpatrol"] call AS_scheduler_fnc_execute;
   } forEach AS_P("patrollingPositions");
};
