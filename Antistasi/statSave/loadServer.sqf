#include "../macros.hpp"
AS_SERVER_ONLY("statSave/loadServer.sqf");
params ["_saveName"];

petros allowdamage false;

[_saveName] call AS_fnc_loadPersistents;
[_saveName] call AS_fnc_loadArsenal;
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

[_saveName, "fecha"] call AS_fnc_loadStat;
[_saveName, "miembros"] call AS_fnc_loadStat;

[_saveName] call AS_fnc_location_load;

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

[_saveName] call AS_AAFarsenal_fnc_load;
[_saveName] call AS_fnc_loadHQ;

if (isMultiplayer) then {
	{
        private _jugador = _x;
        if ([_jugador] call isMember) then
            {
            {_jugador removeMagazine _x} forEach magazines _jugador;
            {_jugador removeWeaponGlobal _x} forEach weapons _jugador;
            removeBackpackGlobal _jugador;
            };
        private _pos = (getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle _jugador)];
        _jugador setPos _pos;
	} forEach playableUnits;

    call AS_fnc_loadPlayers;

} else {
	{player removeMagazine _x} forEach magazines player;
	{player removeWeaponGlobal _x} forEach weapons player;
	removeBackpackGlobal player;

	private _pos = (getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle player)];
	player setPos _pos;
};

[[_saveName, "BE_data"] call AS_fnc_loadStat] call fnc_BE_load;

// load all generic objects (e.g. missions)
[_saveName] call AS_fnc_mission_load;

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
