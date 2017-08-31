#include "../macros.hpp"

AS_fnc_defendCamp = {
	AS_SERVER_ONLY("defendCamp");
	params ["_location"];
	private _position = _location call AS_fnc_location_position;

	// only one defence mission at a time, no camp attacks while CSAT coms are being jammed
	private _debug_prefix = format ["defend_camp from '%1' to '%2' cancelled: ", _location];
	if AS_S("blockCSAT") exitWith {
		private _message = "blocked";
		AS_ISDEBUG(_debug_prefix + _message);
	};
	if not isNil {AS_S("campQRF")} exitWith {
		private _message = "another attack already in progress";
		AS_ISDEBUG(_debug_prefix + _message);
	};

	if (count ("defend_camp" call AS_fnc_active_missions) != 0) exitWith {
		private _message = "another attack already in progress";
		AS_ISDEBUG(_debug_prefix + _message);
	};

	private _mission = ["defend_camp", _location] call AS_fnc_mission_add;
	_mission call AS_fnc_mission_activate;
};


private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _campName = [_location, "name"] call AS_fnc_location_get;

	// maximum duration of the attack, sets the despawn timer
	private _duration = 15;

	// select suitable airports
	private _airports = [];
	{
		private _posAirport = _x call AS_fnc_location_position;
		if ((_position distance _posAirport < 10000) and
		    (_position distance _posAirport > 1500) and
			(not (_x call AS_fnc_location_spawned))) then {
			_airports pushBack _x;
		};
	} forEach (["airfield", "AAF"] call AS_fnc_location_TS);

	private _airport = "";
	private _airportName = "";
	if (count _airports > 0) then {
		_airport = [_airports, _position] call BIS_fnc_nearestPosition;
		_airportName = [_airport] call localizar;
	} else {
		_airport = "spawnCSAT";
		_airportName = "the CSAT carrier";
	};

	// size of the QRF, depending on the number of players online
	private _QRFsize = "small";
	if (isMultiplayer) then {
		if (count (allPlayers - entities "HeadlessClient_F") > 3) then {
			_QRFsize = "large";
		};
	};

	private _tskTitle = format [localize "STR_tsk_DefCamp", _campName];
	private _tskDesc = format [localize "STR_tskDesc_DefCamp", _campName, _airportName];

	[_mission, [_tskDesc,_tskTitle,_location], _position, "Defend"] call AS_mission_spawn_fnc_saveTask;
	[_mission, "qrf_params", [_airport, _position, _location, _duration, "transport", _QRFsize, "campQRF"]] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
	params ["_mission"];
	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _qrf_params = [_mission, "qrf_params"] call AS_spawn_fnc_get;

	// call the QRF, single transport helicopter
	_qrf_params remoteExec ["enemyQRF", 2];
	waitUntil {sleep 1; not isNil {AS_S("campQRF")}};

	// infantry group of the QRF, to determine success/failure
	private _soldiers = [];
	{
		_soldiers append (units _x);
	} forEach AS_S("campQRF");

	// groups are despawned by the QRF script, so we do not add them to the resources
	[_mission, "resources", [_task, [], [], []]] call AS_spawn_fnc_set;
	[_mission, "soldiers", _soldiers] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _soldiers = [_mission, "soldiers"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {not _location call AS_fnc_location_exists};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_fnc_mission_fail", 2];
	};

	// 3/4 are incapacitated
	private _fnc_missionSuccessfulCondition = {
		({not alive _x or fleeing _x or captive _x} count _soldiers >= 3./4*(count _soldiers))
	};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_fnc_mission_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_defendCamp_states = ["initialize", "spawn", "run", "clean"];
AS_mission_defendCamp_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_fnc_clean
];
