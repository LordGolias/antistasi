disableSerialization;
private _id = lbCurSel 0;
if (_id != -1) then {
    private _saveName = lbData [0, _id];
    hint format ["Loading save %1...", _saveName];
    [_saveName] remoteExec ["AS_database_fnc_loadGame", 2];
    closeDialog 0;
};
