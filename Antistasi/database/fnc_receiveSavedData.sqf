if not hasInterface exitWith {};
params ["_saveName", "_data"];

copyToClipboard _data;
if (player == AS_commander) then {
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    _savedGames pushBackUnique _saveName;
    profileNameSpace setVariable ["AS_savedGames", _savedGames];
    [_saveName, _data] call AS_database_fnc_setData;
    saveProfileNamespace;
    hint "Game saved. It was saved in your profile and is in your clipboard so you can save it in a file :D";
    AS_waitingSavedGame = nil;
} else {
    hint "Game saved by the commander. It was copied to your clipboard so you can save it in a file :D";
};
