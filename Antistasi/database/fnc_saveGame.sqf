/*
 * Saves the game to the database.
 *
 * Arguments:
 * 0: Save name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["mySave"] call AS_database_fnc_saveGame;
 *
 */
#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_saveGame");
params ["_name"];

// Abort if a save/load is already in progress
if AS_saveInProgress exitWith {
    ["Canceled: save/load already in process."] remoteExecCall ["hint", AS_commander];
    diag_log "[AS] Server: save cancelled; save/load already in progress.";
};
AS_saveInProgress = true;

["Saving game..."] remoteExecCall ["hint", AS_commander];
diag_log "[AS] Server: saving game...";

[_name] spawn {
    params ["_name"];

    private _data = call AS_database_fnc_serialize;
    [_name, _data] call AS_database_fnc_setData;
    diag_log format ["[AS] Server: game saved as %1.", _name];
    "Game saved." remoteExecCall ["hint", AS_commander];
    remoteExecCall ["AS_fnc_UI_loadMenu_update", AS_commander];
    AS_saveInProgress = false;
};
