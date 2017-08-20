#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

// only one defence mission at a time, no camp attacks while CSAT coms are being jammed
private _debug_prefix = format ["DEF_Camp from '%1' to '%2' cancelled: ", _location];
if AS_S("blockCSAT") exitWith {
	private _message = "blocked";
	AS_ISDEBUG(_debug_prefix + _message);
};
if not isNil {AS_S("campQRF")} exitWith {
	private _message = "another attack already in progress";
	AS_ISDEBUG(_debug_prefix + _message);
};

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

private _tskTitle = format [localize "STR_tsk_DefCamp", _campName];
private _tskDesc = format [localize "STR_tskDesc_DefCamp", _campName, _airportName];

private _task = [_mission,[side_blue,civilian],[_tskDesc, _tskTitle, _location], _position,"CREATED",5,true,true,"Defend"] call BIS_fnc_setTask;

// size of the QRF, depending on the number of players online
private _QRFsize = "small";
if (isMultiplayer) then {
	if (count (allPlayers - entities "HeadlessClient_F") > 3) then {
		_QRFsize = "large";
	};
};

// call the QRF, single transport helicopter
[_airport, _position, _location, _duration, "transport", _QRFsize, "campQRF"] remoteExec ["enemyQRF", 2];
waitUntil {sleep 1; not isNil {AS_S("campQRF")}};

// infantry group of the QRF, to determine success/failure
private _soldados = [];
{
	_soldados append (units _x);
} forEach AS_S("campQRF");

private _fnc_clean = {
	// troops are despawned by the QRF script
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {not _location call AS_fnc_location_exists};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"FAILED",5,true,true,"Defend"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_fail", 2];
};

// 3/4 are incapacitated
private _fnc_missionSuccessfulCondition = {
	({not alive _x or fleeing _x or captive _x} count _soldados >= 3./4*(count _soldados))
};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"SUCCEEDED",5,true,true,"Defend"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_success", 2];
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
