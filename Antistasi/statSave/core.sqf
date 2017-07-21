/*
    Contains the core functionality of load/save multiple saves.
*/
// when a player arrives to the server (JIP), it does not know what save to load from.
// When the server was already loaded, this variable points to the save that the player receives.
// "" is an invalid name for a regular save.
AS_currentSave = "";

AS_fnc_variableName = {
    params ["_saveName", "_name"];
    "AS_v1_" + _saveName + _name
};

AS_fnc_saveGame = {
    params ["_saveName"];
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];

    // if the game already exists, first delete it.
    // todo: ask before delete.
    if (_savedGames find _saveName != -1) then {
        [_saveName] call AS_fnc_deleteSavedGame;
        _savedGames = profileNameSpace getVariable ["AS_savedGames", []];  // update variable after delete.
    };
    _savedGames pushBack _saveName;
    private _savedVariables = profileNameSpace getVariable ["AS_savedVariables", []];
    _savedVariables pushBack [];
    profileNameSpace setVariable ["AS_savedVariables", _savedVariables];
    profileNameSpace setVariable ["AS_savedGames", _savedGames];

   [_saveName] call AS_fnc_saveServer;
   AS_currentSave = _saveName;
};

AS_fnc_deleteSavedGame = {
    params ["_saveName"];
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    private _index = _savedGames find _saveName;
    if (_index != -1) exitWith {
        private _savedVariables = profileNameSpace getVariable ["AS_savedVariables", []];
        private _allVariables = _savedVariables select _index;
        {profileNameSpace setVariable [[_saveName, _x] call AS_fnc_variableName, nil]} forEach _allVariables;  // erase all variables from this save.
        _savedVariables deleteAt _index;
        _savedGames deleteAt _index;
        profileNameSpace setVariable ["AS_savedVariables", _savedVariables];
        profileNameSpace setVariable ["AS_savedGames", _savedGames];
        true
    };
    false
};

AS_fnc_loadGame = {
    params ["_saveName"];
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    private _index = _savedGames find _saveName;
    if (_index != -1) exitWith {
        AS_currentSave = _saveName;
        [_saveName] call AS_fnc_loadServer;
        true
    };
    false
};

AS_fnc_SaveStat = {
	params ["_saveName", "_varName", "_varValue"];
	if (!isNil "_varValue") then {
        // save the variable in the list of variables.
        private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
        private _savedVariables = profileNameSpace getVariable ["AS_savedVariables", []];
        private _index = _savedGames find _saveName;
        (_savedVariables select _index) pushBack _varName;
        profileNameSpace setVariable ["AS_savedVariables", _savedVariables];
        // and its value
		profileNameSpace setVariable [[_saveName, _varName] call AS_fnc_variableName, _varValue];
	};
};

AS_fnc_LoadStat = {
    params ["_saveName", "_varName"];
    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    private _savedVariables = profileNameSpace getVariable ["AS_savedVariables", []];
    private _index = _savedGames find _saveName;
    if (_varName in (_savedVariables select _index)) exitWith {
        profileNameSpace getVariable ([_saveName, _varName] call AS_fnc_variableName)
    };
	objNull
};
