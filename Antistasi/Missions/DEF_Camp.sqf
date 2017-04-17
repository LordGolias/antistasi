if (!isServer and hasInterface) exitWith {};

_tskTitle = localize "STR_tsk_DefCamp";
_tskDesc = localize "STR_tskDesc_DefCamp";

// only one defence mission at a time, no camp attacks while CSAT coms are being jammed
if !(isNil {server getVariable "campQRF"}) exitWith {};
if (server getVariable "blockCSAT") exitWith {};
if ("DEF" in misiones) exitWith {};

// location of the camp (marker)
params ["_camp"];
private _position = _camp call AS_fnc_location_position;
private _campName = [_camp,"name"] call AS_fnc_location_get;

// maximum duration of the attack, sets the despawn timer
private _duration = 15;

// select suitable airports
private _airports = [];
{
	_posAirport = _x call AS_fnc_location_position;
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
}
else {
	_airport = "spawnCSAT";
	_airportName = "the CSAT carrier";
};

_tsk = ["DEF_Camp",[side_blue,civilian],[format [_tskDesc, _campName, _airportName], format [_tskTitle, _campName],_camp],_position,"CREATED",5,true,true,"Defend"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

// size of the QRF, depending on the number of players online
_QRFsize = "small";
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
_infGroups = server getVariable "campQRF";
private _soldados = units (_infGroups select 0);
if (_QRFsize == "large") then {
	_soldados append (units (_infGroups select 1));
};

while {
	({not (captive _x)} count _soldados > {captive _x} count _soldados) &&
	({alive _x} count _soldados > {fleeing _x} count _soldados) &&
	({alive _x} count _soldados > 0) &&
	(_camp call AS_fnc_location_exists)} do {
	sleep 10;
};

// success if camp is still alive
if (_camp call AS_fnc_location_exists) then {
	_tsk = ["DEF_Camp",[side_blue,civilian],[format [_tskDesc, _campName, _airportName], format [_tskTitle, _campName],_camp],_position,"SUCCEEDED",5,true,true,"Defend"] call BIS_fnc_setTask;
	[0,3] remoteExec ["prestige",2];
	[0,300] remoteExec ["resourcesFIA",2];
	[5,AS_commander] call playerScoreAdd;
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_position,"BLUFORSpawn"] call distanceUnits);
}
else {
	_tsk = ["DEF_Camp",[side_blue,civilian],[format [_tskDesc, _campName, _airportName], format [_tskTitle, _campName],_camp],_position,"FAILED",5,true,true,"Defend"] call BIS_fnc_setTask;
};

// no need to despawn troops, it's done through the QRF script
[1200,_tsk] spawn borrarTask;
