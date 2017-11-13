#include "../macros.hpp"
AS_SERVER_ONLY("fnc_receiveStatus");
params ["_owner", "_data"];

private _currentWorkers = (AS_workers getVariable "_all");
if not (_owner in _currentWorkers) then {
    diag_log format ["[AS] Server: scheduler_fnc_receiveStatus received new worker: %1", _owner];
    AS_workers setVariable ["_all",_currentWorkers + [_owner]];
};
private _id = str _owner;
AS_workers setVariable ["_data" + _id, _data];
AS_workers setVariable ["_last_update" + _id, time];
