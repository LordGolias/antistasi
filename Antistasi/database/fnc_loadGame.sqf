/*
 * Loads the game from the database.
 *
 * Arguments:
 * 0: Save name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["mySave"] call AS_database_fnc_loadGame;
 *
 */
#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_loadGame");
params ["_name"];

if AS_saveInProgress exitWith {
    ["Canceled: save/load already in process."] remoteExecCall ["hint", AS_commander];
    diag_log "[AS] Server: load cancelled; save/load already in progress.";
};
AS_saveInProgress = true;

[_name] spawn {
    params ["_name"];

    private _data = _name call AS_database_fnc_getData;
    if (isNil "_data") then {
        (format ["Canceled: save %1 not found.", _name]) remoteExecCall ["hint", AS_commander];
        diag_log format ["[AS] Server: load cancelled; save %1 not found.", _name];
    };

    _data call AS_database_fnc_deserialize;
    diag_log format ["[AS] Server: save %1 loaded.", _name];
    AS_saveInProgress = false;
    (format ["Save %1 loaded.", _name]) remoteExecCall ["hint", AS_commander];
};
