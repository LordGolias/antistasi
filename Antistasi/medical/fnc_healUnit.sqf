params ["_medic", "_target"];
if (not hayACEMedical) then {
    _target setVariable ["AS_medical_assignedMedic", _medic];
    _medic setVariable ["AS_medical_assignedPatient", _target];
    [_medic, _target] spawn AS_medical_fnc_healAction;
} else {
    // for ACE, assign medic to unit
    _target setVariable ["ace_medical_ai_assignedMedic", _medic];
    private _healQueue = _medic getVariable ["ace_medical_ai_healQueue", []];
    _healQueue pushBack _target;
    _medic setVariable ["ace_medical_ai_healQueue", _healQueue];
};
