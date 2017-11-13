// adds a location. The first argument must be a marker. The location
// taks ownership of it. Every location requires a different marker.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_add");
params ["_marker", "_type"];
[call AS_location_fnc_dictionary, _marker] call DICT_fnc_add;
[_marker, "type", _type, false] call AS_location_fnc_set;
[_marker, "position", getMarkerPos _marker, false] call AS_location_fnc_set;
_marker call AS_location_fnc_init;

[_marker, "size", ((getMarkerSize _marker) select 0) max ((getMarkerSize _marker) select 1), false] call AS_location_fnc_set;
_marker setMarkerAlpha 0;
_marker call AS_location_fnc_updateMarker;
