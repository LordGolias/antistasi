params ["_unit", "_medic"];
if not hayACEmedical then {
    _unit setVariable ["AS_medical_assignedMedic", nil];
    _medic setVariable ["AS_medical_assignedPatient", nil];
} else {
    _unit setVariable ["ace_medical_ai_assignedMedic", objNull];
    _medic setVariable ["ace_medical_ai_healQueue", []];
};
