#include "../macros.hpp"
AS_SERVER_ONLY("statSave/loadServer.sqf");
params ["_saveName"];

petros allowdamage false;

// this order matters!
([_saveName, "AS_locations"] call AS_fnc_loadStat) call AS_fnc_location_deserialize;
([_saveName, "AS_persistents"] call AS_fnc_loadStat) call AS_persistents_fnc_deserialize;
([_saveName, "AS_fia_arsenal"] call AS_fnc_loadStat) call AS_FIAarsenal_fnc_deserialize;
([_saveName, "AS_players"] call AS_fnc_loadStat) call AS_players_fnc_deserialize;
[true] call fnc_MAINT_arsenal;

{
	private _antenna = nearestBuilding _x;
	_antenna removeAllEventHandlers "Killed";
	_antenna setDamage 1;
} forEach AS_P("antenasPos_dead");
{
	private _antenna = nearestBuilding _x;
	_antenna removeAllEventHandlers "Killed";
	_antenna setDamage 0;
	_antenna addEventHandler ["Killed", AS_fnc_antennaKilledEH];
} forEach AS_P("antenasPos_alive");

{
	[_x, false] call AS_fnc_location_destroy;
} forEach AS_P("destroyedLocations");

// destroy the buildings.
{
	private _buildings = [];
	private _dist = 5;
	while {count _buildings == 0} do {
		_buildings = nearestObjects [_x, AS_destroyable_buildings, _dist];
		_dist = _dist + 5;
	};
	(_buildings select 0) setDamage 1;
} forEach AS_P("destroyedBuildings");

{
	[_x] call powerReorg;
} forEach ("powerplant" call AS_fnc_location_T);

([_saveName, "AS_aaf_arsenal"] call AS_fnc_loadStat) call AS_AAFarsenal_fnc_deserialize;
([_saveName, "AS_fia_hq"] call AS_fnc_loadStat) call AS_hq_fnc_deserialize;

[[_saveName, "BE_data"] call AS_fnc_loadStat] call fnc_BE_load;

([_saveName, "AS_mission"] call AS_fnc_loadStat) call AS_fnc_mission_deserialize;

diag_log format ['[AS] Server: game "%1" loaded', _saveName];
petros allowdamage true;

 // resume existing attacks in 25 seconds.
[] spawn {
    sleep 25;
    {
		[[_x], "patrolCA"] call AS_scheduler_fnc_execute;
    } forEach AS_P("patrollingLocations");
	{
		[[_x], "patrolCA"] call AS_scheduler_fnc_execute;
    } forEach AS_P("patrollingPositions");
};
