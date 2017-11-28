#include "../../macros.hpp"

disableSerialization;
private _saveName = ctrlText (((findDisplay 1601) displayCtrl (2)));

if (_saveName != "") then {
    private _savedGames = AS_S("availableSaves");
    if (_saveName in _savedGames) then {
        // saved game exists: confirm overwrite.
        [_saveName] spawn {
            params ["_saveName"];
            private _result = [format ["Overwrite saved game '%1'?", _saveName], "", true, true] call BIS_fnc_guiMessage;
            if _result then {
                AS_waitingSavedGame = true;
                [_saveName] remoteExec ["AS_database_fnc_saveGame", 2];
            };
        };
    } else {
        // new saved game: save it.
        [_saveName] remoteExec ["AS_database_fnc_saveGame", 2];
    };
};
