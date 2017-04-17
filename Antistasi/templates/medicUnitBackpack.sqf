// order matters: items will be add sequentially until bag is full.
AS_fnc_FIAMedicBackpack = {
    call {
        if (hayACE) exitWith {
            if (ace_medical_level == 1) then {
                [["ACE_fieldDressing", 30], ["ACE_morphine", 25], ["ACE_epinephrine", 20], ["ACE_bloodIV", 5]]
            };
            // todo: add ACE lvl 2
            [["FirstAidKit", 10], ["Medikit", 1]]
        };
        [["FirstAidKit", 10], ["Medikit", 1]]
    };
};

AS_fnc_FIAUniformMedic = {
    call {
        if (hayACE) exitWith {
            if (ace_medical_level == 1) then {
                [["ACE_fieldDressing", 8], ["ACE_morphine", 4], ["ACE_epinephrine", 4], ["ACE_bloodIV_250", 2]]
            };
            // todo: add ACE lvl 2
            [["FirstAidKit", 3]]
        };
        [["FirstAidKit", 3]]
    };
};

AS_fnc_CrateMeds = {
	call {
        if (hayACE) exitWith {
            if (ace_medical_level == 1) then {
                [["ACE_fieldDressing", 30], ["ACE_morphine", 25], ["ACE_epinephrine", 20], ["ACE_bloodIV", 10]]
            };
            [["FirstAidKit", 10], ["Medikit", 1]]
        };
        // todo: add ACE lvl 2
        [["FirstAidKit", 10], ["Medikit", 1]]
	};
};
