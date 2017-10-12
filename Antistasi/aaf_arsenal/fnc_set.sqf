#include "../macros.hpp"
AS_SERVER_ONLY("AS_AAFarsenal_fnc_set");
params ["_category", "_property", "_value"];
[call AS_AAFarsenal_fnc_dictionary, _category, _property, _value] call DICT_fnc_setGlobal;
