
private _fnc_initialize = {
	params ["_mission"];

	private _mapPosition = [_mission, "position"] call AS_mission_fnc_get;
	private _minesPositions = [_mission, "positions"] call AS_mission_fnc_get;

	private _tskTitle = "Minefield Deploy";
	private _tskDesc = format ["An Engineer Team has been deployed at your High command. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",count _minesPositions];

	// marker for the task.
	private _mrk = createMarker [_mission, _mapPosition];
	_mrk setMarkerShape "ELLIPSE";
	_mrk setMarkerSize [100,100];
	_mrk setMarkerColor "ColorRed";
	_mrk setMarkerAlpha 0;

	[_mission, [_tskDesc, _tskTitle, _mrk], _mapPosition, "map"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "resources", [taskNull, [], [], [_mrk]]] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
	params ["_mission"];
	private _vehType = [_mission, "vehicle"] call AS_mission_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _tam = 10;
	private _roads = [];
	while {count _roads == 0} do {
		_roads = getMarkerPos "FIA_HQ" nearRoads _tam;
		_tam = _tam + 10;
	};

	private _pos = position (_roads select 0) findEmptyPosition [1,30,_vehType];

	private _vehType = selectRandom (["FIA", "vans"] call AS_fnc_getEntity);
	private _truck = _vehType createVehicle _pos;
	[_truck, "FIA"] call AS_fnc_initVehicle;

	private _group = createGroup side_blue;
	AS_commander hcSetGroup [_group];
	_group setVariable ["isHCgroup", true, true];
	_group setGroupId ["MineF"];

	_group addVehicle _truck;
	["Explosives Specialist", getMarkerPos "FIA_HQ", _group] call AS_fnc_spawnFIAUnit;
	["Explosives Specialist", getMarkerPos "FIA_HQ", _group] call AS_fnc_spawnFIAUnit;
	{[_x] spawn AS_fnc_initUnitFIA; [_x] orderGetIn true} forEach units _group;
	leader _group setBehaviour "SAFE";
	_truck allowCrewInImmobile true;

	private _markers = ([_mission, "resources"] call AS_spawn_fnc_get) select 3;
	[_mission, "resources", [_task, [_group], [_truck], _markers]] call AS_spawn_fnc_set;

};

private _fnc_wait_to_arrive = {
	params ["_mission"];
	private _mapPosition = [_mission, "position"] call AS_mission_fnc_get;
	private _group = ([_mission, "resources"] call AS_spawn_fnc_get) select 1 select 0;
	private _truck = ([_mission, "resources"] call AS_spawn_fnc_get) select 2 select 0;
	private _mrk = ([_mission, "resources"] call AS_spawn_fnc_get) select 3 select 0;

	private _arrivedSafely = false;
	waitUntil {sleep 1;
		_arrivedSafely = (_truck distance _mapPosition < 100) and ({alive _x} count units _group > 0);
		(!alive _truck) or _arrivedSafely
	};

	if _arrivedSafely then {
		if (isPlayer leader _group) then {
			[] remoteExec ["AS_fnc_completeDropAIcontrol", leader _group];
			hint "";
		};
		[[petros,"globalChat","Engineers are now deploying the mines."],"AS_fnc_localCommunication"] call BIS_fnc_MP;
		[leader _group, _mrk, "SAFE","SPAWNED", "SHOWMARKER"] spawn UPSMON;
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};

	[_mission, "arrivedSafely", _arrivedSafely] call AS_spawn_fnc_set;
};

private _fnc_wait_to_deploy = {
	params ["_mission"];
	private _mapPosition = [_mission, "position"] call AS_mission_fnc_get;
	private _mines_cargo = [_mission, "mines_cargo"] call AS_mission_fnc_get;
	private _minesPositions = [_mission, "positions"] call AS_mission_fnc_get;
	private _cost = [_mission, "cost"] call AS_mission_fnc_get;
	private _group = ([_mission, "resources"] call AS_spawn_fnc_get) select 1 select 0;
	private _truck = ([_mission, "resources"] call AS_spawn_fnc_get) select 2 select 0;
	private _arrivedSafely = [_mission, "arrivedSafely"] call AS_spawn_fnc_get;

	if _arrivedSafely then {
		// simulates putting mines.
		sleep (20*(count _minesPositions));

		if ((alive _truck) and ({alive _x} count units _group > 0)) then {
			// create minefield
			private _minesData = [];
			private _current_mine_index = 0;
			private _current_mine_amount = 0;
			{
				private _mineType = _mines_cargo select 0 select _current_mine_index;
				private _typeCount = _mines_cargo select 1 select _current_mine_index;

				_minesData pushBack [_mineType call AS_fnc_mineVehicle, _x, random 360];
				_current_mine_amount = _current_mine_amount + 1;

				if (_current_mine_amount == _typeCount) then {
					_current_mine_index = _current_mine_index + 1;
					_current_mine_amount = 0;
				};
			} forEach _minesPositions;
			[_mapPosition, "FIA", _minesData] call AS_fnc_addMinefield;

			[{alive _x} count units _group,_cost] remoteExec ["AS_fnc_changeFIAmoney",2];  // recover the costs

			([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
			[_mission] remoteExec ["AS_mission_fnc_success", 2];
		} else {
			([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
			[_mission] remoteExec ["AS_mission_fnc_fail", 2];
		};
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

AS_mission_establishFIAminefield_states = ["initialize", "spawn", "wait_to_arrive", "wait_to_deploy", "clean"];
AS_mission_establishFIAminefield_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait_to_arrive,
	_fnc_wait_to_deploy,
	_fnc_clean
];
