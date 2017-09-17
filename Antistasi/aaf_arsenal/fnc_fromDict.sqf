#include "../macros.hpp"
AS_SERVER_ONLY("AS_AAFarsenal_fnc_fromDict");
params ["_dict"];
call AS_AAFarsenal_fnc_deinitialize;
[AS_container, "aaf_arsenal", _dict call DICT_fnc_copy] call DICT_fnc_set;
