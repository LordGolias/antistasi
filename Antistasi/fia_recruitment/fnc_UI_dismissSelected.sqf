if (count groupselectedUnits player > 0) exitWith {
    [groupselectedUnits player] call AS_fnc_dismissFIAunits;
};
if (count hcSelected player > 0) exitWith {
    [hcSelected player] call AS_fnc_dismissFIAsquads;
};
hint "No units or squads selected";
