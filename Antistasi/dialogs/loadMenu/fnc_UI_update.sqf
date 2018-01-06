disableSerialization;
private _cbo = ((findDisplay 1601) displayCtrl (0));
lbCLear _cbo;

{
    _cbo lbAdd(_x);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach AS_database_savedGames;
_cbo lbSetCurSel 0;
