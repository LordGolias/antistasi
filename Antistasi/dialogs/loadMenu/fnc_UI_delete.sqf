disableSerialization;

private _id = lbCurSel 0;

// Exit if no save selected
if (_id == -1) exitWith {
    hint "No save selected.";
};

private _saveName = lbData [0, _id];
[_saveName] spawn {
    params ["_saveName"];
    private _result = [format ["Delete save '%1'", _saveName], "", true, true] call BIS_fnc_guiMessage;
    if _result then {
        AS_database_waiting = true;
        [_saveName] remoteExec ["AS_database_fnc_deleteGame", 2];
        waitUntil {isNil "AS_database_waiting"};
        [] call AS_fnc_UI_loadMenu_update;
    };
};
