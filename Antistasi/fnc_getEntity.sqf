#include "macros.hpp"
params ["_side", "_type"];

[AS_entities, _side call AS_fnc_getFaction, _type] call DICT_fnc_get
