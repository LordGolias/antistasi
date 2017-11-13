#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_initialize");
if isNil "AS_container" then {
    AS_container = call DICT_fnc_create;
    publicVariable "AS_container";
};
[AS_container, "mission"] call DICT_fnc_add;
