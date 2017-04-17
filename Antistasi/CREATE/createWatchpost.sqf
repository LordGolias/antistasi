#include "../macros.hpp"
params ["_marcador"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _posicion = getMarkerPos _marcador;

// create bunker
private _veh = createVehicle ["Land_BagBunker_Tower_F", _posicion, [],0, "NONE"];
_veh setVectorUp (surfacenormal (getPosATL _veh));
_vehiculos pushBack _veh;
_veh setDir (markerDir _marcador);

// create flag
_veh = createVehicle [cFlag, _posicion, [],0, "NONE"];
_vehiculos pushBack _veh;

// create crate
_veh = createVehicle ["I_supplyCrate_F", _posicion, [],0, "NONE"];
_vehiculos pushBack _veh;
[_veh, "Watchpost"] call AS_fnc_fillCrateAAF;

// create truck
([_marcador] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
_vehiculos append _vehicles1;

// create a mortar
private _veh = statMortar createVehicle ([_posicion] call mortarPos);
[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
private _grupo = createGroup side_green;
_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
[_unit, false] spawn AS_fnc_initUnitAAF;
_unit moveInGunner _veh;
_soldados pushBack _unit;
_vehiculos pushBack _veh;
_grupos pushBack _grupo;
sleep 1;

{[_x] spawn cleanserVeh} forEach _vehiculos;

// create the AT group
private _grupo = [_posicion, side_green, [infTeamATAA, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
[leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] execVM "scripts\UPSMON.sqf";
{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
_grupos pushBack _grupo;
sleep 1;

private _fnc_isDestroyed = {
	({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)
};

waitUntil {sleep 1;
	!(spawner getVariable _marcador) or (call _fnc_isDestroyed)
};

if (call _fnc_isDestroyed) then {
	[-5,0,_posicion] remoteExec ["citySupportChange",2];
	[["TaskSucceeded", ["", "Outpost Cleansed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	_mrk = format ["Dum%1",_marcador];
	deleteMarker _mrk;
	mrkAAF = mrkAAF - [_marcador];
	mrkFIA = mrkFIA + [_marcador];
	publicVariable "mrkAAF";
	publicVariable "mrkFIA";
	[_posicion] remoteExec ["patrolCA",HCattack];
	if (hayBE) then {["cl_loc"] remoteExec ["fnc_BE_XP", 2]};
};

waitUntil {sleep 1; not (spawner getVariable _marcador)};

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteGroup _x} forEach _grupos;
{
	if (!([AS_P("spawnDistance")-100,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x}
} forEach _vehiculos;
