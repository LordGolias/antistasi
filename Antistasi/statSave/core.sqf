/*
Contains the core functionality of load/save multiple saves.
*/
AS_saveLoad_fnc_setData = {
    params ["_saveName", "_data"];
    profileNameSpace setVariable ["AS_v1_" + _saveName, _data];
};

AS_saveLoad_fnc_getData = {
    params ["_saveName"];
    profileNameSpace getVariable ["AS_v1_" + _saveName, ""]
};

AS_fnc_saveGame = {
    params ["_saveName"];

    if (!isNil "AS_savingServer") exitWith {
        ["Canceled: save already in process."] remoteExecCall ["hint",AS_commander];
        diag_log "[AS] Server: saving already in progress...";
    };
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];

    // if the game already exists, first delete it.
    // todo: ask before delete.
    if (_savedGames find _saveName != -1) then {
        [_saveName] call AS_fnc_deleteSavedGame;
        _savedGames = profileNameSpace getVariable ["AS_savedGames", []];  // update variable after delete.
    };
    AS_currentSave = _saveName;
    _savedGames pushBack _saveName;
    profileNameSpace setVariable ["AS_savedGames", _savedGames];

    AS_savingServer = true;
    ["Saving game..."] remoteExecCall ["hint",AS_commander];
    diag_log "[AS] Server: saving game...";

    private _string = call AS_fnc_serializeServer;
    [_saveName, _string] call AS_saveLoad_fnc_setData;
    [_string] remoteExecCall ["copyToClipboard", AS_commander];
    saveProfileNamespace;

    diag_log "[AS] Server: game saved.";
    ["Game saved. It was also copied to your clipboard so you can save it into a file :D"] remoteExecCall ["hint", AS_commander];
    AS_savingServer = nil;
};

AS_fnc_deleteSavedGame = {
    params ["_saveName"];
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    private _index = _savedGames find _saveName;
    if (_index != -1) exitWith {
        profileNameSpace setVariable ["AS_v1_" + _saveName, nil];
        _savedGames deleteAt _index;
        profileNameSpace setVariable ["AS_savedGames", _savedGames];
        true
    };
    false
};

AS_fnc_loadGame = {
    params ["_saveName", ["_fromClipBoard", false]];
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    private _index = _savedGames find _saveName;
    if (_index != -1) exitWith {
        AS_currentSave = _saveName;

        private _string = "";
        if _fromClipBoard then {
            _string = copyFromClipboard;
        } else {
            _string = _saveName call AS_saveLoad_fnc_getData;
        };
        _string call AS_fnc_deserializeServer;

        private _message = [format ["Game '%1' loaded", _saveName], "Game loaded from clipboard"] select _fromClipBoard;
        diag_log format ["[AS] Server: %1", _message];
        [_message] remoteExecCall ["hint", AS_commander];
        true
    };
    false
};
