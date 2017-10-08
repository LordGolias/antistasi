waitUntil {(count playableUnits) > 0};
waitUntil {({(isPlayer _x) and (!isNull _x) and (_x == _x)} count allUnits) == (count playableUnits)};

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

AS_commander = playableUnits select 0;
AS_commander setUnitRank "CORPORAL";
publicVariable "AS_commander";

diag_log "[AS] Server MP: players are in";
