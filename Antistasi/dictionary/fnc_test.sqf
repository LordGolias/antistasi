#include "macros.hpp"

private _test_split_basic = {
    private _string = "10,10";

    private _obtained = [_string, ",", "[", "]"] call EFUNC(_splitStringDelimited);
    _obtained isEqualTo ["10", "10"]
};

private _test_split_nested = {
    private _string = "0,[1,2,[3,[]]],4";

    private _obtained = [_string, ",", "[", "]"] call EFUNC(_splitStringDelimited);
    _obtained isEqualTo ["0", "[1,2,[3,[]]]", "4"]
};

private _test_split_sequential = {
    private _string = "0,[1,2],[3]";

    private _obtained = [_string, ",", "[", "]"] call EFUNC(_splitStringDelimited);
    _obtained isEqualTo ["0", "[1,2]", "[3]"]
};

private _test_basic = {
    private _dict = call EFUNC(create);
    [_dict, "sub1", "b"] call EFUNC(set);
    [_dict, "sub2", call EFUNC(create)] call EFUNC(set);
    [_dict, "sub2", "c", "d"] call EFUNC(set);

    private _b = [_dict, "sub1"] call EFUNC(get);
    private _d = [_dict, "sub2", "c"] call EFUNC(get);
    _d isEqualTo "d" and _b isEqualTo "b"
};

private _test_copy = {
    private _dict = call EFUNC(create);
    [_dict, "sub1", "b"] call EFUNC(set);
    [_dict, "sub2", call EFUNC(create)] call EFUNC(set);
    [_dict, "sub2", "c", "d"] call EFUNC(set);

    private _copy = _dict call EFUNC(copy);
    private _b = [_copy, "sub1"] call EFUNC(get);
    private _d = [_copy, "sub2", "c"] call EFUNC(get);
    _d isEqualTo "d" and _b isEqualTo "b"
};

private _test_delete = {
    private _dict = call EFUNC(create);
    [_dict, "a", call EFUNC(create)] call EFUNC(set);

    private _dict2 = [_dict, "a"] call EFUNC(get);

    _dict call EFUNC(del);
    sleep 0.01; // wait one frame
    isNull _dict2 and isNull _dict
};

private _test_del = {
    private _dict = call EFUNC(create);
    [_dict, "a", call EFUNC(create)] call EFUNC(set);
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
    private _expected = format["%2text:TE:b%1string:ST:""b""%1bool:BO:false%1number:SC:1%1array:AR:%4:SC:1,1:ST:""b""%5%3",
        OB_SEPARATOR, OB_START, OB_END, AR_START + "0", AR_END];
    _string isEqualTo _expected
};

private _test_serialize_del = {
    // do not serialize deleted (nil) values
    private _dict = call EFUNC(create);
    [_dict, "string", "b"] call EFUNC(set);
    [_dict, "string"] call EFUNC(del);

    private _string = _dict call EFUNC(serialize);
    _string isEqualTo format["%1%2", OB_START, OB_END]
};

private _test_serialize_ignore = {
    // do not serialize deleted (nil) values
    private _dict = call EFUNC(create);
    [_dict, "a", "a"] call EFUNC(set);
    [_dict, "b", "b"] call EFUNC(set);

    private _string1 = _dict call EFUNC(serialize);
    private _result1 = _string1 isEqualTo format["%2a:ST:""a""%1b:ST:""b""%3", OB_SEPARATOR, OB_START, OB_END];

    // ignoring "a" should result in "b" only
    private _string2 = [_dict, [["a"]]] call EFUNC(serialize);
    (_string2 isEqualTo  format["%1b:ST:""b""%2", OB_START, OB_END]) and _result1
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
    (([_dict1, "number"] call EFUNC(get)) isEqualTo 1) and
    {([_dict1, "string"] call EFUNC(get)) isEqualTo "b"} and
    {([_dict1, "bool"] call EFUNC(get)) isEqualTo false} and
    {([_dict1, "text"] call EFUNC(get)) isEqualTo (text "b")} and
    {([_dict1, "array"] call EFUNC(get)) isEqualTo [1,"b"]}
};

