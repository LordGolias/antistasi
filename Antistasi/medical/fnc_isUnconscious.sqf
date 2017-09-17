params ["_unit"];
if (not hayACEMedical) then {
    _unit getVariable ["AS_medical_isUnconscious", false]
} else {
    _unit getVariable ["ACE_isUnconscious", false]
};
