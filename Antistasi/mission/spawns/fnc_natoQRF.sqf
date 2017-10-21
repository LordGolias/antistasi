private _fnc_initialize = {
	params ["_mission"];
	private _origin = [_mission, "origin"] call AS_mission_fnc_get;
	private _destPos = [_mission, "destinationPos"] call AS_mission_fnc_get;

	private _posOrig = _origin call AS_location_fnc_position;

	// marker on the map, required for the UPS script
	private _mrk = createMarker ["NATOQRF", _destPos];
	_mrk setMarkerShape "ICON";
	_mrk setMarkerType "b_support";
	_mrk setMarkerText ((["NATO", "name"] call AS_fnc_getEntity) + " QRF");

	private _tiempolim = 30;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = ((["NATO", "name"] call AS_fnc_getEntity) + " QRF");
	private _tskDesc = format ["Our Commander asked %1 for reinforcements near %2. Their troops will depart from %3.",
		(["NATO", "name"] call AS_fnc_getEntity),
		[_destPos call AS_location_fnc_nearest] call AS_fnc_location_name,
		[_origin] call AS_fnc_location_name];

	[_mission, [_tskDesc,_tskTitle,_mrk], _destPos, "Move"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "resources", [taskNull, [], [], [_mrk]]] call AS_spawn_fnc_set;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
	params ["_mission"];
	private _origin = [_mission, "origin"] call AS_mission_fnc_get;
	private _posOrig = _origin call AS_location_fnc_position;
	private _destPos = [_mission, "destinationPos"] call AS_mission_fnc_get;
	private _mrk = (([_mission, "resources"] call AS_spawn_fnc_get) select 3) select 0;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	// arrays of all spawned units/groups
	private _groups = [];
	private _vehicles = [];

	// first chopper
	private _vehicle = [_posOrig, 0, selectRandom bluHeliArmed, side_blue] call bis_fnc_spawnvehicle;
	private _heli1 = _vehicle select 0;
	private _heliCrew1 = _vehicle select 1;
	private _grpVeh1 = _vehicle select 2;
	{[_x] spawn AS_fnc_initUnitNATO} forEach _heliCrew1;
	[_heli1, "NATO"] call AS_fnc_initVehicle;
	_groups pushBack _grpVeh1;
	_vehicles pushBack _heli1;

	// spawn loiter script for armed escort
	[_posOrig, _destPos, _grpVeh1] spawn AS_tactics_fnc_heli_attack;

	sleep 5;

	// shift the spawn position of second chopper to avoid crash
	private _pos2 = _posOrig;
	_pos2 set [0, (_posOrig select 0) + 30];
	_pos2 set [2, (_posOrig select 2) + 50];

	// spawn transport
	private _tipoveh = selectRandom (["NATO", "helis_transport"] call AS_fnc_getEntity);
	([_pos2, 0, _tipoveh, side_blue] call bis_fnc_spawnvehicle) params ["_heli2", "_heliCrew2", "_grpVeh2"];
	{
		[_x] spawn AS_fnc_initUnitNATO;
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x setBehaviour "CARELESS";
	} forEach _heliCrew2;
	[_heli2, "NATO"] call AS_fnc_initVehicle;
	_groups pushBack _grpVeh2;
	_vehicles pushBack _heli2;

	// initialize group
	private _groupType = [["NATO", "recon_squad"] call AS_fnc_getEntity, "NATO"] call AS_fnc_pickGroup;
	private _grpDis2 = createGroup side_blue;
	[_groupType call AS_fnc_groupCfgToComposition, _grpDis2, _pos2, _heli2 call AS_fnc_availableSeats] call AS_fnc_createGroup;
	{
		_x assignAsCargo _heli2;
		_x moveInCargo _heli2;
		[_x] call AS_fnc_initUnitNATO;
	} forEach units _grpDis2;
	_groups pushBack _grpDis2;

	// spawn dismount script
	_vehicles append ([_grpVeh2, _posOrig, _destPos, _mrk, _grpDis2] call AS_tactics_fnc_heli_disembark);

	[_mission, "resources", [_task, _groups, _vehicles, [_mrk]]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _groups = (([_mission, "resources"] call AS_spawn_fnc_get) select 1);
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _soldiers = [];
	{
		_soldiers append (units _x);
	} forEach _groups;

	// 3/4 of all soldiers die or timer runs out
	waitUntil {sleep 10; (dateToNumber date > _max_date) or {{alive _x} count _soldiers < (count _soldiers)/4}};

	if (dateToNumber date > _max_date) then {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
};

AS_mission_natoQRF_states = ["initialize", "spawn", "run", "clean"];
AS_mission_natoQRF_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
