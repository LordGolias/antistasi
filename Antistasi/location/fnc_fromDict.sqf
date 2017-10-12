#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_fromDict");
params ["_dict"];
// delete every location (including markers)
{_x call AS_location_fnc_remove} forEach (call AS_location_fnc_all);
call AS_location_fnc_deinitialize;

// load every location
[AS_container, "location", _dict call DICT_fnc_copyGlobal] call DICT_fnc_setGlobal;

// load non-persistent stuff (e.g. markers, spawned, roads)
{
    // _x is a location

    // initialize non-persistent properties
    [_x, "spawned", false] call AS_location_fnc_set;
    [_x, "forced_spawned", false] call AS_location_fnc_set;
    if ((_x call AS_location_fnc_type) == "city") then {
        private _roads = [_x call AS_location_fnc_position, _x call AS_location_fnc_size] call AS_location_fnc_getCityRoads;
        [_x, "roads", _roads] call AS_location_fnc_set;
    };

    // create hidden marker if it does not exist.
    if (getMarkerColor _x == "") then {
        createmarker [_x, _x call AS_location_fnc_position];
    } else {
        _x setMarkerPos (_x call AS_location_fnc_position);
    };
    // properties that are not stored in the save and therefore must be re-assigned
    _x setMarkerSize [_x call AS_location_fnc_size, _x call AS_location_fnc_size];
    _x setMarkerShape "ELLIPSE";
    _x setMarkerBrush "SOLID";
    _x setMarkerColor "ColorGUER";
    _x setMarkerAlpha 0;

    // finally, show the marker on the map
    _x call AS_location_fnc_updateMarker;
} forEach (call AS_location_fnc_all);
