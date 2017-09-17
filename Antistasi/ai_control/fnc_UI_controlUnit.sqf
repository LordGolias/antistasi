closeDialog 0;
if ((count groupselectedUnits player != 1) and (count hcSelected player != 1)) exitWith {
    hint "You must select either a squad from the HC or a unit from your squad";
};
if (count groupselectedUnits player == 1) then {
    [groupselectedUnits player select 0] spawn AS_fnc_controlUnit;
};
if (count hcSelected player == 1) then {
    [hcSelected player select 0] spawn AS_fnc_controlHCSquad;
};
