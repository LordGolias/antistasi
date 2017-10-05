private _fnc_initialize = {
	params ["_mission"];
	private _origin = [_mission, "origin"] call AS_mission_fnc_get;
	private _destination = [_mission, "destination"] call AS_mission_fnc_get;

	private _destPos = _destination call AS_location_fnc_position;
	private _origname = format ["the %1 Carrier", AS_NATOname];
	if (_origin != "spawnNATO") then {
		_origname = [_origin] call AS_fnc_location_name;
	};

	private _tskTitle = AS_NATOname + " Attack";
	private _tskDesc = format ["Our Commander asked %1 for an attack on %2. Help them in order to have success in this operation. The attack will depart from %3 and will include artillery fire.",
		AS_NATOname,
		[_destination] call AS_fnc_location_name,
		_origname];

	[_mission, [_tskDesc,_tskTitle, _destination], _destPos, "Attack"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _support = [_mission, "NATOsupport"] call AS_mission_fnc_get;
	private _origin = [_mission, "origin"] call AS_mission_fnc_get;
	private _destination = [_mission, "destination"] call AS_mission_fnc_get;
	private _destPos = _destination call AS_location_fnc_position;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _groups = [];
	private _vehicles = [];

	private _threatEval = [_destPos] call AS_fnc_getAirThreat;

	private _origPos = getMarkerPos "spawnNATO";
	private _isAirfield = true;
	if (_origin != "spawnNATO") then {
		_origPos = _origin call AS_location_fnc_position;
		[_destination] spawn AS_fnc_dropArtilleryShellsNATO;
		if (_origin call AS_location_fnc_type != "airfield") then {
			_isAirfield = false;
		}
	};

	private _group_count = round(_support/20) min 4;
	for "_i" from 1 to _group_count do {
		private _tipoveh = bluHeliTrans call BIS_fnc_selectRandom;
		private _vehicle = [_origPos, 0, _tipoveh, side_blue] call bis_fnc_spawnvehicle;
		private _heli = _vehicle select 0;
		private _heliCrew = _vehicle select 1;
		private _groupheli = _vehicle select 2;
		{[_x] spawn AS_fnc_initUnitNATO} forEach _heliCrew;
		[_heli, "NATO"] call AS_fnc_initVehicle;
		_groups pushBack _groupheli;
		_vehicles pushBack _heli;

		{_x setBehaviour "CARELESS";} forEach units _groupheli;
		[_heli,"NATO Air Transport"] spawn AS_fnc_setConvoyImmune;

		if (_tipoveh in (["NATO", "helis_airdrop"] call AS_fnc_getEntity)) then {
			private _tipoGrupo = [bluSquadWeapons, "NATO"] call AS_fnc_pickGroup;
			private _group = [_origPos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] spawn AS_fnc_initUnitNATO} forEach units _group;
			_groups pushBack _group;
			if (_isAirfield or (random 10 < _threatEval)) then {
				[_heli, _group, _destPos, _threatEval] spawn AS_fnc_activateAirdrop;
			} else {
				if ((_destination call AS_location_fnc_type) in ["base","watchpost"]) then {
					[_groupheli, _origPos, _destPos, _destination, [_group], 25*60] call AS_QRF_fnc_fastrope;
				};
				if ((_destination call AS_location_fnc_type) in ["resource","factory", "powerplant"]) then {
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _groupheli;
					private _landpos = [];
					_landpos = [_destPos, 0, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
					_vehicles = _vehicles + [_pad];
					private _wp0 = _groupheli addWaypoint [_landpos, 0];
					_wp0 setWaypointType "TR UNLOAD";
					_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call AS_AI_fnc_activateSmokeCover"];
					[_groupheli,0] setWaypointBehaviour "CARELESS";
					private _wp3 = _group addWaypoint [_landpos, 0];
					_wp3 setWaypointType "GETOUT";
					_wp0 synchronizeWaypoint [_wp3];
					private _wp4 = _group addWaypoint [_destPos, 1];
					_wp4 setWaypointType "SAD";
					private _wp2 = _groupheli addWaypoint [_origPos, 1];
					_wp2 setWaypointType "MOVE";
					_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
					[_groupheli,1] setWaypointBehaviour "AWARE";
					[_heli,true] spawn AS_fnc_toggleVehicleDoors;
				};
			};
		};
		if (_tipoveh in (["NATO", "helis_land"] call AS_fnc_getEntity)) then {
			{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _groupheli;
			private _tipoGrupo = [bluTeam, "NATO"] call AS_fnc_pickGroup;
			private _group = [_origPos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] call AS_fnc_initUnitNATO} forEach units _group;
			_groups pushBack _group;
			private _landpos = [];
			_landpos = [_destPos, 0, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
			_landPos set [2, 0];
			private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
			_vehicles pushBack _pad;
			private _wp0 = _groupheli addWaypoint [_landpos, 0];
			_wp0 setWaypointType "TR UNLOAD";
			_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call AS_AI_fnc_activateSmokeCover"];
			[_groupheli,0] setWaypointBehaviour "CARELESS";
			private _wp3 = _group addWaypoint [_landpos, 0];
			_wp3 setWaypointType "GETOUT";
			_wp0 synchronizeWaypoint [_wp3];
			private _wp4 = _group addWaypoint [_destPos, 1];
			_wp4 setWaypointType "SAD";
			private _wp2 = _groupheli addWaypoint [_origPos, 1];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
			[_groupheli,1] setWaypointBehaviour "AWARE";
			[_heli,true] spawn AS_fnc_toggleVehicleDoors;
		};
		if (_tipoveh in (["NATO", "helis_fastrope"] call AS_fnc_getEntity)) then {
			{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _groupheli;
			private _tipoGrupo = [bluSquad, "NATO"] call AS_fnc_pickGroup;
			private _group = [_origPos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] call AS_fnc_initUnitNATO} forEach units _group;
			_groups pushBack _group;
			if ((_destination call AS_location_fnc_type) in ["airfield","base", "watchpost"] or (random 10 < _threatEval)) then {
				[_heli,_group,_destPos,_threatEval] spawn AS_fnc_activateAirdrop;
			} else {
				private _landpos = [];
				_landpos = [_destPos, 0, 300, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
				_landPos set [2, 0];
				private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
				_vehicles = _vehicles + [_pad];
				private _wp0 = _groupheli addWaypoint [_landpos, 0];
				_wp0 setWaypointType "TR UNLOAD";
				_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call AS_AI_fnc_activateSmokeCover"];
				[_groupheli,0] setWaypointBehaviour "CARELESS";
				private _wp3 = _group addWaypoint [_landpos, 0];
				_wp3 setWaypointType "GETOUT";
				_wp0 synchronizeWaypoint [_wp3];
				private _wp4 = _group addWaypoint [_destPos, 1];
				_wp4 setWaypointType "SAD";
				private _wp2 = _groupheli addWaypoint [_origPos, 1];
				_wp2 setWaypointType "MOVE";
				_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
				[_groupheli,1] setWaypointBehaviour "AWARE";
				[_heli,true] spawn AS_fnc_toggleVehicleDoors;
			};
		};
		sleep 1;
	};
	[_mission, "resources", [_task, _groups, _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _groups = (([_mission, "resources"] call AS_spawn_fnc_get) select 1);
	private _destination = [_mission, "destination"] call AS_mission_fnc_get;

	private _soldiers = [];
	{
		_soldiers append (units _x);
	} forEach _groups;

	private _fnc_missionFailedCondition = {
		({not alive _x or fleeing _x or captive _x} count _soldiers) >= 3./4*(count _soldiers)
	};
	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
	private _fnc_missionSuccessfulCondition = {_destination call AS_location_fnc_side == "FIA"};
	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_natoAttack_states = ["initialize", "spawn", "run", "clean"];
AS_mission_natoAttack_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
