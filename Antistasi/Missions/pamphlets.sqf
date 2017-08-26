#include "../macros.hpp"

// 3 crates are initialized. Add more in spawn if this number is changed
#define DROP_COUNT 3

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;
	private _size = _location call AS_fnc_location_size;

	// mission timer
	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_fnc_mission_title;
	private _tskDesc = format [localize "STR_tskDesc_PRPamphlet",
		[_location] call localizar,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4];

	private _buildings = nearestObjects [_position, ["Building"], _size];
	_buildings = _buildings call AS_fnc_shuffle;

	[_mission, "buildings", _buildings select [0, DROP_COUNT]] call AS_spawn_fnc_set;
	[_mission, "currentDrop", 0] call AS_spawn_fnc_set;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, "Heal"] call AS_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _task = ([_mission, "CREATED"] call AS_spawn_fnc_loadTask) call BIS_fnc_setTask;

	// spawn two additional patrols with dogs
	private _grupos = [];
	private _vehicles = [];

	// spawn mission vehicle
	private _truck = "C_Van_01_transport_F" createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [5,50,"C_Van_01_transport_F"]);
	_vehicles pushBack _truck;

	private _crate3 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
	_crate3 attachTo [_truck,[0,-2.5,-0.25]];
	_crate3 setDir (getDir _truck + 78);
	_vehicles pushBack _crate3;

	private _crate2 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
	_crate2 attachTo [_truck,[0.4,-1.1,-0.25]];
	_crate2 setDir (getDir _truck);
	_vehicles pushBack _crate2;

	private _crate1 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
	_crate1 attachTo [_truck,[-0.4,-1.1,-0.25]];
	_crate1 setDir (getDir _truck);
	_vehicles pushBack _crate1;

	// initialize mission vehicle
	[_truck, "FIA"] call AS_fnc_initVehicle;
	{_x reveal _truck} forEach (allPlayers - (entities "HeadlessClient_F"));
	_truck setVariable ["destino",[_location] call localizar,true];
	_truck addEventHandler ["GetIn", {
		if (_this select 1 == "driver") then {
			private _texto = format ["This truck carries leaflets for %1.",(_this select 0) getVariable "destino"];
			_texto remoteExecCall ["hint",_this select 2];
		};
	}];

	[_truck,"Mission Vehicle"] spawn inmuneConvoy;

	for "_i" from 0 to 1 do {
		private _tipoGrupo = [infGarrisonSmall, "AAF"] call fnc_pickGroup;
		private _grupo = [_position, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
		private _perro = _grupo createUnit ["Fin_random_F",_position,[],0,"FORM"];
		[_perro] call guardDog;
		[leader _grupo, _location, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_grupos pushBack _grupo;
	};

	{
		private _grp = _x;
		{
			[_x, false] call AS_fnc_initUnitAAF;
		} forEach units _grp;
	} forEach _grupos;

	[_mission, "truck", _truck] call AS_spawn_fnc_set;
	[_mission, "resources", [_task, _grupos, _vehicles, []]] call AS_spawn_fnc_set;
};

private _fnc_wait_arrival = {
	params ["_mission"];
	private _truck = [_mission, "truck"] call AS_spawn_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};

	// wait until the vehicle enters the target area
	waitUntil {sleep 1; (_truck distance _position < 500) or _fnc_missionFailedCondition};

	if (call _fnc_missionFailedCondition) then {
		private _tskDesc_fail = format [localize "STR_tskDesc_PRPamphlet_fail", [_location] call localizar];
		([_mission, "FAILED", _tskDesc_fail] call AS_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];

		[_mission, "state_index", 4] call AS_fnc_spawn_set;
	};
};

