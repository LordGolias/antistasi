// deletes a key from the dictionary. Use multiple keys for nested operation (deletes last)
#include "macros.hpp"

if (count _this < 2) exitWith {
    diag_log format ["DICT:del(%1):ERROR: requires 2 arguments", _this];
};
private _dictionary = _this select 0;
private _key = _this select (count _this - 1);  // last is the last key

for "_i" from 1 to (count _this - 2) do {
    _dictionary = [_dictionary, _this select _i] call EFUNC(get);
    if isNil "_dictionary" exitWith {}; // the error was already emited by `get`, just quit
};
if ISOBJECT(_key) then {
    _key call EFUNC(delete);
};
_dictionary setVariable [toLower _key, nil, true];
