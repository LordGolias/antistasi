disableSerialization;
private _saveName = ctrlText (((findDisplay 1601) displayCtrl (2)));

if (_saveName != "") then {
    AS_waitingSavedGame = true;
    [_saveName] remoteExec ["AS_database_fnc_saveGame", 2];
    waitUntil {isNil "AS_waitingSavedGame"};
    [] call AS_database_fnc_UI_updateSaveGameList;
} else {
    hint "no save selected";
};
