disableSerialization;
private _name = lbData [3, lbCurSel 3];
private _location = ctrlText ((findDisplay 1602) displayCtrl 2);

if (_name != "" and (_location call AS_location_fnc_side == "FIA")) then {
    [_name, _location] call AS_fnc_dismissFIAgarrison;
    call AS_fnc_UI_manageGarrisons_updateList;
} else {
    hint "no unit selected or invalid location";
};
