/*
	Description:
	Initializes the spawn system
*/
#include "../macros.hpp"
AS_SERVER_ONLY("AS_spawn_fnc_initialize");
[AS_container, "spawn", call DICT_fnc_create] call DICT_fnc_setGlobal;
