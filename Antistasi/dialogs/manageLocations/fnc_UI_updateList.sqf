disableSerialization;

// Fill types list
private _cbo = ((findDisplay 1602) displayCtrl 0);
lbCLear _cbo;
{
    _cbo lbAdd(format ["%1", _x, AS_data_allCosts getVariable _x]);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach ["roadblock","watchpost","camp"];
_cbo lbSetCurSel 0;
