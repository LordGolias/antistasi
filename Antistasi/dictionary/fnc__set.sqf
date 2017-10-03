// Sets the value of the key of the dictionary. Use multiple keys for nested operation.
#include "macros.hpp"
params ["_arguments", "_isGlobal"];

if (count _arguments < 3) exitWith {
    diag_log format ["DICT:set(%1):ERROR: requires 3 arguments", _arguments];
};

private _dictionary = _arguments select 0;
private _key = _arguments select (count _arguments - 2);
private _value = _arguments select (count _arguments - 1);

for "_i" from 1 to (count _arguments - 3) do {
    _dictionary = [_dictionary, _arguments select _i] call EFUNC(get);
    if isNil "_dictionary" exitWith {}; // the error was already emited by `get`, just quit
};
if not ISOBJECT(_dictionary) exitWith {
    diag_log format ["DICT:set(%1):ERROR: not an object.", _arguments];
};
_dictionary setVariable [toLower _key, _value, _isGlobal];
