#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_loadGame");
params ["_data"];
_data call AS_database_fnc_deserialize;
["Game loaded"] remoteExecCall ["hint", 2];
