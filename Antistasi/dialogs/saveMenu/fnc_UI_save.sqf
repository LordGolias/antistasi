disableSerialization;

private _saveName = ctrlText (((findDisplay 1601) displayCtrl (2)));

// Exit if save name is empty
if (_saveName == "") exitWith {
    hint "Save cancelled; save name cannot be empty.";
};

if (_saveName in AS_database_savedGames) then {
    // saved game exists: confirm overwrite.
    [_saveName] spawn {
        params ["_saveName"];
        private _result = [format ["Overwrite saved game '%1'?", _saveName], "", true, true] call BIS_fnc_guiMessage;
        if _result then {
            AS_database_waiting = true;
            [_saveName] remoteExec ["AS_database_fnc_saveGame", 2];
            waitUntil {isNil "AS_database_waiting"};
            [] call AS_fnc_UI_loadMenu_update;
        };
    };
} else {
    // new saved game: save it.
    AS_database_waiting = true;
    [_saveName] remoteExec ["AS_database_fnc_saveGame", 2];
    waitUntil {isNil "AS_database_waiting"};
    [] call AS_fnc_UI_loadMenu_update;
};
