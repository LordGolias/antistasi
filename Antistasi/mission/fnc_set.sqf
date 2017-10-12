#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_set");
params ["_mission", "_property", "_value"];
[call AS_mission_fnc_dictionary, _mission, _property, _value] call DICT_fnc_setGlobal
