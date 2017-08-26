#include "../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _foundSuitablePlace = false;
	private _posCmp = "";
	private _dirveh = 0;
	{
		// roads farther than 150m and closer than 300m
		private _road = _x;
		if ((_road distance _position > 150) and (_road distance _position < 300)) then {
			private _road2 = (_road nearRoads 5) select 0;
			if (!isNil "_road2") then {
				private _p2 = getPos ((roadsConnectedto _road2) select 0);
				_posCmp = [_road, 8, ([_road,_p2] call BIS_fnc_DirTo) + 90] call BIS_Fnc_relPos;
				_dirveh = [_posCmp,_road] call BIS_fnc_DirTo;
				if (count (nearestObjects [_posCmp, [], 6]) < 1) then {
					_foundSuitablePlace = true;
				};
			};
		};
		if _foundSuitablePlace exitWith {};
	} forEach (([_location, "roads"] call AS_fnc_location_get) call AS_fnc_shuffle);

	if not _foundSuitablePlace exitWith {
		[[petros, "globalChat", "Dealer cancelled the deal."],"commsMP"] call BIS_fnc_MP;
		_mission call AS_fnc_mission_remove;

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	};

	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_fnc_mission_title;
	private _tskDesc = format [localize "Str_tskDesc_fndExp",
		[_location] call localizar,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "campDisposition", [_posCmp, _dirveh]] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, "Find"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	([_mission, "campDisposition"] call AS_spawn_fnc_get) params ["_posCmp", "_dirveh"];

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _objs = [_posCmp, _dirveh, call (compile (preprocessFileLineNumbers "Compositions\cmpExp.sqf"))] call BIS_fnc_ObjectsMapper;

	private _groupDev = createGroup civilian;
	private _dealer = _groupDev createUnit ["C_Nikos", [0,0,0], [], 0.9, "NONE"];
	_dealer allowDamage false;
	_dealer setPos _posCmp;
	_dealer setDir _dirveh;
	_dealer removeWeaponGlobal (primaryWeapon _dealer);
	_dealer setIdentity "Devin";
	_dealer disableAI "MOVE";
	_dealer setunitpos "up";

	{
		call {
			if (str typeof _x find "Land_PlasticCase_01_medium_F" > -1) exitWith {expCrate = _x; [expCrate] call emptyCrate;};
			if (str typeof _x find "Box_Syndicate_Wps_F" > -1) exitWith { [_x] call emptyCrate;};
			if (str typeof _x find "Box_IED_Exp_F" > -1) exitWith { [_x] call emptyCrate;};
		};
	} forEach _objs;

	[_mission, "dealer", _dealer] call AS_spawn_fnc_set;
	[_mission, "resources", [_task, [_groupDev], _objs, []]] call AS_spawn_fnc_set;
};

private _fnc_wait_to_arrive = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _dealer = [_mission, "dealer"] call AS_spawn_fnc_get;
	private _posCmp = ([_mission, "campDisposition"] call AS_spawn_fnc_get) select 0;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or !(alive _dealer)};

	private _missionStartCondition = {
		{_x distance _dealer < 200} count (allPlayers - (entities "HeadlessClient_F")) > 0
	};

	waitUntil {sleep 1; False or _missionStartCondition or _fnc_missionFailedCondition};

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_fnc_mission_fail", 2];
		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	} else {
		_dealer allowDamage true;
		[["spawnCSAT", _posCmp, _location, 15, "transport", "small"], "enemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2];
	};
};

private _fnc_wait_to_end = {
	params ["_mission"];
	private _dealer = [_mission, "dealer"] call AS_spawn_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or !(alive _dealer)};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_fnc_mission_fail", 2];
	};
	private _fnc_missionSuccessfulCondition = {
		{((side _x isEqualTo side_blue) or (side _x isEqualTo civilian)) and
		  (_x distance _dealer < 10)} count allPlayers > 0
	};
	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[[_dealer,"buy_exp"],"AS_fnc_addAction"] call BIS_fnc_MP;

		_mission remoteExec ["AS_fnc_mission_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;

	[[_dealer,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;
	if (alive _dealer) then {
		_dealer enableAI "ANIM";
		_dealer enableAI "MOVE";
		_dealer stop false;
		_dealer doMove ((selectRandom ("resource" call AS_fnc_location_T)) call AS_fnc_location_position);
	};
};

AS_mission_blackMarket_states = ["initialize", "spawn", "wait_to_arrive", "wait_to_end", "clean"];
AS_mission_blackMarket_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait_to_arrive,
	_fnc_wait_to_end,
	AS_mission_fnc_clean
];
