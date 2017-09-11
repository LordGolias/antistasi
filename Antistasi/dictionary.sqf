#define EFUNC(name) DICT_fnc_##name
#define ISOBJECT(_value) (typeName _value == "OBJECT")
#define ISARRAY(_value) (typeName _value == "ARRAY")

#define SEPARATOR ("<%" + (toString [13,10]) + "%>")

#define TYPE_TO_STRING(_typeName) (_typeName select [0,2])

// a splitstring that accepts a delimiter with more than one char
EFUNC(splitString) = {
    params ["_string", "_delimiter"];
    private _result = [];
    private _size = count _delimiter;
    while {count _string > 0} do {
        private _index = _string find _delimiter;
        if (_index == -1) exitWith {_result pushBack _string};
        _result pushBack (_string select [0, _index]);
        _string = _string select [_index + _size];
    };
    _result
};

// an internal class used below in two situations
EFUNC(_get) = {
    private _dictionary = _this select 0;
    private _key = _this select (count _this - 1);  // last is the last key
    if (count _this == 2) exitWith {
        private _key = _this select 1;
        private _value = _dictionary getVariable (toLower _key);
        _value  // may be nil
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
};

// Gets the value from key of the dictionary. Use multiple keys for nested operation
EFUNC(get) = {
    if (count _this < 2) exitWith {
        diag_log format ["DICT:get(%1):ERROR: requires 2 arguments", _this];
    };
    private _value = _this call EFUNC(_get);
    if isNil "_value" exitWith {
        diag_log format ["DICT:get(%1):ERROR: invalid key", _this];
    };
    _value
};

EFUNC(keys) = {
    (allVariables _this) select {private _x_value = _this getVariable _x; not isNil "_x_value"}
};

// Checks whether a key exists in the dictionary. Use multiple keys for nested operation
EFUNC(exists) = {
    if (count _this < 2) exitWith {
        diag_log format ["DICT:get(%1):ERROR: requires 2 arguments", _this];
    };
    private _value = _this call EFUNC(_get);
    not isNil "_value"
};

// Sets the value of the key of the dictionary. Use multiple keys for nested operation.
EFUNC(set) = {
    if (count _this < 3) exitWith {
        diag_log format ["DICT:set(%1):ERROR: requires 3 arguments", _this];
    };

    private _dictionary = _this select 0;
    private _key = _this select (count _this - 2);
    private _value = _this select (count _this - 1);

    if not (typeName _value in ["OBJECT", "ARRAY", "BOOL", "STRING", "SCALAR", "TEXT"]) exitWith {
        diag_log format ["DICT:set(%1):ERROR: value can only be of type %1 (is %2)", ["OBJECT", "ARRAY", "BOOL", "STRING", "SCALAR", "TEXT"], typeName _value];
    };

    for "_i" from 1 to (count _this - 3) do {
        _dictionary = [_dictionary, _this select _i] call EFUNC(get);
        if isNil "_dictionary" exitWith {}; // the error was already emited by `get`, just quit
    };
    if not ISOBJECT(_dictionary) exitWith {
        diag_log format ["DICT:set(%1):ERROR: not an object.", _this];
    };
    _dictionary setVariable [toLower _key, _value, true];
};

// deletes a key from the dictionary. Use multiple keys for nested operation (deletes last)
EFUNC(del) = {
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
};

// Creates a new dictionary.
EFUNC(create) = {
    createSimpleObject ["Static", [0, 0, 0]]
};

// recursively deletes a dictionary
EFUNC(delete) = {
    params ["_dictionary"];
    {
        private _value = _dictionary getVariable _x;
        if ISOBJECT(_value) then {
            _value call EFUNC(delete);
        };
    } forEach allVariables _dictionary;
    deleteVehicle _dictionary;
};

// a deep copy of the dictionary
// this copy is such that deleting a copy does not alter the original
EFUNC(copy) = {
    params ["_dictionary", ["_ignore_keys", []]];

    private _serialize_single = {
        params ["_key", "_value", "_complete_key", "_copy"];
        _complete_key = _complete_key + [_key];
        private _result = "";
        if (_complete_key in _ignore_keys) exitWith {};
        if ISOBJECT(_value) then {
            [_copy, _key] call EFUNC(add);
            {
                private _x_value = _value getVariable _x;
                if (not isNil "_x_value") then {
                    [_x, _x_value, _complete_key, [_copy, _key] call EFUNC(get)] call _serialize_single;
                };
            } forEach allVariables _value;
        } else {
            [_copy, _key, _value] call EFUNC(set);
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
};

// Creates a new level on the dictionary.
EFUNC(add) = {
    if (count _this < 2) exitWith {
        diag_log "DICT:add:ERROR: requires 2 arguments";
    };
    [_this select 0, _this select 1, call EFUNC(create)] call EFUNC(set);
};

// Serializes the dictionary
EFUNC(serialize) = {
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
                _result = "{" + (_strings joinString SEPARATOR) + "}";
            };
            if ISARRAY(_value) exitWith {
                private _strings = [];
                {
                    private _string = ([str _forEachIndex, _x, _complete_key] call _serialize_single);
                    if (_string != "") then {
                        _strings pushBack _string;
                    };
                } forEach _value;
                _result = "[" + (_strings joinString ",") + "]";
            };
            _result = str _value;
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

    "{" + (_strings joinString SEPARATOR) + "}"
};

EFUNC(deserialize) = {
    params ["_string"];

    private _deserialize_single = {
        params ["_type", "_value_string"];
        private _value = "";
        if (_type == "OB") then {
            _value = call EFUNC(create);
            _value_string = _value_string select [1, count _string - 2];
            {
                [_value, _x] call _deserialize;
            } forEach ([_value_string, SEPARATOR] call EFUNC(splitString));
        };
        if (_type == "AR") then {
            _value_string = _value_string select [1, count _value_string - 2];
            _value = [];
            {
                private _bits = _x splitString ":";
                _value pushBack ([_bits select 1, _bits select 2] call _deserialize_single);
            } forEach (_value_string splitString ",");
        };
        if (_type == "BO") then {
            _value = [True, False] select (_value_string == "false");
        };
        if (_type == "ST") then {
            _value = _value_string select [1, count _value_string - 2];
        };
        if (_type == "SC") then {
            _value = parseNumber _value_string;
        };
        if (_type == "TE") then {
            _value = text _value_string;
        };
        _value
    };

    private _deserialize = {
        params ["_dictionary", "_string"];
        private _bits = _string splitString ":";

        private _key = _bits select 0;

        if (count _bits == 2) then {
            [_dictionary, _key] call EFUNC(add);
            [_dictionary, _key, [_dictionary, _bits select 1] call _deserialize] call EFUNC(add);
        } else {
            private _final_bit = _bits select 2;
            for "_i" from 3 to (count _bits - 1) do {
                _final_bit = _final_bit + ":" + (_bits select _i);
            };

            private _value = [_bits select 1, _final_bit] call _deserialize_single;
            [_dictionary, _key, _value] call EFUNC(set);
        };
    };
    ["OBJECT", _string] call _deserialize_single
};

private _test_basic = {
    private _dict = call EFUNC(create);
    [_dict, "sub1", "b"] call EFUNC(set);
    [_dict, "sub2"] call EFUNC(add);
    [_dict, "sub2", "c", "d"] call EFUNC(set);

    private _b = [_dict, "sub1"] call EFUNC(get);
    private _d = [_dict, "sub2", "c"] call EFUNC(get);
    _d isEqualTo "d" and _b isEqualTo "b"
};

private _test_copy = {
    private _dict = call EFUNC(create);
    [_dict, "sub1", "b"] call EFUNC(set);
    [_dict, "sub2"] call EFUNC(add);
    [_dict, "sub2", "c", "d"] call EFUNC(set);

    private _copy = _dict call EFUNC(copy);
    private _b = [_copy, "sub1"] call EFUNC(get);
    private _d = [_copy, "sub2", "c"] call EFUNC(get);
    _d isEqualTo "d" and _b isEqualTo "b"
};

private _test_delete = {
    private _dict = call EFUNC(create);
    [_dict, "a"] call EFUNC(add);

    private _dict2 = [_dict, "a"] call EFUNC(get);

    _dict call EFUNC(delete);
    sleep 0.01; // wait one frame
    isNull _dict2 and isNull _dict
};

private _test_del = {
    private _dict = call EFUNC(create);
    [_dict, "a"] call EFUNC(add);
    [_dict, "a", "c", 1] call EFUNC(set);

    [_dict, "a", "c"] call EFUNC(del);
    private _subDict = [_dict, "a"] call EFUNC(get);
    (_subDict getVariable ["c", "null"]) isEqualTo "null"
};

private _test_serialize = {
    private _dict = call EFUNC(create);
    [_dict, "string", "b"] call EFUNC(set);
    [_dict, "number", 1] call EFUNC(set);
    [_dict, "bool", false] call EFUNC(set);
    [_dict, "text", text "b"] call EFUNC(set);
    [_dict, "array", [1,"b"]] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    _string isEqualTo format["{text:TE:b%1string:ST:""b""%1bool:BO:false%1number:SC:1%1array:AR:[0:SCALAR:1,1:ST:""b""]}", SEPARATOR]
};

private _test_serialize_del = {
    // do not serialize deleted (nil) values
    private _dict = call EFUNC(create);
    [_dict, "string", "b"] call EFUNC(set);
    [_dict, "string"] call EFUNC(del);

    private _string = _dict call EFUNC(serialize);
    _string isEqualTo "{}"
};

private _test_serialize_ignore = {
    // do not serialize deleted (nil) values
    private _dict = call EFUNC(create);
    [_dict, "a", "a"] call EFUNC(set);
    [_dict, "b", "b"] call EFUNC(set);

    private _string1 = _dict call EFUNC(serialize);
    private _result1 = _string1 isEqualTo format["{a:ST:""a""%1b:ST:""b""}", SEPARATOR];

    // ignoring "a" should result in "b" only
    private _string2 = [_dict, [["a"]]] call EFUNC(serialize);
    diag_log _string2;
    (_string2 isEqualTo "{b:ST:""b""}") and _result1
};

private _test_deserialize = {
    private _dict = call EFUNC(create);
    [_dict, "string", "b"] call EFUNC(set);
    [_dict, "number", 1] call EFUNC(set);
    [_dict, "bool", false] call EFUNC(set);
    [_dict, "text", text "b"] call EFUNC(set);
    [_dict, "array", [1,"b"]] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    private _dict1 = _string call EFUNC(deserialize);
    ([_dict1, "number"] call EFUNC(get)) isEqualTo 1 and
    {([_dict1, "string"] call EFUNC(get)) isEqualTo "b"} and
    {([_dict1, "bool"] call EFUNC(get)) isEqualTo false} and
    {([_dict1, "text"] call EFUNC(get)) isEqualTo (text "b")} and
    {([_dict1, "array"] call EFUNC(get)) isEqualTo [1,"b"]}
};

private _test_serialize_obj = {
    private _dict = call EFUNC(create);
    [_dict, "obj"] call EFUNC(add);
    [_dict, "obj", "a", 1] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    _string isEqualTo "{obj:OB:{a:SC:1}}"
};

private _test_deserialize_obj = {
    private _dict = call EFUNC(create);
    [_dict, "obj"] call EFUNC(add);
    [_dict, "obj", "a", 1] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    _dict = _string call EFUNC(deserialize);

    ([_dict, "obj", "a"] call EFUNC(get)) isEqualTo 1
};

DICT_tests = [_test_basic, _test_copy, _test_delete, _test_del, _test_serialize, _test_serialize_del, _test_serialize_ignore, _test_deserialize, _test_serialize_obj, _test_deserialize_obj];
DICT_names = ["basic", "copy", "delete", "del", "serialize", "serialize_del", "serialize_ignore", "deserialize", "serialize_dictionary", "deserialize_dictionary"];

DICT_test_run = {
    hint "running tests..";

    results = [];
    {
        private _script = [_forEachIndex, _x] spawn {
            params ["_forEachIndex", "_x"];
            private _result = call _x;
            diag_log format ["Test %1: %2", DICT_names select _forEachIndex, ["FAILED", "PASSED"] select _result];
            results pushBack (["FAILED", "PASSED"] select _result);
        };
        waitUntil {scriptDone _script};
    } forEach DICT_tests;
    hint format ["results: %1", results];
};
// [] spawn DICT_test_run
