disableSerialization;

// Fill recruiting list
private _cbo = ((findDisplay 1602) displayCtrl 1);
lbCLear _cbo;
{
    _cbo lbAdd(format ["%1 (%2€)", _x, AS_data_allCosts getVariable _x]);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach AS_allFIARecruitableSoldiers;
_cbo lbSetCurSel 0;

// Fill dismiss list
private _location = ctrlText ((findDisplay 1602) displayCtrl 2);
private _garrison = [_location, "garrison"] call AS_location_fnc_get;

_cbo = ((findDisplay 1602) displayCtrl 3);
lbCLear _cbo;
{
    private _unit = _x;
    _cbo lbAdd(format ["%1 (%2)", _unit, {_unit == _x} count _garrison]);
    _cbo lbSetData[(lbSize _cbo)-1, _unit];
} forEach (_garrison arrayIntersect _garrison);
_cbo lbSetCurSel 0;
