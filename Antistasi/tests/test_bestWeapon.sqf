private _test_basic = {
    private _availableWeapons = [["hgun_PDW2000_F"], [1]];
    private _availableMagazines = [["30Rnd_9x21_Mag"], [1]];

    private _result = [_availableWeapons, _availableMagazines, ["hgun_PDW2000_F"], 5] call AS_fnc_getBestWeapon;
    _result isEqualTo "hgun_PDW2000_F"
};

AS_bestWeapons_tests = [
    _test_basic
];
AS_bestWeapons_test_names = [
    "basic"
];

hint "running tests..";

AS_bestWeapons_results = [];
{
    private _script = [_forEachIndex, _x] spawn {
        params ["_forEachIndex", "_x"];
        private _result = call _x;
        if (isNil "_result") then {
            _result = false;
        };
        diag_log format ["AS_bestWeapons.%1: %2", AS_bestWeapons_test_names select _forEachIndex, ["FAILED", "PASSED"] select _result];
        AS_bestWeapons_results pushBack (["FAILED", "PASSED"] select _result);
    };
    waitUntil {scriptDone _script};
} forEach AS_bestWeapons_tests;
private _results = +AS_bestWeapons_results;

AS_bestWeapons_tests = nil;
AS_bestWeapons_test_names = nil;
AS_bestWeapons_results = nil;

hint format ["results: %1", _results];
_results
