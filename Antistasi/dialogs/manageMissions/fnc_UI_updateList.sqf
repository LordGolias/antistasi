disableSerialization;
private _cbo = ((findDisplay 1602) displayCtrl 0);
lbCLear _cbo;

{
    _cbo lbAdd (_x call AS_mission_fnc_name);
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach (call AS_mission_fnc_available_missions);

_cbo lbSetCurSel 0;
call AS_fnc_UI_manageMissions_updatePanel;
