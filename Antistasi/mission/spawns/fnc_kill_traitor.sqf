private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;

	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	// select house with more than 3 positions
	private _casas = nearestObjects [_position, ["house"], _size];
	private _poscasa = [];
	private _casa = objNull;
	while {count _poscasa < 3} do {
		_casa = _casas call BIS_Fnc_selectRandom;
		_poscasa = [_casa] call BIS_fnc_buildingPositions;
		if (count _poscasa < 3) then {
			_casas = _casas - [_casa]
		};
	};

	private _posTsk = (position _casa) getPos [random 100, random 360];
	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = format [localize "STR_tskDesc_ASSTraitor",
		[_location] call AS_fnc_location_name,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4
	];

	[_mission, "house", _casa] call AS_spawn_fnc_set;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _posTsk, "Kill"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _casa = [_mission, "house"] call AS_spawn_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _poscasa = [_casa] call BIS_fnc_buildingPositions;

	private _max = (count _poscasa) - 1;
	private _rnd = floor random _max;
	private _postraidor = _poscasa select _rnd;
	private _posSol1 = _poscasa select (_rnd + 1);
	private _posSol2 = (_casa buildingExit 0);

	private _grptraidor = createGroup side_red;

	private _target = ([_postraidor, 0, ["CSAT", "traitor"] call AS_fnc_getEntity, _grptraidor] call bis_fnc_spawnvehicle) select 0;
	_target allowDamage false;
	([_posSol1, 0, ["CSAT", "officer"] call AS_fnc_getEntity, _grptraidor] call bis_fnc_spawnvehicle) select 0;
	([_posSol2, 0, ["CSAT", "officer"] call AS_fnc_getEntity, _grptraidor] call bis_fnc_spawnvehicle) select 0;
	_grptraidor selectLeader _target;

	{_x call AS_fnc_initUnitCSAT; _x allowFleeing 0} forEach units _grptraidor;
	private _posVeh = [];
	private _dirVeh = 0;
	private _roads = [];
	private _radius = 20;
	while {count _roads == 0} do {
		_roads = (getPos _casa) nearRoads _radius;
		_radius = _radius + 10;
	};
	private _road = _roads select 0;

	private _roadcon = roadsConnectedto _road;
	private _posroad = getPos _road;
	private _posrel = getPos (_roadcon select 0);
	private _dirveh = [_posroad,_posrel] call BIS_fnc_DirTo;
	_posVeh = [_posroad, 3, _dirveh + 90] call BIS_Fnc_relPos;

	private _veh = (selectRandom (["CSAT", "cars_transport"] call AS_fnc_getEntity)) createVehicle _posVeh;
	_veh allowDamage false;
	_veh setDir _dirVeh;
	_veh allowDamage true;
	_target allowDamage true;
	[_veh, "CSAT"] call AS_fnc_initVehicle;
	{_x disableAI "MOVE"; _x setUnitPos "UP"} forEach units _grptraidor;

	private _mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], getPos _casa];
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [50,50];
	_mrk setMarkerTypeLocal "hd_warning";
	_mrk setMarkerColorLocal "ColorRed";
	_mrk setMarkerBrushLocal "DiagGrid";
	_mrk setMarkerAlphaLocal 0;

	private _tipoGrupo = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
	private _grupo = [_position, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
	if (random 10 < 2.5) then {
		private _perro = _grupo createUnit ["Fin_random_F",_position,[],0,"FORM"];
		[_perro] spawn AS_AI_fnc_initDog;
	};
	[leader _grupo, _mrk, "SAFE","SPAWNED", "NOVEH2", "NOFOLLOW"] spawn UPSMON;
	{[_x, false] spawn AS_fnc_initUnitAAF} forEach units _grupo;

	[_mission, "target", _target] call AS_spawn_fnc_set;
	[_mission, "getAwayVehicle", _veh] call AS_spawn_fnc_set;
	[_mission, "resources", [_task, [_grupo, _grptraidor], [_veh], [_mrk]]] call AS_spawn_fnc_set;
};

private _fnc_wait = {
	params ["_mission"];
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _target = [_mission, "target"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	private _fnc_missionSuccessfulCondition = {not alive _target};

	waitUntil {sleep 5; ({_target knowsAbout _x > 1.4} count ([500, _target, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0) or _fnc_missionFailedCondition or _fnc_missionSuccessfulCondition};
	if (call _fnc_missionFailedCondition) exitWith {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_mission_fnc_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	};
	if (call _fnc_missionSuccessfulCondition) exitWith {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_mission_fnc_success", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	};
	([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _target = [_mission, "target"] call AS_spawn_fnc_get;
	private _getAwayVeh = [_mission, "getAwayVehicle"] call AS_spawn_fnc_get;
	// traitor tries to escape
	private _arraybases = ["base", "AAF"] call AS_location_fnc_TS;
	private _base = [_arraybases, _position] call BIS_Fnc_nearestPosition;
	private _posBase = _base call AS_location_fnc_position;

	{_x enableAI "MOVE"} forEach units group _target;
	_target assignAsDriver _getAwayVeh;
	[_target] orderGetin true;
	private _wp0 = (group _target) addWaypoint [position _getAwayVeh, 0];
	_wp0 setWaypointType "GETIN";
	private _wp1 = (group _target) addWaypoint [_posBase,1];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointBehaviour "CARELESS";
	_wp1 setWaypointSpeed "FULL";

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_mission_fnc_fail", 2];
	};

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date or _target distance _posBase < 100};

	private _fnc_missionSuccessfulCondition = {not alive _target};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_mission_fnc_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_killTraitor_states = ["initialize", "spawn", "run", "clean"];
AS_mission_killTraitor_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
