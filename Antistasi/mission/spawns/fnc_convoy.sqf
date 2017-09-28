#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _missionType = _mission call AS_mission_fnc_type;

	private _origin = [_position] call AS_fnc_getBasesForConvoy;
	if (_origin == "") exitWith {
		hint "mission is no longer available";
		_mission call AS_mission_fnc_remove;

		[_mission, "state_index", 100] call AS_spawn_fnc_set; // terminate everything
	};

	private _tiempolim = 120;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = "";
	private _tskIcon = "";
	private _mainVehicleType = "";
	call {
		if (_missionType == "convoy_money") exitWith {
			_tskDesc = localize "STR_tskDesc_CVY_Money";
			_tskIcon = "move";
			_mainVehicleType = selectRandom AS_FIA_vans;
		};
		if (_missionType == "convoy_supplies") exitWith {
			_tskDesc = localize "STR_tskDesc_CVY_Supply";
			_tskIcon = "heal";
			_mainVehicleType = selectRandom AS_FIA_vans;
		};
		if (_missionType == "convoy_armor") exitWith {
			_tskDesc = localize "STR_tskDesc_CVY_Armor";
			_tskIcon = "destroy";
			private _type = "tanks";
			if (_type call AS_AAFarsenal_fnc_count == 0) then {
				_type = "apcs";
				diag_log format ["[AS] Error: convoy: tanks requested but not available", _mission];
			};
			_mainVehicleType = selectRandom (_type call AS_AAFarsenal_fnc_valid);
		};
		if (_missionType == "convoy_ammo") exitWith {
			_tskDesc = localize "STR_tskDesc_CVY_Ammo";
			_tskIcon = "rearm";
			if ("supplies" call AS_AAFarsenal_fnc_count == 0) then {
				diag_log format ["[AS] Error: convoy: supplies requested but not available", _mission];
			};
			_mainVehicleType = vehAmmo;
		};
		if (_missionType == "convoy_hvt") exitWith {
			_tskDesc = localize "STR_tskDesc_CVY_HVT";
			_tskIcon = "destroy";
		};
		if (_missionType == "convoy_prisoners") exitWith {
			_tskDesc = localize "STR_tskDesc_CVY_Pris";
			_tskIcon = "run";
			_mainVehicleType = selectRandom ("trucks" call AS_AAFarsenal_fnc_valid);
			if ("trucks" call AS_AAFarsenal_fnc_count == 0) then {
				diag_log format ["[AS] Error: convoy: truck requested but not available", _mission];
			};
		};
	};

	_tskDesc = format [_tskDesc,
		[_origin] call AS_fnc_location_name, _origin,
		[_location] call AS_fnc_location_name, _location];
	_tskTitle = format [_tskTitle, A3_STR_INDEP];

	[_mission, "origin", _origin] call AS_spawn_fnc_set;
	[_mission, "mainVehicleType", _mainVehicleType] call AS_spawn_fnc_set;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, _tskIcon] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _missionType = _mission call AS_mission_fnc_type;
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _origin = [_mission, "origin"] call AS_spawn_fnc_get;
	private _posbase = _origin call AS_location_fnc_position;
	private _mainVehicleType = [_mission, "mainVehicleType"] call AS_spawn_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _groups = [];
	private _vehicles = [];

	// particular to specific missions. They do not need to be cleaned.
	private _grpPOW = grpNull;
	private _POWs = [];
	private _hvt = objNull;

	[_origin,30] call AS_location_fnc_increaseBusy;

	private _group = createGroup side_red;
	_groups pushBack _group;

	([_posbase, _position] call AS_fnc_findSpawnSpots) params ["_posRoad", "_dir"];

	// initialisation of vehicles
	private _initVehs = {
		params ["_specs"];
		_specs = _specs + [_dir, _group, _vehicles, _groups, [], true];
		_specs call AS_fnc_spawnRedVehicle;
	};

	private _escortSize = 1;
	if ([_location] call AS_fnc_location_isFrontline) then {_escortSize = (round random 2) + 1};

	// spawn escorts
	for "_i" from 1 to _escortSize do {
		private _category = [
			["trucks", "apcs"],
			["trucks" call AS_AAFarsenal_fnc_count,
			 "apcs" call AS_AAFarsenal_fnc_count]
			] call BIS_fnc_selectRandomWeighted;
		private _escortVehicleType = selectRandom (_category call AS_AAFarsenal_fnc_valid);

		private _vehData = [[_posRoad, _escortVehicleType]] call _initVehs;
		_vehicles = _vehData select 0;
		_groups = _vehData select 1;

		private _veh = (_vehData select 3) select 0;
		[_veh,"AAF Convoy Escort"] spawn AS_fnc_setConvoyImmune;

		private _tipoGrupo = "";
		if (_escortVehicleType call AS_AAFarsenal_fnc_category == "apcs") then {
			_tipoGrupo = [infTeam, "AAF"] call AS_fnc_pickGroup;
		} else {
			_tipoGrupo = [infSquad, "AAF"] call AS_fnc_pickGroup;
		};

		private _grupoEsc = [_posbase, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{[_x] call AS_fnc_initUnitAAF;_x assignAsCargo _veh;_x moveInCargo _veh; [_x] join _group} forEach units _grupoEsc;
		deleteGroup _grupoEsc;
	};

	private _mainVehicle = _mainVehicleType createVehicle _posRoad;
	_vehicles pushBack _mainVehicle;
	_mainVehicle setDir _dir;

	private _driver = ([_posbase, 0, sol_DRV, _group] call bis_fnc_spawnvehicle) select 0;
	_driver assignAsDriver _mainVehicle;
	_driver moveInDriver _mainVehicle;
	[_driver] call AS_fnc_initUnitAAF;
	_driver addEventHandler ["killed", {
		{
			_x action ["EJECT", _mainVehicle];
			unassignVehicle _x;
		} forEach crew _mainVehicle;
	}];

	if (_missionType == "convoy_hvt") then {
		_hvt = ([_posbase, 0, sol_OFF, _group] call bis_fnc_spawnvehicle) select 0;
		[_hvt] spawn AS_fnc_initUnitAAF;
		_hvt assignAsCargo _mainVehicle;
		_hvt moveInCargo _mainVehicle;
		[_mission, "hvt", _hvt] call AS_spawn_fnc_set;
	};
	if (_missionType == "convoy_armor") then {
		_mainVehicle lock 3;
	};
	if (_missionType == "convoy_prisoners") then {
		_grpPOW = createGroup side_blue;
		_POWs = [];
		_groups pushBack _grpPOW;
		for "_i" from 1 to (1+ round (random 11)) do {
			private _unit = _grpPOW createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, _posbase, [], 0, "NONE"];
			_unit setCaptive true;
			_unit disableAI "MOVE";
			_unit setBehaviour "CARELESS";
			_unit allowFleeing 0;
			_unit assignAsCargo _mainVehicle;
			_unit moveInCargo [_mainVehicle, _i + 3]; // 3 because first 3 are in front
			removeAllWeapons _unit;
			removeAllAssignedItems _unit;
			[[_unit,"refugiado"],"AS_fnc_addAction"] call BIS_fnc_MP;
			_POWs pushBack _unit;
		};
		[_mission, "grpPOW", _grpPOW] call AS_spawn_fnc_set;
		[_mission, "POWs", _POWs] call AS_spawn_fnc_set;
	};
	if (_missionType in ["convoy_money", "convoy_supplies"]) then {
		AS_Sset("reportedVehs", AS_S("reportedVehs") + [_mainVehicle]);
	};

	// set everyone in motion
	private _wp0 = _group addWaypoint [_position, 0];
	_wp0 setWaypointType "MOVE";
	_wp0 setWaypointBehaviour "SAFE";
	_wp0 setWaypointSpeed "LIMITED";
	_wp0 setWaypointFormation "COLUMN";

	[_mission, "mainGroup", _group] call AS_spawn_fnc_set;
	[_mission, "mainVehicle", _mainVehicle] call AS_spawn_fnc_set;
	[_mission, "resources", [_task, _groups, _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _missionType = _mission call AS_mission_fnc_type;
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _mainVehicle = [_mission, "mainVehicle"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = call {
		if (_missionType in ["convoy_money", "convoy_armor", "convoy_ammo", "convoy_supplies"]) exitWith {
			{
				private _hasArrived = {(not (driver _mainVehicle getVariable ["BLUFORSpawn",false])) and
					{_mainVehicle distance _position < 100}};
				(dateToNumber date > _max_date) or _hasArrived
			}
		};
		if (_missionType == "convoy_hvt") exitWith {
			{
				private _hvt = [_mission, "hvt"] call AS_spawn_fnc_get;
				private _hasArrived = {_hvt distance _position < 100};

				(dateToNumber date > _max_date) or _hasArrived
			}
		};
		if (_missionType == "convoy_prisoners") exitWith {
			{
				private _hasArrived = {(not (driver _mainVehicle getVariable ["BLUFORSpawn",false])) and
					{_mainVehicle distance _position < 100}};
				private _POWs = [_mission, "POWs"] call AS_spawn_fnc_get;
				(dateToNumber date > _max_date) or _hasArrived or ({alive _x} count _POWs < ({alive _x} count _POWs)/2)
			}
		};
	};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		if (_missionType == "convoy_ammo") then {
			[_mainVehicle] call AS_fnc_emptyCrate;
		};
	};

	private _fnc_missionSuccessfulCondition = call {
		if (_missionType in ["convoy_money", "convoy_armor", "convoy_ammo", "convoy_supplies"]) exitWith {
			(not alive _mainVehicle) or {driver _mainVehicle getVariable ["BLUFORSpawn",false]}
		};
		if (_missionType == "convoy_armor") exitWith {
			{not alive _mainVehicle}
		};
		if (_missionType == "convoy_hvt") exitWith {
			private _hvt = [_mission, "hvt"] call AS_spawn_fnc_get;
			{not alive _hvt}
		};
		if (_missionType == "convoy_prisoners") exitWith {
			private _POWs = [_mission, "POWs"] call AS_spawn_fnc_get;
			{{(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _POWs >= ({alive _x} count _POWs) / 2}
		};
	};

	private _fnc_missionSuccessful = call {
		if (_missionType in ["convoy_money", "convoy_ammo", "convoy_supplies"]) exitWith {
			{
				private _fnc_missionFailedCondition = {not alive _mainVehicle or (dateToNumber date > _max_date)};
				private _fnc_missionFailed = {
					([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
					[-5000] remoteExec ["AS_fnc_changeAAFmoney",2];
					[1800] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
				};
				private _destination = getMarkerPos "FIA_HQ";
				if (_missionType == "convoy_supplies") then {
					_destination = _position;
				};

				private _fnc_missionSuccessfulCondition = {(_mainVehicle distance _destination < 50) and {speed _mainVehicle < 1}};
				private _fnc_missionSuccessful = {
					([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
					[_mission, getPos _mainVehicle] remoteExec ["AS_mission_fnc_success", 2];
				};
				[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
			}
		};
		if (_missionType == "convoy_armor") exitWith {
			{
				([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
				[_mission, getPos _mainVehicle] remoteExec ["AS_mission_fnc_success", 2];

				[position _mainVehicle] spawn AS_movement_fnc_sendAAFpatrol;
			}
		};
		if (_missionType == "convoy_hvt") exitWith {
			{
				private _hvt = [_mission, "hvt"] call AS_spawn_fnc_get;
				([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
				[_mission, getPos _mainVehicle] remoteExec ["AS_mission_fnc_success", 2];

				[position _hvt] spawn AS_movement_fnc_sendAAFpatrol;
			}
		};
		if (_missionType == "convoy_prisoners") exitWith {
			{
				private _POWs = [_mission, "POWs"] call AS_spawn_fnc_get;
				private _grpPOW = [_mission, "grpPOW"] call AS_spawn_fnc_get;
				[_mission,  getPos _mainVehicle, {alive _x} count _POWs] remoteExec ["AS_mission_fnc_success", 2];

				{[_x] join _grpPOW; [_x] orderGetin false} forEach _POWs;
			}
		};
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

private _fnc_clean = {
	params ["_mission"];
	private _mainVehicle = [_mission, "mainVehicle"] call AS_spawn_fnc_get;
	private _group = [_mission, "mainGroup"] call AS_spawn_fnc_get;
	private _origin = [_mission, "origin"] call AS_spawn_fnc_get;
	private _posbase = _origin call AS_location_fnc_position;

	private _wp0 = _group addWaypoint [_posbase, 0];
	_wp0 setWaypointType "MOVE";
	_wp0 setWaypointBehaviour "SAFE";
	_wp0 setWaypointSpeed "LIMITED";
	_wp0 setWaypointFormation "COLUMN";

	// before calling cleanResources
	if (typeOf _mainVehicle in ["convoy_money", "convoy_supplies"]) then {
		[_mainVehicle, caja] call AS_fnc_transferToBox;
		AS_Sset("reportedVehs", AS_S("reportedVehs") - [_mainVehicle]);
	};

	_mission call AS_mission_spawn_fnc_clean;
};

AS_mission_convoy_states = ["initialize", "spawn", "run", "clean"];
AS_mission_convoy_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
