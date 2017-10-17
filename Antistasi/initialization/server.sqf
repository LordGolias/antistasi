#include "../macros.hpp"
AS_SERVER_ONLY("server.sqf");

// AS_persistent are server-side variables. They are all published.
AS_persistent = createSimpleObject ["Static", [0, 0, 0]];
publicVariable "AS_persistent";
AS_shared = createSimpleObject ["Static", [0, 0, 0]];
publicVariable "AS_shared";
AS_containers = createSimpleObject ["Static", [0, 0, 0]];
publicVariable "AS_containers";

diag_log "[AS] Server: starting";
call compile preprocessFileLineNumbers "initLocations.sqf";
diag_log "[AS] Server: initLocations done";
call compile preprocessFileLineNumbers "initialization\common_variables.sqf";
// tells the client.sqf running on this machine that variables are initialized
AS_common_variables_initialized = true;
diag_log "[AS] Server: common variables initialized";

call compile preprocessFileLineNumbers "initialization\server_variables.sqf";
diag_log "[AS] Server: server variables initialized";

["Initialize"] call BIS_fnc_dynamicGroups;

if isMultiplayer then {
    call compile preProcessFileLineNumbers "initialization\serverMP.sqf";
} else {
    call compile preProcessFileLineNumbers "initialization\serverSP.sqf";
};

{if not isPlayer _x then {deleteVehicle _x}} forEach allUnits;

if isNull AS_commander then {
    diag_log "[AS] Server: waiting for a commander...";
    while {isNull AS_commander} do {
        ["none"] call AS_fnc_chooseCommander;
        sleep 1;
    }
};

diag_log "[AS] Server: waiting for side...";
waitUntil {private _var = AS_P("player_side"); not isNil "_var"};

call compile preprocessFileLineNumbers "initialization\common_side_variables.sqf";
AS_common_variables_initialized = true;
call compile preprocessFileLineNumbers "initialization\server_side_variables.sqf";
diag_log "[AS] Server: server side-variables initialized";

diag_log "[AS] Server: waiting for HQ position...";
waitUntil {!(isNil "placementDone")};
[true] call AS_spawn_fnc_toggle;
[true] call AS_fnc_resourcesToggle;
