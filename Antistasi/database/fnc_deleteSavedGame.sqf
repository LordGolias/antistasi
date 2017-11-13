params ["_saveName"];
private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
private _index = _savedGames find _saveName;
if (_index != -1) exitWith {
    profileNameSpace setVariable ["AS_v1_" + _saveName, nil];
    _savedGames deleteAt _index;
    profileNameSpace setVariable ["AS_savedGames", _savedGames];
    true
};
false
