#include "../macros.hpp"
AS_SERVER_ONLY("statSave/loadServer.sqf");
params ["_saveName"];

petros allowdamage false;

[_saveName] call AS_fnc_loadPersistents;
[_saveName] call AS_fnc_loadArsenal;
[true] call fnc_MAINT_arsenal;

antenasmuertas = [_saveName, "deadAntennas"] call fn_LoadStat;
antenas = [_saveName, "antennas"] call fn_LoadStat;
{
	private _antenna = nearestBuilding _x;
	_antenna removeAllEventHandlers "Killed";
	_antenna setDamage 1;
} forEach antenasmuertas;
{
	private _antenna = nearestBuilding _x;
	_antenna removeAllEventHandlers "Killed";
	_antenna setDamage 0;
	_antenna addEventHandler ["Killed", AS_fnc_antennaKilledEH];
} forEach antenas;
publicVariable "antenas";
publicVariable "antenasmuertas";

[_saveName, "fecha"] call fn_LoadStat;
[_saveName, "smallCAmrk"] call fn_LoadStat;
[_saveName, "miembros"] call fn_LoadStat;

[_saveName] call AS_fnc_location_load;

{
	[_x] call AS_fnc_location_destroy;
} forEach AS_P("destroyedLocations");

// destroy the buildings.
{
	private _buildings = [];
	private _dist = 5;
	while {count _buildings == 0} do {
		_buildings = nearestObjects [_x, listMilBld, _dist];
		_dist = _dist + 5;
	};
	(_buildings select 0) setDamage 1;
} forEach AS_P("destroyedBuildings");

{
	[_x] call powerReorg;
} forEach ("powerplant" call AS_fnc_location_T);

[_saveName] call AS_fnc_loadAAFarsenal;
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

[[_saveName, "BE_data"] call fn_LoadStat] call fnc_BE_load;

diag_log format ['[AS] Server: game "%1" loaded', _saveName];
petros allowdamage true;

// load all generic objects (e.g. missions)
[_saveName] call AS_fnc_object_load;

// re-activate all missions.
{[_x, true] call AS_fnc_mission_activate} forEach (call AS_fnc_active_missions);

 // resume existing attacks in 25 seconds.
[] spawn {
    sleep 25;
    private _tmpCAmrk = + smallCAmrk;
    smallCAmrk = [];
    {
		private _position = (_x call AS_fnc_location_position);
    	private _base = [_position] call findBasesForCA;
    	private _radio = _position call radioCheck;
    	if ((_base != "") and (_radio) and (_x in mrkFIA) and (not(_x in smallCAmrk))) then {
        	[_x] remoteExec ["patrolCA",HCattack];
        	smallCAmrk pushBackUnique _x;
        };
    } forEach _tmpCAmrk;
    publicVariable "smallCAmrk";
};
