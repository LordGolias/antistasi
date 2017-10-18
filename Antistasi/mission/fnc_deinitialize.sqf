#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_deinitialize");
if ([AS_container, "mission"] call DICT_fnc_exists) then {
    [AS_container, "mission"] call DICT_fnc_del;
};
