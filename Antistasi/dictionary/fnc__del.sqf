// deletes a key or a dictionary. Use multiple keys for nested operation (deletes last)
#include "macros.hpp"
params ["_arguments", "_isGlobal"];

if not ISARRAY(_arguments) then {
    _arguments = [_arguments];
};

if (count _arguments == 0) exitWith {
    diag_log format ["DICT:del(%1):ERROR: requires 1 argument", _arguments];
};
private _dictionary = _arguments select 0;

if (count _arguments > 1) then {
    private _key = _arguments select (count _arguments - 1);  // last is the last key

    for "_i" from 1 to (count _arguments - 2) do {
        _dictionary = [_dictionary, _arguments select _i] call EFUNC(_get);
        if isNil "_dictionary" exitWith {}; // the error was already emited by `get`, just quit
    };
    if isNil "_dictionary" exitWith {
        diag_log format ["DICT:del(%1):ERROR: key does not exist", _arguments];
    };
    if ISOBJECT(_key) then {
        // Recursively delete nested dictionaries
        [_key, _isGlobal] call EFUNC(_del);
    };
    _dictionary setVariable [toLower _key, nil, _isGlobal];
} else {
    {
        private _value = _dictionary getVariable _x;
        if ISOBJECT(_value) then {
            // because the dictionary is going to be deleted anyway, we only
            // need to delete the nested dictionaries
            [_value, _isGlobal] call EFUNC(_del);
        };
    } forEach (_dictionary call EFUNC(keys));
    deleteVehicle _dictionary;
};
