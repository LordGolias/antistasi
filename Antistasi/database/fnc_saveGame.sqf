#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_saveGame");
params ["_saveGame"];

// check for the existence of an admin, deny saving if there is no logged in admin
private _admin = call AS_database_fnc_getAdmin;
if (_admin == -1) exitWith {
    // inform admin that server finished
    AS_database_waiting = nil;
    _admin publicVariableClient "AS_database_waiting";
};

if (!isNil "AS_savingServer") exitWith {
    ["Canceled: save already in process."] remoteExecCall ["hint", _admin];

    // inform admin that server finished
    AS_database_waiting = nil;
    _admin publicVariableClient "AS_database_waiting";
};
AS_savingServer = true;
["Saving game..."] remoteExecCall ["hint", _admin];
diag_log "[AS] Server: saving game...";
private _data = call AS_database_fnc_serialize;
diag_log "[AS] Server: game saved.";
AS_savingServer = nil;

// save game to the server's profile
private _savedGames = call AS_database_fnc_getGames;
_savedGames pushBackUnique _saveGame;
profileNameSpace setVariable ["AS_savedGames", _savedGames];
[_saveGame, _data] call AS_database_fnc_setData;
saveProfileNamespace;

// publish the new list of saved games globally
AS_database_savedGames = _savedGames;
publicVariable "AS_database_savedGames";

// inform admin of saved game
["Game saved on the server's profile"] remoteExecCall ["hint", _admin];

// inform admin that server finished
AS_database_waiting = nil;
_admin publicVariableClient "AS_database_waiting";
