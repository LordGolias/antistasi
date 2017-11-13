#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _locationType = [_mission, "locationType"] call AS_mission_fnc_get;
	private _position = [_mission, "position"] call AS_mission_fnc_get;

	if !(_locationType in ["watchpost","roadblock","camp"]) exitwith {
		diag_log format ["[AS] Error: establishFIALocation called with wrong type '%1'", _locationType];
	};

	private _locationName = "";
	private _groupType = "";
	private _vehType = "";
	switch _locationType do {
		case "watchpost": {
			_locationName = "watchpost";
			_groupType = "Sniper Team";
			_vehType = "B_G_Quadbike_01_F";
		};
		case "roadblock": {
			_locationName = "roadblock";
			_groupType = "AT Team";
			_vehType = "B_G_Offroad_01_F";
		};
		case "camp": {
			_locationName = "camp";
			_groupType = "Sentry Team";
			_vehType = "B_G_Van_01_transport_F";
		};
	};

	private _taskTitle = format ["Establish %1", _locationName];
	private _taskDesc = format ["The team to establish the %1 is ready. Send it to the destination.", _locationName];

	// give 30m to complete mission
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 30];

	// this is a hidden marker used by the task.
	// If the mission is completed, it becomes owned by the new location
	private _mrk = createMarker [format ["FIAlocation%1", random 1000], _position];
	_mrk setMarkerShape "ELLIPSE";
	_mrk setMarkerSize [50,50];
	_mrk setMarkerAlpha 0;

	[_mission, [_taskDesc, _taskTitle, _mrk], _position, "Move"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "vehicleType", _vehType] call AS_spawn_fnc_set;
	[_mission, "groupType", _groupType] call AS_spawn_fnc_set;
	[_mission, "resources", [taskNull, [], [], [_mrk]]] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
	params ["_mission"];
	private _vehType = [_mission, "vehicleType"] call AS_spawn_fnc_get;
	private _groupType = [_mission, "groupType"] call AS_spawn_fnc_get;
	private _locationType = [_mission, "locationType"] call AS_mission_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _vehicles = [];
	private _group = [getMarkerPos "FIA_HQ", side_blue, [_groupType] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
	AS_commander hcSetGroup [_group];
	_group setVariable ["isHCgroup", true, true];
	{[_x] call AS_fnc_initUnitFIA} forEach units _group;

	// get a road close to the FIA_HQ
	private _tam = 10;
	private _roads = [];
	while {count _roads == 0} do {
		_roads = getMarkerPos "FIA_HQ" nearRoads _tam;
		_tam = _tam + 10;
	};
	private _road = _roads select 0;
	private _pos = (position _road) findEmptyPosition [1,30,_vehType];

	// create vehicle
	private _vehicle = _vehType createVehicle _pos;
	[_vehicle, "FIA"] call AS_fnc_initVehicle;
	_vehicles pushBack _vehicle;

	if (_locationType == "camp") then {
		private _crate = "Box_FIA_Support_F" createVehicle _pos;
		_crate attachTo [_vehicle, [0.0,-1.2,0.5]];
		_vehicles pushBack _crate;
	};

	_group addVehicle _vehicle;
	leader _group setBehaviour "SAFE";
	[_group] call AS_AI_fnc_dismountOnDanger;

	private _markers = ([_mission, "resources"] call AS_spawn_fnc_get) select 3;
	[_mission, "resources", [_task, [_group], _vehicles, _markers]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _locationType = [_mission, "locationType"] call AS_mission_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _position = [_mission, "position"] call AS_mission_fnc_get;
	private _resources = [_mission, "resources"] call AS_spawn_fnc_get;
	private _group = _resources select 1 select 0;
	private _vehicle = _resources select 2 select 0;
	private _mrk = _resources select 3 select 0;

	private _success = false;
	waitUntil {sleep 5;
		_success = ({alive _x} count units _group > 0) and (_vehicle distance _position < 50);

		_success or ({alive _x} count units _group == 0) or (dateToNumber date > _max_date)
	};

	if _success then {
		if (isPlayer leader _group) then {
			remoteExec ["AS_fnc_completeDropAIcontrol", leader _group];
			waitUntil {!(isPlayer leader _group)};
		};

		[_mrk,_locationType] call AS_location_fnc_add;
		// location takes ownership of _mrk
		[_mrk,"side","FIA"] call AS_location_fnc_set;
		_resources set [3, []];
		[_mission, "resources", _resources] call AS_spawn_fnc_set;

		if (_locationType == "camp") then {
			private _name = selectRandom campNames;
			campNames = campNames - [_name];
			[_mrk, "name", _name] call AS_location_fnc_set;
		};

		// todo: add the vehicle to the location

		// add the team to the garrison
		private _garrison = [_mrk, "garrison"] call AS_location_fnc_get;
		{
			if (alive _x) then {
				_garrison pushBack (_x call AS_fnc_getFIAUnitType);
			};
		} forEach units _group;
		[_mrk, "garrison", _garrison] call AS_location_fnc_set;

		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
};

private _fnc_clean = {
	params ["_mission"];
	private _resources = [_mission, "resources"] call AS_spawn_fnc_get;
	private _group = _resources select 1 select 0;
	{
		if (alive _x) then {
			([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
			[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
		};
	} forEach units _group;
	_mission call AS_mission_spawn_fnc_clean;
};

AS_mission_establishFIAlocation_states = ["initialize", "spawn", "run", "clean"];
AS_mission_establishFIAlocation_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
