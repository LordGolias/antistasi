diag_log "[AS] Dedicated: starting";
call compile preprocessFileLineNumbers "initialization\common_variables.sqf";
waitUntil {private _var = AS_P("player_side"); not isNil "_var"};
call compile preprocessFileLineNumbers "initialization\common_side_variables.sqf";
diag_log "[AS] Dedicated: done";
