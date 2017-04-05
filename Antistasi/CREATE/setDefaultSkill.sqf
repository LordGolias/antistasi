#include "../macros.hpp"
params ["_unit", ["_sideSkill", AS_maxSkill]];
private ["_defaultSkill"];
_unit setSkill (AS_P("minAISkill") + (AS_P("maxAISkill") - AS_P("minAISkill"))*_sideSkill/AS_maxSkill);
