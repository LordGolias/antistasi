#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];
	private _vehiculos = [];
	private _soldados = [];

	private _posicion = _location call AS_location_fnc_position;

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

	private _grupoE = createGroup side_red;  // temp group

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
	private _grupo = [_posicion, side_red, [["AAF", "teamsAT"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;
	{[_x] join _grupo} forEach units _grupoE;
	([_posicion, 0, ["AAF", "medic"] call AS_fnc_getEntity, _grupo] call bis_fnc_spawnvehicle) select 0;
	_grupo selectLeader (units _grupo select 1);
	deleteGroup _grupoE;

	// add dog
	if (random 10 < 2.5) then {
		[_grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"]] spawn AS_AI_fnc_initDog;
	};

	[leader _grupo, _location, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] spawn UPSMON;

	{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;

	[_location, "resources", [taskNull, [_grupo], _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_location"];
	private _posicion = _location call AS_location_fnc_position;

	private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

	waitUntil {sleep 1;
		!(_location call AS_location_fnc_spawned) or
		{alive _x and !(fleeing _x)} count _soldados == 0
	};

	if (_location call AS_location_fnc_spawned) then {
		[-5,0,_posicion] remoteExec ["AS_fnc_changeCitySupport",2];
		[["TaskSucceeded", ["", "Roadblock Cleared"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		[[_posicion], "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];

		_location call AS_location_fnc_remove;
		["cl_loc"] remoteExec ["fnc_BE_XP", 2];
	};
};

AS_spawn_createAAFroadblock_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFroadblock_state_functions = [
	_fnc_spawn,
	_fnc_run,
	AS_location_spawn_fnc_AAFlocation_clean
];