private _test_array_of_array = {
    private _expected = format ["%1b:AR:%3%5:SC:0,1:SC:1,2:AR:%3%5:SC:0,1:SC:1%4%4%2",OB_START, OB_END, AR_START, AR_END, "0"];
    private _dict = _expected call EFUNC(deserialize);
    private _obtained = _dict call EFUNC(serialize);
    private _result = _expected isEqualTo _obtained;
    _dict call EFUNC(del);

    _expected = format ["%1b:AR:%3%5:SC:0,1:AR:%3%5:SC:0,1:SC:1%4,2:AR:%3%4%4%2",OB_START, OB_END, AR_START, AR_END, "0"];
    _dict = _expected call EFUNC(deserialize);
    _obtained = _dict call EFUNC(serialize);
    _dict call EFUNC(del);

    _result and (_expected isEqualTo _obtained)
};

private _test_deserialize_empty_array_of_array = {
    private _dict = call EFUNC(create);

    [_dict, "magazines", [[],[]]] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);

    private _dict1 = _string call EFUNC(deserialize);
    private _string1 = _dict1 call EFUNC(serialize);

    _dict call EFUNC(del);
    _dict1 call EFUNC(del);
    _string1 == _string
};

private _test_serialize_obj = {
    private _dict = call EFUNC(create);
    [_dict, "obj", call EFUNC(create)] call EFUNC(set);
    [_dict, "obj", "a", 1] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    _string isEqualTo format["%1obj:OB:%1a:SC:1%2%2", OB_START, OB_END]
};

private _test_deserialize_obj = {
    private _dict = call EFUNC(create);
    [_dict, "obj", call EFUNC(create)] call EFUNC(set);
    [_dict, "obj", "a", 1] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    _dict = _string call EFUNC(deserialize);

    ([_dict, "obj", "a"] call EFUNC(get)) isEqualTo 1
};

private _test_with_coma = {
    private _dict = call EFUNC(create);
    [_dict, "string", "b,c"] call EFUNC(set);

    private _string = _dict call EFUNC(serialize);
    private _dict1 = _string call EFUNC(deserialize);
    private _result = (([_dict1, "string"] call EFUNC(get)) isEqualTo "b,c");
    _dict call EFUNC(del);
    _dict1 call EFUNC(del);
    _result
};

DICT_tests = [
    _test_split_basic, _test_split_nested, _test_split_sequential,
    _test_basic, _test_copy, _test_delete, _test_del, _test_serialize,
    _test_serialize_del, _test_serialize_ignore,
    _test_deserialize, _test_array_of_array,
    _test_serialize_obj, _test_deserialize_obj,
    _test_deserialize_empty_array_of_array, _test_with_coma
];
DICT_test_names = [
    "split_basic", "split_nested", "split_sequential",
    "basic", "copy", "delete", "del", "serialize",
    "serialize_del", "serialize_ignore",
    "deserialize", "array_of_array",
    "serialize_dictionary", "deserialize_dictionary",
    "empty_array_of_array", "with_coma"
];

hint "running tests..";

DICT_results = [];
{
    private _script = [_forEachIndex, _x] spawn {
        params ["_forEachIndex", "_x"];
        private _result = call _x;
        if (isNil "_result") then {
            _result = false;
        };
        diag_log format ["Test %1: %2", DICT_test_names select _forEachIndex, ["FAILED", "PASSED"] select _result];
        DICT_results pushBack (["FAILED", "PASSED"] select _result);
    };
    waitUntil {scriptDone _script};
} forEach DICT_tests;
private _results = +DICT_results;

DICT_tests = nil;
DICT_test_names = nil;
DICT_results = nil;

hint format ["results: %1", _results];
_results
