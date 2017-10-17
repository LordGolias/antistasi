#include "../macros.hpp"
[] execVM "Scripts\fn_advancedTowingInit.sqf"; // the installation is done for all clients by this

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

["none"] call AS_fnc_chooseCommander;
