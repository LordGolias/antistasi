params ["_target"];
if (not hasACEMedical) then {
    _target getVariable ["AS_medical_assignedMedic", objNull]
} else {
    _target getVariable ["ace_medical_ai_assignedMedic", objNull]
};
