#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_loadGame");
params ["_saveGame"];

private _admin = call AS_database_fnc_getAdmin;
if (_admin == -1) exitWith {};

private _data = _saveGame call AS_database_fnc_getData;
if (_data == "") exitWith {
    [format ["Canceled: save game '%s' does not exist", _saveGame]] remoteExecCall ["hint", _admin];
};

_data call AS_database_fnc_deserialize;
["Game loaded"] remoteExecCall ["hint", 2];
