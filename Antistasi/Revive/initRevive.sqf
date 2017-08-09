params ["_unit"];
[_unit,false] call AS_fnc_setUnconscious;
_unit setVariable ["respawning",false];
_unit addEventHandler ["HandleDamage", handleDamage];
