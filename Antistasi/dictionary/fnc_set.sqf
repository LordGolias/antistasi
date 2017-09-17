// Sets the value of the key of the dictionary. Use multiple keys for nested operation.
#include "macros.hpp"

if (count _this < 3) exitWith {
    diag_log format ["DICT:set(%1):ERROR: requires 3 arguments", _this];
};

private _dictionary = _this select 0;
private _key = _this select (count _this - 2);
private _value = _this select (count _this - 1);

if not (typeName _value in ["OBJECT", "ARRAY", "BOOL", "STRING", "SCALAR", "TEXT"]) exitWith {
    diag_log format ["DICT:set(%1):ERROR: value type (%3) can only be of types %2", _this, ["OBJECT", "ARRAY", "BOOL", "STRING", "SCALAR", "TEXT"], typeName _value];
};

for "_i" from 1 to (count _this - 3) do {
    _dictionary = [_dictionary, _this select _i] call EFUNC(get);
    if isNil "_dictionary" exitWith {}; // the error was already emited by `get`, just quit
};
if not ISOBJECT(_dictionary) exitWith {
    diag_log format ["DICT:set(%1):ERROR: not an object.", _this];
};
_dictionary setVariable [toLower _key, _value, true];
