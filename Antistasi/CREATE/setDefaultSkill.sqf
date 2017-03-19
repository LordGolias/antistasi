params ["_unit", ["_sideSkill", AS_maxSkill]];
private ["_defaultSkill"];
_unit setSkill (AS_minAISkill + (AS_maxAISkill - AS_minAISkill)*_sideSkill/AS_maxSkill);
