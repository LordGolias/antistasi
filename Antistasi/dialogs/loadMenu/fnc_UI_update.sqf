#include "../../macros.hpp"

disableSerialization;
private _cbo = ((findDisplay 1601) displayCtrl (0));
lbCLear _cbo;

private _availableSaves = AS_S("availableSaves");
{
    _cbo lbAdd(_x);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach _availableSaves;
_cbo lbSetCurSel 0;
