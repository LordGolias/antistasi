#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_saveGame");
params ["_saveGame"];

if (!isNil "AS_savingServer") exitWith {
    ["Canceled: save already in process."] remoteExecCall ["hint",AS_commander];
    diag_log "[AS] Server: saving already in progress...";
};
AS_savingServer = true;
["Saving game..."] remoteExecCall ["hint",AS_commander];
diag_log "[AS] Server: saving game...";
private _data = call AS_database_fnc_serialize;
diag_log "[AS] Server: game saved.";
AS_savingServer = nil;

[_saveGame, _data] remoteExecCall ["AS_database_fnc_receiveSavedData", 0];
