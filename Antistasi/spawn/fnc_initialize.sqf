/*
	Description:
	Initializes the spawn system
*/
#include "../macros.hpp"
AS_SERVER_ONLY("AS_spawn_fnc_initialize");

if isNil "AS_container" then {
    AS_container = call DICT_fnc_create;
    publicVariable "AS_container";
};
[AS_container, "spawn"] call DICT_fnc_add;
