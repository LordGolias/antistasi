#include "macros.hpp"

// number of samples in the moving average of FPS
#define WINDOW_SIZE 12
// sampling rate of FPS
#define SECONDS_PER_SAMPLE 2

AS_scheduler_fnc_initialize = {
    AS_FPSsamples = []; // the recent FPS samples of each machine (local)
    for "_i" from 1 to WINDOW_SIZE do {
    	AS_FPSsamples pushBack 60;
    };

    if isServer then {
        // the server stores status of the clients
        AS_workers = createSimpleObject ["Static", [0, 0, 0]];
        AS_workers setVariable ["_all", []];
    } else {
        // clients send status to the server
        [] spawn {
            while {true} do {
                call AS_scheduler_fnc_sendStatus;
                sleep 5;
            };
        };
    };
    // all sides measure FPS
    [] spawn AS_scheduler_fnc_measureFPS;
};

AS_scheduler_fnc_getWorker = {
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

    _candidates select 0
};

AS_scheduler_fnc_execute = {
    // server side: selects a worker and remotely executes a given function on it.
    params ["_arguments", "_functionName"];

    diag_log format ["[AS] Server: scheduler_fnc_execute(%1):", _functionName];
    private _worker_id = call AS_scheduler_fnc_getWorker;

    _arguments remoteExec [_functionName, _worker_id, false];
};

AS_scheduler_fnc_sendStatus = {
    // clientr side: send status information to the server
    private _data = [AS_FPSsamples, hasInterface, isDedicated];

	[clientOwner, _data] remoteExec ["AS_scheduler_fnc_receiveStatus", 2];
};

AS_scheduler_fnc_receiveStatus = {
    // server side
    params ["_owner", "_data"];

    private _currentWorkers = (AS_workers getVariable "_all");
    if not (_owner in _currentWorkers) then {
        diag_log format ["[AS] Server: scheduler_fnc_receiveStatus received new worker: %1", _owner];
        AS_workers setVariable ["_all",_currentWorkers + [_owner]];
    };
    private _id = str _owner;
    AS_workers setVariable ["_data" + _id, _data];
    AS_workers setVariable ["_last_update" + _id, time];
};

AS_scheduler_fnc_measureFPS = {
    private _FPSindex = 0; // the next index of AS_FPSsamples to be updated
    while {true} do {
    	sleep SECONDS_PER_SAMPLE;
    	AS_FPSsamples set [_FPSindex, diag_fps];
    	_FPSindex = _FPSindex + 1;
    	if (_FPSindex == WINDOW_SIZE) then {
    		_FPSindex = 0;
    	};
    };
};
