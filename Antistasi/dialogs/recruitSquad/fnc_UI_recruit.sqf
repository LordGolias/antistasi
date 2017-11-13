disableSerialization;
private _id = lbCurSel 0;
private _squadName = lbData [0, _id];

if (_squadName != "") then {
    [_squadName] spawn AS_fnc_recruitFIAsquad;
} else {
    hint "no squad selected";
};
