#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_completed");
params ["_mission"];
private _active = (call AS_mission_fnc_all) select {_x call AS_mission_fnc_status in ["active"]};
if not (_mission in _active) exitWith {
    diag_log format ["[AS] Error: AS_mission_fnc_complete: mission '%1' is not active", _mission];
};

[_mission, "status", "completed"] call AS_mission_fnc_set;
