#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_success");
(_this call AS_mission_fnc__getSuccessData) call AS_mission_fnc_execute;
[_this, "status", "completed"] call AS_mission_fnc_set;
["mis"] call fnc_BE_XP;
