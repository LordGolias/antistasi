private _fnc_initialize = {
	params ["_mission"];
	private _origin = [_mission, "origin"] call AS_mission_fnc_get;
	private _destination = [_mission, "destination"] call AS_mission_fnc_get;

	private _destPos = _destination call AS_location_fnc_position;
	private _origname = format ["the %1 Carrier", (["NATO", "name"] call AS_fnc_getEntity)];
	if (_origin != "spawnNATO") then {
		_origname = [_origin] call AS_fnc_location_name;
	};

	private _tskTitle = (["NATO", "name"] call AS_fnc_getEntity) + " Attack";
	private _tskDesc = format ["Our Commander asked %1 for an attack on %2. Help them in order to have success in this operation. The attack will depart from %3 and will include artillery fire.",
		(["NATO", "name"] call AS_fnc_getEntity),
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
		// initialize helicopter
		private _method = selectRandom ["fastrope", "disembark", "paradrop"];
		private _tipoveh = selectRandom (["NATO", "helis_transport"] call AS_fnc_getEntity);
		([_origPos, 0, _tipoveh, ("NATO" call AS_fnc_getFactionSide)] call bis_fnc_spawnvehicle) params ["_heli", "_heliCrew", "_groupheli"];
		{
			[_x] spawn AS_fnc_initUnitNATO;
			_x disableAI "TARGET";
			_x disableAI "AUTOTARGET";
			_x setBehaviour "CARELESS";
		} forEach _heliCrew;
		[_heli, "NATO"] call AS_fnc_initVehicle;
		_groups pushBack _groupheli;
		_vehicles pushBack _heli;
		[_heli,"NATO Air Transport"] spawn AS_fnc_setConvoyImmune;

		// initialize group
		private _groupType = [["NATO", "squads"] call AS_fnc_getEntity, "NATO"] call AS_fnc_pickGroup;
		private _group = createGroup ("NATO" call AS_fnc_getFactionSide);
		[_groupType call AS_fnc_groupCfgToComposition, _group, _origPos, _heli call AS_fnc_availableSeats] call AS_fnc_createGroup;
		{
			_x assignAsCargo _heli;
			_x moveInCargo _heli;
			[_x] call AS_fnc_initUnitNATO;
		} forEach units _group;
		_groups pushBack _group;

		if (_method == "paradrop") then {
			if (_isAirfield or (random 10 < _threatEval)) then {
				[_origPos, _destPos, _groupheli, _destination, _group, _threatEval] call AS_tactics_fnc_heli_paradrop;
			} else {
				if ((_destination call AS_location_fnc_type) in ["base","watchpost"]) then {
					[_origPos, _destPos, _groupheli, _destination, _group, _threatEval] call AS_tactics_fnc_heli_fastrope;
				};
				if ((_destination call AS_location_fnc_type) in ["resource","factory", "powerplant"]) then {
					_vehicles append ([_origPos, _destPos, _groupheli, _destination, _group, _threatEval] call AS_tactics_fnc_heli_disembark);
				};
			};
		};
		if (_method == "disembark") then {
			_vehicles append ([_origPos, _destPos, _groupheli, _destination, _group, _threatEval] call AS_tactics_fnc_heli_disembark);
		};
		if (_method == "fastrope") then {
			if ((_destination call AS_location_fnc_type) in ["airfield","base", "watchpost"] or (random 10 < _threatEval)) then {
				[_origPos, _destPos, _groupheli, _destination, _group, _threatEval] call AS_tactics_fnc_heli_paradrop;
			} else {
				[_origPos, _destPos, _groupheli, _destination, _group, _threatEval] call AS_tactics_fnc_heli_fastrope;
			};
		};
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
