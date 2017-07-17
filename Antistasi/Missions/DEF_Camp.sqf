if (!isServer and hasInterface) exitWith {};

// only one defence mission at a time, no camp attacks while CSAT coms are being jammed
if !(isNil {server getVariable "campQRF"}) exitWith {};
if (server getVariable "blockCSAT") exitWith {};
if ("DEF" in misiones) exitWith {};

// location of the camp (marker)
params ["_camp"];
private _position = _camp call AS_fnc_location_position;
private _campName = [_camp, "name"] call AS_fnc_location_get;

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
private _posAirport = [];
private _airportName = "";
if (count _airports > 0) then {
	_airport = [_airports, _position] call BIS_fnc_nearestPosition;
	_posAirport = _airport call AS_fnc_location_position;
	_airportName = [_airport] call localizar;
} else {
	_airport = "spawnCSAT";
	_airportName = "the CSAT carrier";
};

private _tskTitle = format [localize "STR_tsk_DefCamp", _campName];
private _tskDesc = format [localize "STR_tskDesc_DefCamp", _campName, _airportName];

private _tsk = ["DEF_Camp",[side_blue,civilian],[_tskDesc, _tskTitle, _camp], _position,"CREATED",5,true,true,"Defend"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

// size of the QRF, depending on the number of players online
private _QRFsize = "small";
if (isMultiplayer) then {
	if (count (allPlayers - entities "HeadlessClient_F") > 3) then {
		_QRFsize = "large";
	};
};

// call the QRF, single transport helicopter
[_airport, _position, _camp, _duration, "transport", _QRFsize, "campQRF"] remoteExec ["enemyQRF", 2];

// wait for the QRF script to be loaded
sleep 10;

// infantry group of the QRF, to determine success/failure
private _soldados = [];
{
	_soldados append (units _x);
} forEach (server getVariable "campQRF");

private _fnc_clean = {
	// troops are despawned by the QRF script
	[1200,_tsk] spawn borrarTask;
};

private _fnc_missionFailedCondition = {not _camp call AS_fnc_location_exists};

private _fnc_missionFailed = {
	_tsk = ["DEF_Camp",[side_blue,civilian],[_tskDesc, _tskTitle, _camp],_position,"FAILED",5,true,true,"Defend"] call BIS_fnc_setTask;
	call _fnc_clean;
};

// 3/4 are incapacitated
private _fnc_missionSuccessfulCondition = {
	({not alive _x or fleeing _x or captive _x} count _soldados >= 3./4*(count _soldados))
};

private _fnc_missionSuccessful = {
	_tsk = ["DEF_Camp",[side_blue,civilian],[_tskDesc, _tskTitle, _camp],_position,"SUCCEEDED",5,true,true,"Defend"] call BIS_fnc_setTask;
	[0,3] remoteExec ["prestige",2];
	[0,300] remoteExec ["resourcesFIA",2];
	[5,AS_commander] call playerScoreAdd;
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_position,"BLUFORSpawn"] call distanceUnits);

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
