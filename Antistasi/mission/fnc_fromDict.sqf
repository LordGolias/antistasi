#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_fromDict");
params ["_dict"];
call AS_mission_fnc_deinitialize;
[AS_container, "mission", _dict call DICT_fnc_copy] call DICT_fnc_set;

{_x call AS_mission_fnc_activate} forEach ([] call AS_mission_fnc_active_missions);
