private _test_bestWeapon_basic = {
    private _availableWeapons = [["hgun_PDW2000_F"], [1]];
    private _availableMagazines = [["30Rnd_9x21_Mag"], [1]];

    private _result = [_availableWeapons, _availableMagazines, ["hgun_PDW2000_F"], 5] call AS_fnc_getBestWeapon;
    _result isEqualTo "hgun_PDW2000_F"
};

private _test_mergeCargoLists_add_new = {
    private _cargo1 = [["a"], [1]];
    private _cargo2 = [["b"], [1]];

    private _result = [_cargo1, _cargo2] call AS_fnc_mergeCargoLists;
    ((_result select 0) isEqualTo ["a", "b"]) and ((_result select 1) isEqualTo [1, 1])
};

private _test_mergeCargoLists_add_existing = {
    private _cargo1 = [["a"], [1]];
    private _cargo2 = [["a"], [1]];

    private _result = [_cargo1, _cargo2] call AS_fnc_mergeCargoLists;
    ((_result select 0) isEqualTo ["a"]) and ((_result select 1) isEqualTo [2])
};

private _test_mergeCargoLists_remove = {
    private _cargo1 = [["a"], [1]];
    private _cargo2 = [["a"], [1]];

    private _result = [_cargo1, _cargo2, false] call AS_fnc_mergeCargoLists;
    ((_result select 0) isEqualTo []) and ((_result select 1) isEqualTo [])
};

private _test_mergeCargoLists_remove2 = {
    private _cargo1 = [["a"], [10]];
    private _cargo2 = [["a"], [5]];

    private _result = [_cargo1, _cargo2, false] call AS_fnc_mergeCargoLists;
    ((_result select 0) isEqualTo ["a"]) and ((_result select 1) isEqualTo [5])
};

AS_arsenal_tests = [
    _test_BestWeapon_basic,
    _test_mergeCargoLists_add_new,
    _test_mergeCargoLists_add_existing,
    _test_mergeCargoLists_remove,
    _test_mergeCargoLists_remove2
];
AS_arsenal_test_names = [
    "bestWeapon_basic",
    "mergeCargoLists_add_new",
    "mergeCargoLists_add_existing",
    "mergeCargoLists_remove",
    "mergeCargoLists_remove2"
];

hint "running tests..";

AS_arsenal_results = [];
{
    private _script = [_forEachIndex, _x] spawn {
        params ["_forEachIndex", "_x"];
        private _result = call _x;
        if (isNil "_result") then {
            _result = false;
        };
        diag_log format ["AS_arsenal.%1: %2", AS_arsenal_test_names select _forEachIndex, ["FAILED", "PASSED"] select _result];
        AS_arsenal_results pushBack (["FAILED", "PASSED"] select _result);
    };
    waitUntil {scriptDone _script};
} forEach AS_arsenal_tests;
private _results = +AS_arsenal_results;

AS_arsenal_tests = nil;
AS_arsenal_test_names = nil;
AS_arsenal_results = nil;

hint format ["results: %1", _results];
_results
