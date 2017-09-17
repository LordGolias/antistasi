#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _bankPosition = [AS_bankPositions, _position] call BIS_fnc_nearestPosition;

	private _tiempolim = 120;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _mrkfin = createMarker [format ["LOG%1", random 100], _position];
	private _nombredest = [_location] call AS_fnc_location_name;
	_mrkfin setMarkerShape "ICON";

	private _taskTitle = _mission call AS_mission_fnc_title;
	private _taskDesc = format [localize "STR_tskDesc_logBank",
		_nombredest,
		_location,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4,
		A3_STR_INDEP
	];

	[_mission, [_taskDesc,_taskTitle,_mrkfin], _position, "Interact"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "resources", [taskNull, [], [], [_mrkfin]]] call AS_spawn_fnc_set;
	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "bankPosition", _bankPosition] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _bankPosition = [_mission, "bankPosition"] call AS_spawn_fnc_get;

	private _bank = (nearestObjects [_bankPosition, [], 25]) select 0;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
	private _markers = (([_mission, "resources"] call AS_spawn_fnc_get) select 3);

	private _truckType = selectRandom AS_FIA_vans;
	private _truck = _truckType createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [1,50,_truckType]);
	{_x reveal _truck} forEach (allPlayers - (entities "HeadlessClient_F"));
	[_truck, "FIA"] spawn AS_fnc_initVehicle;
	_truck setVariable ["destino",[_location] call AS_fnc_location_name,true];
	_truck addEventHandler ["GetIn", {
		if (_this select 1 == "driver") then {
			private _texto = format ["Bring this truck to %1 Bank and park it in the main entrance",(_this select 0) getVariable "destino"];
			_texto remoteExecCall ["hint",_this select 2];
		};
	}];

	[_truck, "Mission Vehicle"] spawn AS_fnc_setConvoyImmune;

	private _mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _position];
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [30,30];
	_mrk setMarkerTypeLocal "hd_warning";
	_mrk setMarkerColorLocal "ColorRed";
	_mrk setMarkerBrushLocal "DiagGrid";
	_mrk setMarkerAlphaLocal 0;
	_markers pushBack _mrk;

	private _tipoGrupo = [infSquad, "AAF"] call AS_fnc_pickGroup;
	private _group = [_position, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
	sleep 1;
	[leader _group, _mrk, "SAFE","SPAWNED", "NOVEH2", "FORTIFY"] execVM "scripts\UPSMON.sqf";
	{[_x, false] spawn AS_fnc_initUnitAAF} forEach units _group;

	_position = _bank buildingPos 1;

	[_mission, "resources", [_task, [_group], [_truck], _markers]] call AS_spawn_fnc_set;
};

private _fnc_wait_to_arrive = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _truck = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};

	waitUntil {sleep 1; (_truck distance _position < 7) or _fnc_missionFailedCondition};

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 4] call AS_spawn_fnc_set;
	};
};

private _fnc_wait_to_load = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _group = (([_mission, "resources"] call AS_spawn_fnc_get) select 1) select 0;
	private _truck = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};

	// once the truck arrives, send a patrol and make AAF aware of the truck
	[[_position], "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];

	{
		private _fiaSoldier = _x;
		if (_fiaSoldier distance _truck < 300) then {
			if ((captive _fiaSoldier) and (isPlayer _fiaSoldier)) then {
				[player, false] remoteExec ["setCaptive", _fiaSoldier]
			};
			{
				_x reveal [_fiaSoldier, 4];
			} forEach units _group;
		};
	} forEach ([AS_P("spawnDistance"), _position, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

	private _fnc_loadCondition = {
		// The condition to allow loading the crates into the truck
		(_truck distance _position < 7) and {speed _truck < 1} and
		{{alive _x and not (_x call AS_medical_fnc_isUnconscious)} count ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0} and
		{{(side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
	};

	private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";

	// wait 2m or the mission to fail
	[_truck, 120, _fnc_loadCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 4] call AS_spawn_fnc_set;
	};
};

private _fnc_wait_to_return = {
	params ["_mission"];
	private _truck = (([_mission, "resources"] call AS_spawn_fnc_get) select 2) select 0;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	{
		if (isPlayer _x) then {
			[petros,"hint","Park the truck in the base to finish this mission"] remoteExec ["AS_fnc_localCommunication",_x]
		};
	} forEach ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};

	waitUntil {sleep 1; (_truck distance (getMarkerPos "FIA_HQ") < 50) and speed _truck == 0 or _fnc_missionFailedCondition};

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	} else {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];
	};
	if (alive _truck) then {
		[_truck, caja] call AS_fnc_transferToBox;
	};
};

AS_mission_robBank_states = ["initialize", "spawn", "wait_to_arrive", "wait_to_load", "wait_to_return", "clean"];
AS_mission_robBank_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait_to_arrive,
	_fnc_wait_to_load,
	_fnc_wait_to_return,
	AS_mission_spawn_fnc_clean
];
