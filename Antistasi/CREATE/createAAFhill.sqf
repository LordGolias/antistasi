#include "../macros.hpp"

private _fnc_spawn = {
	params ["_location"];
	private _posicion = _location call AS_fnc_location_position;

	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];

	// create bunker
	private _veh = createVehicle ["Land_BagBunker_Tower_F", _posicion, [],0, "NONE"];
	_veh setVectorUp (surfacenormal (getPosATL _veh));
	_vehiculos pushBack _veh;

	// create flag
	_veh = createVehicle [cFlag, _posicion, [],0, "NONE"];
	_vehiculos pushBack _veh;

	// create crate
	_veh = createVehicle ["I_supplyCrate_F", _posicion, [],0, "NONE"];
	_vehiculos pushBack _veh;
	[_veh, "Watchpost"] call AS_fnc_fillCrateAAF;

	// create truck
	([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
	_vehiculos append _vehicles1;

	// create a mortar
	private _veh = statMortar createVehicle ([_posicion] call mortarPos);
	[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
	private _grupo = createGroup side_red;
	private _unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
	[_unit, false] spawn AS_fnc_initUnitAAF;
	_unit moveInGunner _veh;
	_soldados pushBack _unit;
	_vehiculos pushBack _veh;
	_grupos pushBack _grupo;
	sleep 1;

	// create the AT group
	private _grupo = [_posicion, side_red, [infTeamATAA, "AAF"] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
	[leader _grupo, _location, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] execVM "scripts\UPSMON.sqf";
	{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
	_grupos pushBack _grupo;

	[_location, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};


private _fnc_run = {
	params ["_location"];
	private _posicion = _location call AS_fnc_location_position;
	private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

	private _fnc_isDestroyed = {
		({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)
	};

	waitUntil {sleep 1;
		!(_location call AS_fnc_location_spawned) or (call _fnc_isDestroyed)
	};

	if (call _fnc_isDestroyed) then {
		[-5,0,_posicion] remoteExec ["citySupportChange",2];
		[["TaskSucceeded", ["", "Outpost Cleansed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		[_location,"side","FIA"] call AS_fnc_location_set;
		[[_posicion], "patrolCA"] remoteExec ["AS_scheduler_fnc_execute", 2];
		["cl_loc"] remoteExec ["fnc_BE_XP", 2];
	};
};

AS_spawn_createAAFhill_states = ["spawn", "run", "clean"];
AS_spawn_createAAFhill_state_functions = [
	_fnc_spawn,
	_fnc_run,
	AS_spawn_fnc_AAFlocation_clean
];
