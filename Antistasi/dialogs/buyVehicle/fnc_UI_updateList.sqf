// updates the left list and right text field
disableSerialization;
private _cbo = ((findDisplay 1602) displayCtrl 0);
lbCLear _cbo;

{
    _cbo lbAdd (getText(configFile >> "cfgVehicles" >> _x >> "displayName"));
    private _picture = (getText(configFile >> "cfgVehicles" >> _x >> "picture"));
    _cbo lbSetPicture[(lbSize _cbo)-1, _picture];

    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach (AS_FIArecruitment_all - (AS_FIArecruitment getVariable "water_vehicles"));

_cbo lbSetCurSel 0;
call AS_fnc_UI_buyVehicle_updateVehicleData;
