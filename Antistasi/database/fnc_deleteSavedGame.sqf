/*
 * Deletes a save.
 *
 * Arguments:
 * 0: Save name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["mySave"] call AS_database_fnc_deleteSavedGame;
 *
 */
#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_deleteSavedGame");
params ["_name"];

private _savedGames = profileNameSpace getVariable ["AS_v2_SAVES", []];
private _deleted = false;
{
    params ["_saveName"];

    if (_saveName == _name) exitWith {
        // Delete save game from database
        _savedGames deleteAt _forEachIndex;
        profileNamespace setVariable ["AS_v2_SAVES", _savedGames];

        // Update list of available save names
        private _availableSaves = AS_S("availableSaves");
        _availableSaves = _availableSaves - [_name];
        AS_Sset("availableSaves", _availableSaves);

        diag_log format ["[AS] Server: save %1 deleted.", _name];
        (format ["Save %1 deleted.", _name]) remoteExecCall ["hint", AS_commander];
        remoteExecCall ["AS_fnc_UI_loadMenu_update", AS_commander];

        _deleted = true;
    };
} forEach _savedGames;

if (!_deleted) then {
    (format ["Canceled: save %1 not found.", _name]) remoteExecCall ["hint", AS_commander];
    diag_log format ["[AS] Server: delete cancelled; save %1 not found.", _name];
};
