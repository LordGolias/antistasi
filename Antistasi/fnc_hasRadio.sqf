params ["_unit"];
"ItemRadio" in assignedItems _unit or {
    hasTFAR and {count ((_unit call TFAR_fnc_radiosList) + (_unit call TFAR_fnc_backpackLR)) > 0}
}
