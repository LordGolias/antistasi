if ((count weaponCargo caja > 0) or
    (count magazineCargo caja > 0) or
    (count itemCargo caja > 0) or
    (count backpackCargo caja > 0)) exitWith {
        hint "The Ammobox must be empty to move the HQ";
};

[] remoteExec ["AS_fnc_HQmove", 2];
closeDialog 0;
