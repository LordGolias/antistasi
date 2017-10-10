#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_deserialize");
params ["_string"];

// stop spawning new locations
[false] call AS_spawn_fnc_toggle;
// despawn every spawned location
{
    if (_x call AS_location_fnc_spawned) then {
        _x call AS_location_fnc_despawn;
    };
} forEach (call AS_location_fnc_all);

[false] call AS_fnc_resourcesToggle;

diag_log "[AS] Server: deserializing data...";
private _dict = _string call DICT_fnc_deserialize;

diag_log "[AS] Server: migrating to latest save version...";
_dict call AS_database_fnc_migrate;

// this only sets the persistents
diag_log "[AS] Server: loading persistents...";
([_dict, "AS_persistent"] call DICT_fnc_get) call AS_database_fnc_persistents_fromDict;

// this order matters!
diag_log "[AS] Server: loading locations...";
([_dict, "AS_location"] call DICT_fnc_get) call AS_location_fnc_fromDict;

call AS_database_fnc_persistents_start;

diag_log "[AS] Server: loading HQ...";
([_dict, "AS_fia_hq"] call DICT_fnc_get) call AS_database_fnc_hq_fromDict;

diag_log "[AS] Server: loading FIA arsenal...";
([_dict, "AS_fia_arsenal"] call DICT_fnc_get) call AS_FIAarsenal_fnc_fromDict;

diag_log "[AS] Server: loading players...";
([_dict, "AS_player"] call DICT_fnc_get) call AS_players_fnc_fromDict;

diag_log "[AS] Server: loading AAF arsenal...";
([_dict, "AS_aaf_arsenal"] call DICT_fnc_get) call AS_AAFarsenal_fnc_fromDict;

diag_log "[AS] Server: loading missions...";
([_dict, "AS_mission"] call DICT_fnc_get) call AS_mission_fnc_fromDict;

_dict call DICT_fnc_delete;
diag_log "[AS] Server: loading completed.";

// start spawning again
[true] call AS_spawn_fnc_toggle;
[true] call AS_fnc_resourcesToggle;
