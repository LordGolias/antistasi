disableSerialization;
private _cbo = ((findDisplay 1602) displayCtrl (0));
lbCLear _cbo;

{
    _cbo lbAdd (_x call AS_fnc_getFIASquadName);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach (["FIA", "squads"] call AS_fnc_getEntity);
_cbo lbSetCurSel 0;
