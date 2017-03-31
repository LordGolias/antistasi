if (!isServer and hasInterface) exitWith {};

_tskTitle = localize "STR_tsk_DefCamp";
_tskDesc = localize "STR_tskDesc_DefCamp";

// only one defence mission at a time, no camp attacks while CSAT coms are being jammed
if !(isNil {server getVariable "campQRF"}) exitWith {};
if (server getVariable "blockCSAT") exitWith {};
if ("DEF" in misiones) exitWith {};

// location of the camp (marker)
_targetMarker = _this select 0;

_targetPosition = getMarkerPos _targetMarker;

// maximum duration of the attack, sets the despawn timer
_duration = 15;

// name of the camp under attack
_campName = "";
for "_i" from 0 to (count campList - 1) do {
	if ((campList select _i) select 0 == _targetMarker) exitWith {
		_campName = (campList select _i) select 1;
	};
};

// airport to launch the attack from, CSAT if none found
_airportsAAF = aeropuertos - mrkFIA;
_airports = [];
_airport = "";
_posAirport = [];
_airportName = "";
{
	_airport = _x;
	_posAirport = getMarkerPos _airport;
	if ((_targetPosition distance _posAirport < 10000) and (_targetPosition distance _posAirport > 1500) and (not (spawner getVariable _airport))) then {_airports = _airports + [_airport]}
} forEach _airportsAAF;
if (count _airports > 0) then {
	_airport = [_airports, _targetPosition] call BIS_fnc_nearestPosition;
	_posAirport = getMarkerPos _airport;
	_airportName = [_airport] call localizar;
}
else {
	_airport = "spawnCSAT";
	_airportName = "the CSAT carrier";
};

_tsk = ["DEF_Camp",[side_blue,civilian],[format [_tskDesc, _campName, _airportName], format [_tskTitle, _campName],_targetMarker],_targetPosition,"CREATED",5,true,true,"Defend"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

// size of the QRF, depending on the number of players online
_QRFsize = "small";
if (isMultiplayer) then {
	if (count (allPlayers - entities "HeadlessClient_F") > 3) then {
		_QRFsize = "large";
	};
};

// call the QRF, single transport helicopter
[_airport, _targetPosition, _targetMarker, _duration, "transport", _QRFsize, "campQRF"] remoteExec ["enemyQRF", 2];

// wait for the QRF script to be loaded
sleep 10;

// infantry group of the QRF, to determine success/failure
_infGroups = server getVariable "campQRF";
_soldados = units (_infGroups select 0);
if (_QRFsize == "large") then {
	_soldados = _soldados + units (_infGroups select 1);
};

[format ["DefCamp -- Soldiers: %1; Number: %2; campQRF: %3", _soldados, count _soldados, server getVariable ["campQRF", "none"]]] remoteExec ["fnc_logOutput", 2];

// all attackers dead/fleeing or camp has been destroyed
//waitUntil {sleep 1;({not (captive _x)} count _soldados < {captive _x} count _soldados) or ({alive _x} count _soldados < {fleeing _x} count _soldados) or ({alive _x} count _soldados == 0) or !(_targetMarker in campsFIA)};

while {
	({not (captive _x)} count _soldados > {captive _x} count _soldados) &&
	({alive _x} count _soldados > {fleeing _x} count _soldados) &&
	({alive _x} count _soldados > 0) &&
	(_targetMarker in campsFIA)} do {
	sleep 10;
};
[format ["DefCamp -- con 1: %1; con 2: %2; con 3: %3; con 4: %4", ({not (captive _x)} count _soldados > {captive _x} count _soldados), ({alive _x} count _soldados > {fleeing _x} count _soldados), ({alive _x} count _soldados > 0), (_targetMarker in campsFIA)]] remoteExec ["fnc_logOutput", 2];
// success if camp is still alive
if (_targetMarker in campsFIA) then {
	_tsk = ["DEF_Camp",[side_blue,civilian],[format [_tskDesc, _campName, _airportName], format [_tskTitle, _campName],_targetMarker],_targetPosition,"SUCCEEDED",5,true,true,"Defend"] call BIS_fnc_setTask;
	[0,3] remoteExec ["prestige",2];
	[0,300] remoteExec ["resourcesFIA",2];
	[5,AS_commander] call playerScoreAdd;
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_targetPosition,"BLUFORSpawn"] call distanceUnits);
}
else {
	_tsk = ["DEF_Camp",[side_blue,civilian],[format [_tskDesc, _campName, _airportName], format [_tskTitle, _campName],_targetMarker],_targetPosition,"FAILED",5,true,true,"Defend"] call BIS_fnc_setTask;
};

// no need to despawn troops, it's done through the QRF script
[1200,_tsk] spawn borrarTask;