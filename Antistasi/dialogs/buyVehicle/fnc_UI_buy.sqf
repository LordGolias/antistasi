// action button to buy the vehicle
disableSerialization;
private _class = lbData [0, lbCurSel 0];

if (_class != "") then {
    [_class] call AS_fnc_buyFIAvehicle;
} else {
    hint "No vehicle selected";
};
