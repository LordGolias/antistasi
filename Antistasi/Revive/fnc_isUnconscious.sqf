params ["_unit"];

if (not hayACEMedical) then {
    _unit getVariable ["inconsciente", false]
} else {
    _unit getVariable ["ACE_isUnconscious", false]
};
