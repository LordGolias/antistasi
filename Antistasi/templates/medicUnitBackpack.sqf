// order matters: items will be add sequentially until bag is full.
AS_fnc_FIAMedicBackpack = {
    call {
        if (hayACE and ace_medical_level == 1) exitWith {
            [["ACE_fieldDressing", 50], ["ACE_morphine", 25], ["ACE_epinephrine", 20], ["ACE_bloodIV", 100]]  // 100 => the remaining space.
        };
        // todo: add ACE lvl 2
        [["FirstAidKit", 10], ["Medikit", 1]]
    };
};
