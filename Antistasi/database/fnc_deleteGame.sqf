#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_deleteGame");
params ["_saveGame"];

private _admin = call AS_database_fnc_getAdmin;

private _savedGames = call AS_database_fnc_getGames;
private _index = _savedGames find _saveGame;

private _message = format ['Saved game "%1" was not deleted because it does not exist', _saveGame];
if (_index != -1) then {
    _savedGames deleteAt _index;
    profileNameSpace setVariable ["AS_savedGames", _savedGames];
    profileNameSpace setVariable ["AS_v1_" + _saveGame, nil];
    _message = format ['[AS] Server: saved game "%1" deleted', _saveGame];

    // publish the new list of saved games globally
    AS_database_savedGames = _savedGames;
    publicVariable "AS_database_savedGames";
};

diag_log ("[AS] Server: " + _message);
if (_admin != -1) then {
    [_message] remoteExecCall ["hint", _admin];

    // inform admin that server finished
    AS_database_waiting = nil;
    _admin publicVariableClient "AS_database_waiting";
};
