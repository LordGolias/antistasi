// Serializes the dictionary
#include "macros.hpp"
params ["_dictionary", ["_ignore_keys", []]];

// _complete_key stores the complete key of the element being serialized
// used to ignore elements

private _serialize_single = {
    params ["_key", "_value", "_complete_key"];
    _complete_key = _complete_key + [_key];
    private _result = "";
    if (_complete_key in _ignore_keys) exitWith {
        _result
    };
    call {
        if ISOBJECT(_value) exitWith {
            private _strings = [];
            {
                private _x_value = _value getVariable _x;
                if (not isNil "_x_value") then {
                    private _string = ([_x, _x_value, _complete_key] call _serialize_single);
                    if (_string != "") then {
                        _strings pushBack _string;
                    };
                };
            } forEach allVariables _value;
            _result = OB_START + (_strings joinString SEPARATOR) + OB_END;
        };
        if ISARRAY(_value) exitWith {
            private _strings = [];
            {
                private _string = ([str _forEachIndex, _x, _complete_key] call _serialize_single);
                if (_string != "") then {
                    _strings pushBack _string;
                };
            } forEach _value;
            _result = AR_START + (_strings joinString ",") + AR_END;
        };
        if (typeName _value in ["BOOL", "STRING", "SCALAR", "TEXT"]) exitWith {
            _result = str _value;
        };
        diag_log format ["DICT:serialize(%1):ERROR: value can only be of types %2 (is ""%3"")",
            _complete_key,
            ["OBJECT", "ARRAY", "BOOL", "STRING", "SCALAR", "TEXT"],
            typeName _value];
    };
    [_key, TYPE_TO_STRING(typeName _value), _result] joinString ":"
};

private _strings = [];
{
    private _x_value = _dictionary getVariable _x;
    if (not isNil "_x_value") then {
        private _string = ([_x, _x_value, []] call _serialize_single);
        if (_string != "") then {
            _strings pushBack _string;
        };
    };
} forEach allVariables _dictionary;

OB_START + (_strings joinString SEPARATOR) + OB_END
