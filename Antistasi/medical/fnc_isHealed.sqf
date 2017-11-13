// Used by non-ACE to test whether the unit is healed or not
params ["_unit"];
{
    if ((_unit getHit _x) > 0.8) exitWith {false};
    true
} forEach ["neck","head","pelvis","spine1","spine2","spine3","body",""]
