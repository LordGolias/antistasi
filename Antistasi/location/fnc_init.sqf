// initializes the location's required properties.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_init");
params ["_location"];

switch (_location call AS_location_fnc_type) do {
    case "city": {
        [_location,"AAFsupport",50, false] call AS_location_fnc_set;
        [_location,"FIAsupport",0, false] call AS_location_fnc_set;
    };
    case "fia_hq": {
        [_location,"side","FIA", false] call AS_location_fnc_set;
    };
    case "base": {
        [_location,"side","AAF", false] call AS_location_fnc_set;
        [_location,"busy",dateToNumber date, false] call AS_location_fnc_set;
    };
    case "airfield": {
        [_location,"side","AAF", false] call AS_location_fnc_set;
        [_location,"busy",dateToNumber date, false] call AS_location_fnc_set;
    };
    case "minefield": {
        [_location, "mines", [], false] call AS_location_fnc_set;  // [type, pos, dir]
        [_location, "found", false, false] call AS_location_fnc_set;
    };
    case "roadblock": {
        [_location,"side","AAF", false] call AS_location_fnc_set;
        [_location, "location", "", false] call AS_location_fnc_set;
    };
    default {
        [_location,"side","AAF", false] call AS_location_fnc_set;
    };
};
if ("garrison" in ((_location call AS_location_fnc_type) call AS_location_fnc_properties)) then {
    [_location,"garrison",[], false] call AS_location_fnc_set;
};
[_location,"spawned",false, false] call AS_location_fnc_set;
[_location,"forced_spawned",false, false] call AS_location_fnc_set;
