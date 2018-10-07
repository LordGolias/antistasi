#include "../macros.hpp"
AS_SERVER_ONLY("server.sqf");

// AS_persistent are server-side variables. They are all published.
AS_persistent = createSimpleObject ["Static", [0, 0, 0]];
publicVariable "AS_persistent";
AS_shared = createSimpleObject ["Static", [0, 0, 0]];
publicVariable "AS_shared";
AS_container = createSimpleObject ["Static", [0, 0, 0]];
publicVariable "AS_container";

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

{if not isPlayer _x then {deleteVehicle _x}} forEach allUnits;

diag_log "[AS] Server: waiting for side...";
waitUntil {not isNil {AS_P("player_side")}};

call compile preprocessFileLineNumbers "initialization\common_side_variables.sqf";
AS_common_variables_initialized = true;
call compile preprocessFileLineNumbers "initialization\server_side_variables.sqf";
diag_log "[AS] Server: server side-variables initialized";

waitUntil {not isNil "AS_dataInitialized"};

if isMultiplayer then {
    // after game start because disconnects before have no influence
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

[true] call AS_spawn_fnc_toggle;
[true] call AS_fnc_resourcesToggle;
