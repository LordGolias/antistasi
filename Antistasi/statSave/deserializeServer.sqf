#include "../macros.hpp"
AS_SERVER_ONLY("statSave/deserializeServer.sqf");
params ["_string"];

petros allowdamage false;

// stop spawning new locations
[false] call AS_fnc_spawnToggle;
// despawn every spawned location
{
    if (_x call AS_fnc_location_spawned) then {
        _x call AS_fnc_location_despawn;
    };
} forEach (call AS_fnc_locations);

[false] call AS_fnc_resourcesToggle;

diag_log "[AS] Server: deserializing data...";
private _dict = _string call DICT_fnc_deserialize;

// this order matters!
diag_log "[AS] Server: loading locations...";
([_dict, "AS_location"] call DICT_fnc_get) call AS_fnc_location_fromDict;

diag_log "[AS] Server: loading persistents...";
([_dict, "AS_persistent"] call DICT_fnc_get) call AS_persistents_fnc_fromDict;

diag_log "[AS] Server: loading HQ...";
([_dict, "AS_fia_hq"] call DICT_fnc_get) call AS_hq_fnc_fromDict;

diag_log "[AS] Server: loading FIA arsenal...";
([_dict, "AS_fia_arsenal"] call DICT_fnc_get) call AS_FIAarsenal_fnc_fromDict;

diag_log "[AS] Server: loading players...";
([_dict, "AS_player"] call DICT_fnc_get) call AS_players_fnc_fromDict;

diag_log "[AS] Server: loading AAF arsenal...";
([_dict, "AS_aaf_arsenal"] call DICT_fnc_get) call AS_AAFarsenal_fnc_fromDict;

diag_log "[AS] Server: loading missions...";
([_dict, "AS_mission"] call DICT_fnc_get) call AS_fnc_mission_fromDict;
petros allowdamage true;

_dict call DICT_fnc_delete;
diag_log "[AS] Server: loading completed.";

// start spawning again
[true] call AS_fnc_spawnToggle;
[true] call AS_fnc_resourcesToggle;
