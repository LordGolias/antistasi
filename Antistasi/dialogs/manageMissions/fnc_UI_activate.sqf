disableSerialization;
private _mission = lbData [0, lbCurSel 0];

if (_mission != "") then {
    [_mission] remoteExec ["AS_mission_fnc_activate", 2];
} else {
    hint "No mission selected";
};
