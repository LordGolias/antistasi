#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_loadGame");
params ["_saveGame"];

private _admin = call AS_database_fnc_getAdmin;

private _message = format ["Game '%s' loaded", _saveGame];
private _data = _saveGame call AS_database_fnc_getData;
if (_data == "") then {
    _message = format ["Game '%s' not loaded because it does not exist", _saveGame];
} else {
    _data call AS_database_fnc_deserialize;
};

diag_log ("[AS] Server: " + _message);
if (_admin != -1) then {
    [_message] remoteExecCall ["hint", 2];
};
