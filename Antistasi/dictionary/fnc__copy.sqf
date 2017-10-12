// a deep copy of the dictionary
// this copy is such that deleting a copy does not alter the original
#include "macros.hpp"
params ["_dictionary", "_ignore_keys", "_global"];

private _serialize_single = {
    params ["_key", "_value", "_complete_key", "_copy"];
    _complete_key = _complete_key + [_key];
    if (_complete_key in _ignore_keys) exitWith {};
    if ISOBJECT(_value) then {
        [[_copy, _key, call EFUNC(create)], _global] call EFUNC(_set);
        {
            private _x_value = _value getVariable _x;
            if (not isNil "_x_value") then {
                [_x, _x_value, _complete_key, [_copy, _key] call EFUNC(get)] call _serialize_single;
            };
        } forEach allVariables _value;
    } else {
        [[_copy, _key, _value], _global] call EFUNC(_set);
    };
};

private _copy = call EFUNC(create);

{
    private _x_value = _dictionary getVariable _x;
    if (not isNil "_x_value") then {
        [_x, _x_value, [], _copy] call _serialize_single;
    };
} forEach allVariables _dictionary;
_copy
