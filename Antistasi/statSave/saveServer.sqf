#include "../macros.hpp"
AS_SERVER_ONLY("statSave/saveServer.sqf");
params ["_saveName"];

if (!isNil "AS_savingServer") exitWith {
    ["Canceled: save already in process."] remoteExecCall ["hint",AS_commander];
    diag_log "[AS] Server: saving already in progress...";
};
AS_savingServer = true;
diag_log "[AS] Server: saving game...";
["Saving game..."] remoteExecCall ["hint",AS_commander];

diag_log "[AS] Server: saving BE data...";
[_saveName, "BE_data", ([] call fnc_BE_save)] call AS_fnc_saveStat;

[_saveName, "miembros", miembros] call AS_fnc_saveStat;

diag_log "[AS] Server: saving arsenal...";
[_saveName, "AS_aaf_arsenal", call AS_AAFarsenal_fnc_serialize] call AS_fnc_saveStat;

diag_log "[AS] Server: saving locations...";
[_saveName, "AS_locations", call AS_fnc_location_serialize] call AS_fnc_saveStat;

diag_log "[AS] Server: saving fia_hq...";
[_saveName, "AS_fia_hq", call AS_hq_fnc_serialize] call AS_fnc_saveStat;

diag_log "[AS] Server: saving arsenal...";
[_saveName, "AS_fia_arsenal", call AS_FIAarsenal_fnc_serialize] call AS_fnc_saveStat;

diag_log "[AS] Server: saving persistents...";
[_saveName, "AS_persistents", call AS_persistents_fnc_serialize] call AS_fnc_saveStat;

diag_log "[AS] Server: saving missions...";
[_saveName, "AS_mission", call AS_fnc_mission_serialize] call AS_fnc_saveStat;

diag_log "[AS] Server: saving players...";
[_saveName, "AS_players", call AS_players_fnc_serialize] call AS_fnc_saveStat;

[] call fn_SaveProfile;

AS_savingServer = nil;
diag_log "[AS] Server: saving completed.";
["Game saved"] remoteExecCall ["hint",AS_commander];
