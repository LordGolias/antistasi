disableSerialization;
private _cbo = ((findDisplay 1601) displayCtrl (0));
lbCLear _cbo;

private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
{
    _cbo lbAdd(_x);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach _savedGames;
_cbo lbSetCurSel 0;
