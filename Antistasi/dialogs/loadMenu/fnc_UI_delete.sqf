disableSerialization;
private _id = lbCurSel 0;
if (_id != -1) then {
    private _saveName = lbData [0, _id];
    [_saveName] spawn {
        params ["_saveName"];
        private _result = [format ["Delete game %1?", _saveName], "", true, true] call BIS_fnc_guiMessage;
        if _result then {
            [_saveName] remoteExec ["AS_database_fnc_deleteSavedGame", 2];
        };
    };
};
