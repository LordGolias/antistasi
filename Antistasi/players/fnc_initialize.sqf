#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_initialize");

if isNil "AS_container" then {
    AS_container = call DICT_fnc_create;
    publicVariable "AS_container";
};
[AS_container, "players", call DICT_fnc_create] call DICT_fnc_setGlobal;