private _fnc_deliver = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _truck = [_mission, "truck"] call AS_spawn_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _currentDropCount = [_mission, "currentDrop"] call AS_spawn_fnc_get;
	private _buildings = [_mission, "buildings"] call AS_spawn_fnc_get;
	private _currentDropCount = [_mission, "currentDrop"] call AS_spawn_fnc_get;
	private _currentDrop = _buildings select _currentDropCount;
	private _resources = [_mission, "resources"] call AS_spawn_fnc_get;

	// eye candy
	private _leaflets = [
		["Land_Garbage_square3_F",[2.92334,0.0529785,0],360,1,0.0128296,[-0.000179055,0.000127677],"","",true,false],
		["Land_Leaflet_02_F",[2.66357,0.573486,0.688],36.0001,1,0,[-89.388,90],"","",true,false],
		["Land_Leaflet_02_F",[2.76953,0.0114746,0.688],152,1,0,[-88.513,-90],"","",true,false],
		["Land_Leaflet_02_F",[2.81738,-0.317627,0.688],8.00002,1,0,[-89.19,90],"","",true,false],
		["Land_WoodenCrate_01_F",[2.92334,0.0529785,0],360,1,0.0128296,[-0.000179055,0.000127677],"","",true,false],
		["Land_Leaflet_02_F",[2.91455,0.409424,0.688],0.999995,1,0,[-86.6,90],"","",true,false],
		["Land_Leaflet_02_F",[3.06543,0.0744629,0.688],309,1,0,[-89.19,90],"","",true,false],
		["Land_Leaflet_02_F",[3.1377,0.481445,0.688],312,1,0,[-89.19,90],"","",true,false]
	];

	// refresh task
	private _tskDesc_drop = format [localize "STR_tskDesc_PRPamphlet_drop", [_location] call localizar];
	([_mission, "ASSIGNED", _tskDesc_drop, position _currentDrop] call AS_spawn_fnc_loadTask) call BIS_fnc_setTask;

	// send patrol to the location
	{
		if (alive leader _x) then {
			private _wp101 = _x addWaypoint [position _currentDrop, 20];
			_wp101 setWaypointType "SAD";
			_wp101 setWaypointBehaviour "AWARE";
			_x setCombatMode "RED";
			_x setCurrentWaypoint _wp101;
		};
	} forEach (_resources select 1);

	// wait 1m to unload the truck
	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};
	private _fnc_loadCratesCondition = {
		(_truck distance _currentDrop < 20) and {speed _truck < 1} and
		{{alive _x and not (_x call AS_fnc_isUnconscious)} count ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0} and
		{{(side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
	};
	private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";
	[_truck, 60, _fnc_loadCratesCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

	if (call _fnc_missionFailedCondition) then {
		// exits the while loop, not the mission
		private _tskDesc_fail = format [localize "STR_tskDesc_PRPamphlet_fail", [_location] call localizar];
		([_mission, "FAILED", _tskDesc_fail] call AS_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];
	} else {
		private _posUnload = (position _truck) findEmptyPosition [1,10,"C_Van_01_transport_F"];
		private _drop = [_posUnload, random 360, _leaflets] call BIS_fnc_ObjectsMapper;
		(_resources select 2) append _drop;

		// next location
		_currentDropCount = _currentDropCount + 1;

		// if there are sites to go, inform player and repeat this call
		if (_currentDropCount < DROP_COUNT) then {
			{
				if (isPlayer _x) then {[petros,"hint","Head to the next location."] remoteExec ["commsMP",_x]};
			} forEach ([150, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

			[_mission, "currentDrop", _currentDropCount] call AS_spawn_fnc_set;
			[_mission, "state_index", 2] call AS_fnc_spawn_set;
		} else {
			private _tskDesc_success = format [localize "STR_tskDesc_PRPamphlet_success",
				[_location] call localizar,
				numberToDate [2035,_max_date] select 3,
				numberToDate [2035,_max_date] select 4
			];
			([_mission, "SUCCEEDED", _tskDesc_success] call AS_spawn_fnc_loadTask) call BIS_fnc_setTask;
			[_mission] remoteExec ["AS_fnc_mission_success", 2];
		};
	};
};

AS_mission_pamphlets_states = ["initialize", "spawn", "wait_arrival", "deliver", "clean"];
AS_mission_pamphlets_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait_arrival,
	_fnc_deliver,
	AS_mission_fnc_clean
];
