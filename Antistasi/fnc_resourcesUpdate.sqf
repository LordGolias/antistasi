#include "macros.hpp"
AS_SERVER_ONLY("resourcesUpdate");

call AS_mission_fnc_updateAvailable;
if (isMultiplayer) then {waitUntil {sleep 10; isPlayer AS_commander}};

call AS_fnc_updateAll;
// update AAF economics.
call AS_fnc_spendAAFmoney;

// Assign new commander if needed.
if isMultiplayer then {[] spawn AS_fnc_chooseCommander;};

[[], "AS_movement_fnc_sendAAFroadPatrol"] call AS_scheduler_fnc_execute;

// repair and re-arm all statics.
{
    private _veh = _x;
    if ((_veh isKindOf "StaticWeapon") and ({isPlayer _x} count crew _veh == 0) and (alive _veh)) then {
        _veh setDamage 0;
        [_veh,1] remoteExec ["setVehicleAmmoDef",_veh];
    };
} forEach vehicles;

// update the counter by the time that has passed
[-AS_resourcesLoopTime] call AS_fnc_changeSecondsforAAFattack;

// start AAF attacks under certain conditions.
if (AS_P("secondsForAAFAttack") < 1) then {
    private _noWaves = isNil {AS_S("waves_active")};
    if ((count ("aaf_attack" call AS_mission_fnc_active_missions) == 0) and _noWaves) then {
        private _script = [] spawn AS_movement_fnc_sendAAFattack;
        waitUntil {sleep 5; scriptDone _script};
    };
};

// Check if any communications were intercepted.
[] call AS_fnc_revealFromAAFRadio;
