disableSerialization;
private _id = lbCurSel 0;
if (_id != -1) then {
    private _saveName = lbData [0, _id];
    private _data = _saveName call AS_database_fnc_getData;
    hint "wait for the server to load the game...";
    [_data] remoteExec ["AS_database_fnc_loadGame", 2];
    closeDialog 0;
} else {
    hint "no save selected";
};
