#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_set");
params ["_location", "_property", "_value", ["_update",true]];
if (_property != "type" and {not (_property in ((_location call AS_location_fnc_type) call AS_location_fnc_properties))}) exitWith {
    diag_log format ["[AS] Error: AS_location_fnc_set: wrong property '%1' for location '%2'", _property, _location];
};
[call AS_location_fnc_dictionary, _location, _property, _value] call DICT_fnc_setGlobal;
if not _update exitWith {};

if (_property == "position") then {
    _location setMarkerPos _value;
};
if (_property in ["position", "side", "garrison"]) then {
    _location call AS_location_fnc_updateMarker;
};
