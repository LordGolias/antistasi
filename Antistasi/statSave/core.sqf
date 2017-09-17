/*
Contains the core functionality of load/save multiple saves.
*/
#include "../macros.hpp"

AS_saveLoad_fnc_setData = {
    params ["_saveName", "_data"];
    profileNameSpace setVariable ["AS_v1_" + _saveName, _data];
};

AS_saveLoad_fnc_getData = {
    params ["_saveName"];
    profileNameSpace getVariable ["AS_v1_" + _saveName, ""]
};

AS_fnc_receiveSavedData = {
    if not hasInterface exitWith {};
    params ["_saveName", "_data"];

    copyToClipboard _data;
    if (player == AS_commander) then {
        private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
        _savedGames pushBackUnique _saveName;
        profileNameSpace setVariable ["AS_savedGames", _savedGames];
        [_saveName, _data] call AS_saveLoad_fnc_setData;
        saveProfileNamespace;
        hint "Game saved. It was saved in your profile and is in your clipboard so you can save it in a file :D";
        AS_waitingSavedGame = nil;
    } else {
        hint "Game saved by the commander. It was copied to your clipboard so you can save it in a file :D";
    };
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

AS_fnc_saveGame = {
    AS_SERVER_ONLY("AS_fnc_saveGame");
    params ["_saveGame"];

    if (!isNil "AS_savingServer") exitWith {
        ["Canceled: save already in process."] remoteExecCall ["hint",AS_commander];
        diag_log "[AS] Server: saving already in progress...";
    };
    AS_savingServer = true;
    ["Saving game..."] remoteExecCall ["hint",AS_commander];
    diag_log "[AS] Server: saving game...";
    private _data = call AS_fnc_serializeServer;
    diag_log "[AS] Server: game saved.";
    AS_savingServer = nil;

    [_saveGame, _data] remoteExecCall ["AS_fnc_receiveSavedData", 0];
};

AS_fnc_loadGame = {
    AS_SERVER_ONLY("AS_fnc_loadGame");
    params ["_data"];
    _data call AS_fnc_deserializeServer;
    ["Game loaded"] remoteExecCall ["hint", 2];
};
