#include "macros.hpp"

private _dictionary = _this select 0;
private _key = _this select (count _this - 1);  // last is the last key
if (count _this == 2) exitWith {
    private _key = _this select 1;
    _dictionary getVariable (toLower _key)  // may be nil
};

for "_i" from 1 to (count _this - 2) do {
    _dictionary = [_dictionary, _this select _i] call EFUNC(_get);
    if isNil "_dictionary" exitWith {};
};
if isNil "_dictionary" exitWith {};
if not ISOBJECT(_dictionary) exitWith {
    diag_log format ["DICT:get(%1):ERROR: first argument must be an object", _dictionary];
};
_dictionary getVariable (toLower _key)
