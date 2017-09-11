#include "../macros.hpp"
AS_SERVER_ONLY("statSave/deserializeServer.sqf");
params ["_string"];

petros allowdamage false;

private _dict = _string call DICT_fnc_deserialize;

// this order matters!
([_dict, "AS_location"] call DICT_fnc_get) call AS_fnc_location_fromDict;
([_dict, "AS_persistent"] call DICT_fnc_get) call AS_persistents_fnc_fromDict;
([_dict, "AS_fia_hq"] call DICT_fnc_get) call AS_hq_fnc_fromDict;
([_dict, "AS_fia_arsenal"] call DICT_fnc_get) call AS_FIAarsenal_fnc_fromDict;
([_dict, "AS_player"] call DICT_fnc_get) call AS_players_fnc_fromDict;
([_dict, "AS_aaf_arsenal"] call DICT_fnc_get) call AS_AAFarsenal_fnc_fromDict;
([_dict, "AS_mission"] call DICT_fnc_get) call AS_fnc_mission_fromDict;
petros allowdamage true;

_dict call DICT_fnc_delete;
