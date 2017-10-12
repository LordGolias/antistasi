// splits string with a given delimiter (can be more than 1 char)
params ["_string", "_delimiter"];
private _index = _string find _delimiter;
if (_index == -1) exitWith {
    [_string]
};
private _result = [_string select [0, _index]];
while {_index != -1} do {
    _string = _string select [_index + count _delimiter];
    _index = _string find _delimiter;
    if (_index != -1) then {
        _result pushBack (_string select [0, _index]);
    } else {
        _result pushBack _string;
    };
};
_result
