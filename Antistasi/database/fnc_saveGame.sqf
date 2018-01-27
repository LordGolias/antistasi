#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_saveGame");
params ["_saveGame"];

private _admin = call AS_database_fnc_getAdmin;

// Exit if the remoteExecutedOwner isn't an admin
if (isRemoteExecuted && (remoteExecutedOwner != _admin) ) exitWith {
    diag_log "[AS] Server: saveGame cancelled; remotely executed by non-admin";
};

// check if there is a saving already in progress
private _message = "Cannot save game: save is already in process.";
if (not isNil "AS_savingServer") exitWith {
    diag_log ("[AS] Server: " + _message);
    if (_admin != -1) then {
        [_message] remoteExecCall ["hint", _admin];
        // inform admin that server finished
        AS_database_waiting = nil;
        _admin publicVariableClient "AS_database_waiting";
    };
};
// lock double saving a game
AS_savingServer = true;

// inform
_message = "Saving game...";
diag_log ("[AS] Server: " + _message);
if (_admin != -1) then {
    [_message] remoteExecCall ["hint", _admin];
};

// serialize current state into a string
private _data = call AS_database_fnc_serialize;

// save string to the server's profile
private _savedGames = call AS_database_fnc_getGames;
_savedGames pushBackUnique _saveGame;
profileNameSpace setVariable ["AS_savedGames", _savedGames];
[_saveGame, _data] call AS_database_fnc_setData;
saveProfileNamespace;

// publish the new list of saved games globally
AS_database_savedGames = _savedGames;
publicVariable "AS_database_savedGames";

// inform
_message = format ["Game saved as '%1'.", _saveGame];
diag_log ("[AS] Server: " + _message);
if (_admin != -1) then {
    [_message] remoteExecCall ["hint", _admin];

    AS_database_waiting = nil;
    _admin publicVariableClient "AS_database_waiting";
};

// unlock saving
AS_savingServer = nil;
