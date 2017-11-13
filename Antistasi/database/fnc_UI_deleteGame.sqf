disableSerialization;
private _id = lbCurSel 0;
if (_id != -1) then {
    private _saveName = lbData [0, _id];
    [_saveName] call AS_database_fnc_deleteSavedGame;
    [] call AS_database_fnc_UI_updateSaveGameList;
    hint format ['"%1" deleted', _saveName];
} else {
    hint "no save selected";
};
