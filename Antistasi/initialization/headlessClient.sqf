diag_log "[AS] Dedicated: starting";
call compile preprocessFileLineNumbers "initialization\common_variables.sqf";
diag_log "[AS] Dedicated: common variables initialized";
waitUntil {private _var = AS_P("player_side"); not isNil "_var"};
call compile preprocessFileLineNumbers "initialization\common_side_variables.sqf";
diag_log "[AS] Dedicated: side variables initialized";
call AS_scheduler_fnc_initialize;
diag_log "[AS] Dedicated: scheduler initialized";
diag_log "[AS] Dedicated: done";
