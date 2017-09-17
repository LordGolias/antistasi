#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_addAllRoadblocks");
{
    _x call AS_location_fnc_addRoadblocks;
} forEach ("AAF" call AS_location_fnc_S);
