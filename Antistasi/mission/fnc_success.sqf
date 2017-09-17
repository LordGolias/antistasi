#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_success");
(_this call AS_mission_fnc__getSuccessData) call AS_mission_fnc_execute;
["mis"] call fnc_BE_XP;
