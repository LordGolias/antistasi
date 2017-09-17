disableSerialization;
private _id = lbCurSel 0;
private _unitName = lbData [0, _id];

if (_unitName != "") then {
    [_unitName] call AS_fnc_recruitFIAunit;
} else {
    hint "no unit selected";
};
