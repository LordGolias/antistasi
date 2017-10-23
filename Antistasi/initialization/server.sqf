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

[] execVM "Scripts\fn_advancedTowingInit.sqf"; // the installation is done for all clients by this

if isMultiplayer then {
    addMissionEventHandler ["HandleDisconnect", {
        [_this select 0] call AS_fnc_onPlayerDisconnect;
        false
    }];

    // for the spawns
    addMissionEventHandler ["HandleDisconnect", {
        private _owner = _this select 4;
        _owner call AS_spawn_fnc_drop;
        false
    }];

    // this will wait until a commander is chosen
    ["none"] call AS_fnc_chooseCommander;
} else {
    [player] call AS_fnc_setCommander;
};

{if not isPlayer _x then {deleteVehicle _x}} forEach allUnits;

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
