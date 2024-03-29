#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_deserialize");
params ["_string"];

// stop game
[false] call AS_spawn_fnc_toggle;
[false] call AS_fnc_resourcesToggle;

// despawn every spawned location
{
    if (_x call AS_location_fnc_spawned) then {
        _x call AS_location_fnc_despawn;
    };
} forEach (call AS_location_fnc_all);

diag_log "[AS] Server: deserializing data...";
private _dict = _string call DICT_fnc_deserialize;

diag_log "[AS] Server: migrating to latest save version...";
_dict call AS_database_fnc_migrate;

// this only sets the persistents
diag_log "[AS] Server: loading persistents...";
([_dict, "AS_persistent"] call DICT_fnc_get) call AS_database_fnc_persistents_fromDict;

// above initializes player_side, which is required to initialize common variables on the other thread
// we need to wait for them to be initialized before continuing
waitUntil {sleep 0.1; not isNil "AS_common_variables_initialized"};

// this order matters!
diag_log "[AS] Server: loading locations...";
([_dict, "AS_location"] call DICT_fnc_get) call AS_location_fnc_fromDict;

call AS_database_fnc_persistents_start;

diag_log "[AS] Server: loading HQ...";
([_dict, "AS_fia_hq"] call DICT_fnc_get) call AS_database_fnc_hq_fromDict;

diag_log "[AS] Server: loading FIA arsenal...";
([_dict, "AS_fia_arsenal"] call DICT_fnc_get) call AS_FIAarsenal_fnc_fromDict;

diag_log "[AS] Server: loading players...";
// depends on `AS_FIAarsenal_fnc_fromDict`
([_dict, "AS_player"] call DICT_fnc_get) call AS_players_fnc_fromDict;

diag_log "[AS] Server: loading AAF arsenal...";
([_dict, "AS_aaf_arsenal"] call DICT_fnc_get) call AS_AAFarsenal_fnc_fromDict;

diag_log "[AS] Server: loading missions...";
([_dict, "AS_mission"] call DICT_fnc_get) call AS_mission_fnc_fromDict;

_dict call DICT_fnc_del;
diag_log "[AS] Server: loading completed.";

AS_dataInitialized = true;
