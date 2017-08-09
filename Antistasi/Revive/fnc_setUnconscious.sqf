params ["_unit", "_unconscious"];
if (not hayACEMedical) then {
    _unit setVariable ["inconsciente",_unconscious,true];
} else {
    [_unit, _unconscious, 10, true] call ACE_medical_fnc_setUnconscious;
};
