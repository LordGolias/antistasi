#include "../macros.hpp"
AS_SERVER_ONLY("fnc_getWorker");
// server side: returns the `ownerID` with the current highest average FPS, weighted
// by whether the client is headless or dedicated.
if not isMultiplayer exitWith {
    2
};

private _candidates = [2];  // 2 = the server
private _specs = [[AS_FPSsamples, hasInterface, isDedicated]];
{
    if ((AS_workers getVariable ("_last_update" + str _x)) + 10 > time) then {
        _candidates pushBack _x;
        _specs pushBack (AS_workers getVariable ("_data" + str _x));
    };
} forEach (AS_workers getVariable "_all");

private _sortingFunction = {
    private _index = _input0 find _x;
    (_input1 select _index) params ["_FPSsamples", "_hasInterface", "_isDedicated"];

    private _average = 0;
    {_average = _average + _x} forEach _FPSsamples;
    _average = _average / count _FPSsamples;

    private _isHeadless = !_hasInterface and !_isDedicated;
    _isHeadless = [0, 1] select _isHeadless;
    _hasInterface = [0, 1] select _hasInterface;
    // headless has 3x the average, dedicated has 2x the average
    _average*(1 + 1*_isHeadless + 1*(1 - _hasInterface))
};
_candidates = [_candidates, [_candidates, _specs], _sortingFunction, "DESCEND"] call BIS_fnc_sortBy;
{
    private _input0 = _candidates;
    private _input1 = _specs;
    diag_log format ["Worker %1: %2", _x, call _sortingFunction];
} forEach _candidates;

2
