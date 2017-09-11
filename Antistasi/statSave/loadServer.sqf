#include "../macros.hpp"
AS_SERVER_ONLY("statSave/loadServer.sqf");
params ["_saveName"];

petros allowdamage false;

// this order matters!
([_saveName, "AS_locations"] call AS_fnc_loadStat) call AS_fnc_location_deserialize;
([_saveName, "AS_persistents"] call AS_fnc_loadStat) call AS_persistents_fnc_deserialize;
([_saveName, "AS_fia_hq"] call AS_fnc_loadStat) call AS_hq_fnc_deserialize;
([_saveName, "AS_fia_arsenal"] call AS_fnc_loadStat) call AS_FIAarsenal_fnc_deserialize;
([_saveName, "AS_players"] call AS_fnc_loadStat) call AS_players_fnc_deserialize;
([_saveName, "AS_aaf_arsenal"] call AS_fnc_loadStat) call AS_AAFarsenal_fnc_deserialize;
([_saveName, "AS_mission"] call AS_fnc_loadStat) call AS_fnc_mission_deserialize;

diag_log format ['[AS] Server: game "%1" loaded', _saveName];
petros allowdamage true;
