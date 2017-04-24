#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};
params ["_location"];

private _vehiculos = [];
private _soldados = [];

private _posicion = _location call AS_fnc_location_position;

(_posicion call AS_fnc_roadAndDir) params ["_road", "_dirveh"];

// create bunker on one side
private _pos = [getPos _road, 7, _dirveh + 270] call BIS_Fnc_relPos;
private _bunker = "Land_BagBunker_Small_F" createVehicle _pos;
_bunker setDir _dirveh;
_vehiculos pushBack _bunker;

private _veh = statMG createVehicle _posicion;
_veh setPosATL (getPosATL _bunker);
_veh setDir _dirVeh;
_vehiculos pushBack _veh;

private _grupoE = createGroup side_green;  // temp group

private _unit = ([_posicion, 0, infGunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
_unit moveInGunner _veh;
_soldados pushBack _unit;
sleep 1;

// create bunker on the other side
private _pos = [getPos _road, 7, _dirveh + 90] call BIS_Fnc_relPos;
private _bunker = "Land_BagBunker_Small_F" createVehicle _pos;
_vehiculos pushBack _bunker;
_bunker setDir _dirveh + 180;

_pos = getPosATL _bunker;
private _veh = statMG createVehicle _posicion;
_veh setPosATL _pos;
_veh setDir _dirVeh;
_vehiculos pushBack _veh;

_unit = ([_posicion, 0, infGunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
_unit moveInGunner _veh;
_soldados pushBack _unit;

// Create flag
_pos = [getPos _bunker, 6, getDir _bunker] call BIS_fnc_relPos;
_veh = createVehicle [cFlag, _pos, [],0, "CAN_COLLIDE"];
_vehiculos pushBack _veh;

{[_x, "AAF"] call AS_fnc_initVehicle} forEach _vehiculos;

// create the patrol group
_grupo = [_posicion, side_green, [infAT, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
{[_x] join _grupo} forEach units _grupoE;
private _soldier = ([_posicion, 0, sol_MED, _grupo] call bis_fnc_spawnvehicle) select 0;
_grupo selectLeader (units _grupo select 1);
deleteGroup _grupoE;

// add dog
if (random 10 < 2.5) then {
	[_grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"]] spawn guardDog;
};

[leader _grupo, _location, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";

{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;

waitUntil {sleep 1;
	!(_location call AS_fnc_location_spawned) or
	{alive _x and !(fleeing _x)} count _soldados == 0
};

private _conquistado = false;
if !(_location call AS_fnc_location_spawned) then {
	_conquistado = true;
	[-5,0,_posicion] remoteExec ["citySupportChange",2];
	[["TaskSucceeded", ["", "Roadblock Cleared"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[_posicion] remoteExec ["patrolCA", HCattack];

	[_location,"side","FIA"] call AS_fnc_location_set;
	_location call AS_fnc_location_updateMarker;
	["cl_loc"] remoteExec ["fnc_BE_XP", 2];
};

waitUntil {sleep 1;not (_location call AS_fnc_location_spawned)};

{
	if (not(_x in AS_P("vehicles"))) then {
		deleteVehicle _x;
	};
} forEach _vehiculos;
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
deleteGroup _grupo;

if (_conquistado) then {
	_tiempolim = 120;//120
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
	_fechalimnum = dateToNumber _fechalim;
	waitUntil {sleep 60; (dateToNumber date > _fechalimnum)};
	if (_location call AS_fnc_location_side == "AAF") then {
		// todo: delete this marker
		_location call AS_fnc_location_updateMarker;
	};
};
