params ["_unit"];
_unit setVariable ["inconsciente",false,true];
_unit setVariable ["respawning",false];
_unit addEventHandler ["HandleDamage", handleDamage];
