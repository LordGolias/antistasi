private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = format [localize "STR_tskDesc_DesHeli", [_location] call AS_fnc_location_name];

	private _posHQ = getMarkerPos "FIA_HQ";

	private _poscrash = [0,0,0];
	while {surfaceIsWater _poscrash or (_poscrash distance _posHQ) < 4000} do {
		sleep 0.1;
		_poscrash = [_position, 5000, random 360] call BIS_fnc_relPos;
	};

	private _category = [
		["planes", "armedHelis", "transportHelis"],
		["planes" call AS_AAFarsenal_fnc_count,
		 "armedHelis" call AS_AAFarsenal_fnc_count,
		 "transportHelis" call AS_AAFarsenal_fnc_count]
		] call BIS_fnc_selectRandomWeighted;
	private _vehicleType = selectRandom (_category call AS_AAFarsenal_fnc_valid);

	private _posCrashMrk = [_poscrash,random 500,random 360] call BIS_fnc_relPos;
	_posCrash = _poscrash findEmptyPosition [0,100,_vehicleType];
	private _mrk = createMarker [format ["DES%1", random 100], _posCrashMrk];
	_mrk setMarkerShape "ICON";

	[_mission, "vehicleType", _vehicleType] call AS_spawn_fnc_set;
	[_mission, "crashPosition", _posCrash] call AS_spawn_fnc_set;
	[_mission, "resources", [taskNull, [], [], [_mrk]]] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_mrk], _position, "Destroy"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _crashPosition = [_mission, "crashPosition"] call AS_spawn_fnc_get;
	private _vehicleType = [_mission, "vehicleType"] call AS_spawn_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _vehicles = [];
	private _groups = [];

	private _crater = createVehicle ["CraterLong", _crashPosition, [], 0, "CAN_COLLIDE"];
	private _heli = createVehicle [_vehicleType, _crashPosition, [], 0, "CAN_COLLIDE"];
	_heli attachTo [_crater,[0,0,1.5]];
	private _smoke = "test_EmptyObjectForSmoke" createVehicle _crashPosition;
	_smoke attachTo [_heli,[0,1.5,-1]];
	_heli setDamage 0.9;
	_heli lock 2;
	_vehicles append [_heli, _crater, _smoke];

	private _grpcrash = createGroup side_red;
	_groups pushBack _grpcrash;

	private _unit = ([_crashPosition, 0, ["AAF", "pilot"] call AS_fnc_getEntity, _grpcrash] call bis_fnc_spawnvehicle) select 0;
	_unit setDamage 1;
	_unit moveInDriver _heli;

	private _tam = 100;
	private _roads = [];
	while {count _roads == 0} do {
		_roads = _position nearRoads _tam;
		_tam = _tam + 50;
	};
	private _road = _roads select 0;

	private _recoveryVehicleype = selectRandom ("apcs" call AS_AAFarsenal_fnc_valid);
	private _vehicle = [position _road, 0,_recoveryVehicleype, side_red] call bis_fnc_spawnvehicle;
	private _veh = _vehicle select 0;
	[_veh, "AAF"] call AS_fnc_initVehicle;
	[_veh,"AAF Escort"] spawn AS_fnc_setConvoyImmune;
	private _protectionGroup = _vehicle select 2;
	{[_x] spawn AS_fnc_initUnitAAF} forEach units _protectionGroup;
	_groups pushBack _protectionGroup;
	_vehicles pushBack _veh;

	sleep 1;

	// spawn patrol going there
	private _tipoGrupo = [["AAF", "patrols"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
	private _grupo = [_position, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;

	{
		_x assignAsCargo _veh;
		_x moveInCargo _veh;
		[_x] join _protectionGroup;
		[_x] spawn AS_fnc_initUnitAAF
	} forEach units _grupo;
	deleteGroup _grupo;
	[_veh] spawn AS_AI_fnc_activateUnloadUnderSmoke;

	private _Vwp0 = _protectionGroup addWaypoint [_position, 0];
	_Vwp0 setWaypointType "TR UNLOAD";
	_Vwp0 setWaypointBehaviour "SAFE";
	private _Gwp0 = _grupo addWaypoint [_position, 0];
	_Gwp0 setWaypointType "GETOUT";
	_Vwp0 synchronizeWaypoint [_Gwp0];

	// spawn repair truck going there
	private _vehicleT = [position _road, 0, selectRandom (["AAF", "repairVehicles"] call AS_fnc_getEntity), side_red] call bis_fnc_spawnvehicle;
	private _recoveryVehicle = _vehicleT select 0;
	[_recoveryVehicle, "AAF"] call AS_fnc_initVehicle;
	[_recoveryVehicle,"AAF Recover Truck"] spawn AS_fnc_setConvoyImmune;
	private _recoveryGroup = _vehicleT select 2;
	{[_x] spawn AS_fnc_initUnitAAF} forEach units _recoveryGroup;

	_groups  pushBack _recoveryGroup;
	_vehicles pushBack _recoveryVehicle;

	_Vwp0 = _recoveryGroup addWaypoint [_crashPosition, 0];
	_Vwp0 setWaypointType "MOVE";
	_Vwp0 setWaypointBehaviour "SAFE";

	private _markers = (([_mission, "resources"] call AS_spawn_fnc_get) select 3);
	[_mission, "resources", [_task, _groups, _vehicles, _markers]] call AS_spawn_fnc_set;
	[_mission, "target", _heli] call AS_spawn_fnc_set;
	[_mission, "recoverTruck", _recoveryVehicle] call AS_spawn_fnc_set;
	[_mission, "recoveryGroup", _recoveryGroup] call AS_spawn_fnc_set;
	[_mission, "protectionGroup", _protectionGroup] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _crashPosition = [_mission, "crashPosition"] call AS_spawn_fnc_get;
	private _heli = [_mission, "target"] call AS_spawn_fnc_get;
	private _recoveryVehicle = [_mission, "recoverTruck"] call AS_spawn_fnc_set;
	private _recoveryGroup = [_mission, "recoveryGroup"] call AS_spawn_fnc_set;
	private _protectionGroup = [_mission, "protectionGroup"] call AS_spawn_fnc_set;

	private _fnc_missionFailedCondition = {_recoveryVehicle distance _crashPosition < 50};

	private _fnc_missionFailed = {
		_recoveryVehicle doMove position _heli;

		private _Vwp0 = _recoveryGroup addWaypoint [_crashPosition, 1];
		_Vwp0 setWaypointType "MOVE";
		_Vwp0 setWaypointBehaviour "SAFE";

		_Vwp0 = _protectionGroup addWaypoint [_crashPosition, 0];
		_Vwp0 setWaypointType "LOAD";
		_Vwp0 setWaypointBehaviour "SAFE";

		_Vwp0 = _protectionGroup addWaypoint [_position, 2];
		_Vwp0 setWaypointType "MOVE";
		_Vwp0 setWaypointBehaviour "SAFE";

		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};

	private _fnc_missionSuccessfulCondition = {not alive _heli};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission, getPos _heli] remoteExec ["AS_mission_fnc_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_destroyHelicopter_states = ["initialize", "spawn", "run", "clean"];
AS_mission_destroyHelicopter_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
