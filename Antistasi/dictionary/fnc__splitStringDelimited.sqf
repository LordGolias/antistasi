// a splitString that accepts a delimiter with more than one char and
// ignores delimiters within starters and enders
#include "macros.hpp"

params ["_string", "_delimiter", "_starter", "_ender"];
if (_string find _delimiter == -1) exitWith {
    [_string]
};
private _bits = [_string, _delimiter] call EFUNC(_splitString);
private _level = 0;
private _result = [];
{
    if (_level == 0) then {
        _result pushBack _x;
    } else {
        private _last = count _result - 1;
        _result set [_last, (_result select _last) + _delimiter + _x];
    };
    _level = _level + count ([_x, _starter] call EFUNC(_splitString)) - count ([_x, _ender] call EFUNC(_splitString));
} forEach _bits;
_result
