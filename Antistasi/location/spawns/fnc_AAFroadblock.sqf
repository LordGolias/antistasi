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

	private _static_mg = ["AAF", "static_mg"] call AS_fnc_getEntity;
	private _gunner = ["AAF", "gunner"] call AS_fnc_getEntity;
	private _vehicles = ["AAF", "apcs"] call AS_fnc_getEntity;

	private _veh = _static_mg createVehicle _posicion;
	_veh setPosATL (getPosATL _bunker);
	_veh setDir _dirVeh;
	_vehiculos pushBack _veh;

	private _grupoE = createGroup ("AAF" call AS_fnc_getFactionSide);  // temp group

	private _unit = ([_posicion, 0, _gunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _veh;
	sleep 1;

	// create bunker on the other side
	private _pos = [getPos _road, 7, _dirveh + 90] call BIS_Fnc_relPos;
	private _bunker = "Land_BagBunker_Small_F" createVehicle _pos;
	_vehiculos pushBack _bunker;
	_bunker setDir _dirveh + 180;

	_pos = getPosATL _bunker;
	private _veh = _static_mg createVehicle _posicion;
	_veh setPosATL _pos;
	_veh setDir _dirVeh;
	_vehiculos pushBack _veh;

	_unit = ([_posicion, 0, _gunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _veh;
	
	// Create random vehicle guarding checkpoint
	if (random 10 < 2) then {
		private _pos = [getPos _road, 40, _dirveh + 90] call BIS_Fnc_relPos;
		private _vehicle = selectRandom _vehicles;
		private _vehicleObject = _vehicle createVehicle _pos;
		_vehiculos pushBack _vehicleObject;
		_vehicleObject setDir _dirveh + 180;
		_unit = ([_posicion, 0, _gunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _vehicleObject;
	};

	// Create flag
	_pos = [getPos _bunker, 6, getDir _bunker] call BIS_fnc_relPos;
	_veh = createVehicle [["AAF", "flag"] call AS_fnc_getEntity, _pos, [],0, "CAN_COLLIDE"];
	_vehiculos pushBack _veh;

	{[_x, "AAF"] call AS_fnc_initVehicle} forEach _vehiculos;

	// create the patrol group
	private _grupo = [_posicion, ("AAF" call AS_fnc_getFactionSide), [["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;
	{[_x] join _grupo} forEach units _grupoE;
	deleteGroup _grupoE;

	// add dog
	if (random 10 < 2.5) then {
		[_grupo] call AS_fnc_spawnDog;
	};
	{[_x, false] call AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;

	[leader _grupo, _location, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] spawn UPSMON;

	[_location, "resources", [taskNull, [_grupo], _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_location"];
	private _posicion = _location call AS_location_fnc_position;

	private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

	waitUntil {sleep 1;
		!(_location call AS_location_fnc_spawned) or
		{_x call AS_fnc_canFight} count _soldados == 0
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
