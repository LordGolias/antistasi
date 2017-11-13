#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_remove");
params ["_location"];
[call AS_location_fnc_dictionary, _location] call DICT_fnc_del;

// the hidden marker
deleteMarker _location;

// the shown marker
deleteMarker (format ["Dum%1", _location]);
