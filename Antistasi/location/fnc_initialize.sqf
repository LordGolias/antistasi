#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_initialize");
if isNil "AS_container" then {
    AS_container = call DICT_fnc_create;
    publicVariable "AS_container";
};
[AS_container, "location"] call DICT_fnc_add;
