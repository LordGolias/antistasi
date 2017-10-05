private _fnc_initialize = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_mission_fnc_get;
	private _time = [_mission, "time"] call AS_mission_fnc_get;

	private _origin = [("FIA" call AS_location_fnc_S), AS_commander] call BIS_Fnc_nearestPosition;

	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + (30 max _time)];

	// this is a hidden marker used by the task and for the location
	private _mrk = createMarker [format ["NATOroadblock%1", random 1000], _position];
	_mrk setMarkerShape "ELLIPSE";
	_mrk setMarkerSize [50,50];
	_mrk setMarkerAlpha 0;

	private _tskTitle = (["NATO", "name"] call AS_fnc_getEntity) + " Roadblock Deployment";
	private _tskDesc = format [(["NATO", "name"] call AS_fnc_getEntity) + " is dispatching a team from %1 to establish a temporary Roadblock. Send and cover the team until reaches its destination.",
		[_origin] call AS_fnc_location_name];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "resources", [taskNull, [], [], [_mrk]]] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_mrk], _position, "Move"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_mission_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _tipoGrupo = [["NATO", "team"] call AS_fnc_getEntity, "NATO"] call AS_fnc_pickGroup;

	private _group = [_position, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
	_group setGroupId ["Watch"];
	AS_commander hcSetGroup [_group];
	_group setVariable ["isHCgroup", true, true];

	private _tam = 10;
	private _roads = [];
	while {count _roads == 0} do {
		_roads = _position nearRoads _tam;
		_tam = _tam + 10;
	};
	private _road = _roads select 0;

	private _tipoVeh = selectRandom (["NATO", "trucks"] call AS_fnc_getEntity);
	private _pos = position _road findEmptyPosition [1,30, _tipoVeh];
	private _transport = _tipoVeh createVehicle _pos;
	[_transport, "NATO"] call AS_fnc_initVehicle;
	_group addVehicle _transport;

	{
		_x assignAsCargo _transport;
		_x moveInCargo _transport;
		[_x] call AS_fnc_initUnitNATO
	} forEach units _group;
	leader _group setBehaviour "SAFE";

	private _markers = (([_mission, "resources"] call AS_spawn_fnc_get) select 3);
	[_mission, "resources", [_task, [_group], [_transport], _markers]] call AS_spawn_fnc_set;
};

private _fnc_wait_arrival = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_mission_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _group = (([_mission, "resources"] call AS_spawn_fnc_get) select 1) select 0;
	private _transport = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;

	waitUntil {sleep 1;
		({alive _x} count units _group == 0) or
		({(alive _x) and (_x distance _position < 10)} count units _group > 0) or
		(dateToNumber date > _max_date)
	};

	private _success = {(alive _x) and (_x distance _position < 10)} count units _group > 0;

	[_mission, "success", _success] call AS_spawn_fnc_set;

	if _success then {
		if (isPlayer leader _group) then {
			private _owner = (leader _group) getVariable ["owner",leader _group];
			(leader _group) remoteExec ["removeAllActions",leader _group];
			_owner remoteExec ["selectPlayer",leader _group];
			(leader _group) setVariable ["owner",_owner,true];
			{[_x] joinsilent group _owner} forEach units group _owner;
			[group _owner, _owner] remoteExec ["selectLeader", _owner];
			"" remoteExec ["hint",_owner];
			waitUntil {!(isPlayer leader _group)};
		};

		AS_commander hcRemoveGroup _group;
		{deleteVehicle _x} forEach units _group;
		deleteVehicle _transport;
		deleteGroup _group;
		sleep 1;

		private _mrk = (([_mission, "resources"] call AS_spawn_fnc_get) select 3) select 0;
		[_mrk,"roadblock"] call AS_location_fnc_add;
		[_mrk, "side", "NATO"] call AS_location_fnc_set;

		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
};

private _fnc_run = {
	params ["_mission"];
	private _success = [_mission, "success"] call AS_spawn_fnc_get;
	private _mrk = (([_mission, "resources"] call AS_spawn_fnc_get) select 3) select 0;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	if _success then {
		waitUntil {sleep 60; dateToNumber date > _max_date};
		_mrk call AS_location_fnc_remove;
	};
};

AS_mission_natoRoadblock_states = ["initialize", "spawn", "wait_arrival", "run", "clean"];
AS_mission_natoRoadblock_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait_arrival,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
