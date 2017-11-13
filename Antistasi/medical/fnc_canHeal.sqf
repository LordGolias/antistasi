params ["_medic"];
if not hayACEmedical exitWith {
    "FirstAidKit" in (items _medic)
};
true // for ACE, ACE handles it
