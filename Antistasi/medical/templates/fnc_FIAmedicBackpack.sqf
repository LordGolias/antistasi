if hasACEmedical exitWith {
    if (ace_medical_level == 1) then {
        // order matters: items will be add sequentially until bag is full.
        [["ACE_fieldDressing", 30], ["ACE_morphine", 25], ["ACE_epinephrine", 20], ["ACE_bloodIV", 5]]
    };
    // todo: add ACE lvl 2
    [["FirstAidKit", 10], ["Medikit", 1]]
};
[["FirstAidKit", 10], ["Medikit", 1]]
