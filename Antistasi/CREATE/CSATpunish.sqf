#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};
params ["_mrkDestino"];

[_mrkDestino,true] call AS_fnc_location_spawn;

private _posdestino = _mrkDestino call AS_fnc_location_position;
private _nombredest = [_mrkDestino] call localizar;
private _size = _mrkDestino call AS_fnc_location_size;
private _population = [_mrkDestino, "population"] call AS_fnc_location_get;

private _grupos = [];
private _soldados = [];
private _pilotos = [];
private _vehiculos = [];
private _civiles = [];

private _tsk = ["AtaqueAAF",[side_blue,civilian],[format ["CSAT is making a punishment expedition to %1. They will kill everybody there. Defend the city at all costs",_nombredest],"CSAT Punishment",_mrkDestino],_posdestino,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
//Ataque de artillería
[_mrkdestino] spawn artilleria;

private _tiempo = time + 3600;

private _posorigen = getMarkerPos "spawnCSAT";

for "_i" from 1 to 3 do {
	private _tipoveh = opAir call BIS_fnc_selectRandom;
	private _timeOut = 0;
	private _pos = _posorigen findEmptyPosition [0,100,_tipoveh];
	while {_timeOut < 60} do {
		if (count _pos > 0) exitWith {};
		_timeOut = _timeOut + 1;
		_pos = _posorigen findEmptyPosition [0,100,_tipoveh];
		sleep 1;
	};
	if (count _pos == 0) then {_pos = _posorigen};

	private _vehicle = [_pos, 0, _tipoveh, side_red] call bis_fnc_spawnvehicle;
	private _heli = _vehicle select 0;
	private _heliCrew = _vehicle select 1;
	private _grupoheli = _vehicle select 2;
	_pilotos append _heliCrew;
	{[_x] spawn CSATinit} forEach _heliCrew;
	_grupos pushBack _grupoheli;
	_vehiculos pushBack _heli;

	if (_tipoveh != opHeliFR) then {
		private _wp1 = _grupoheli addWaypoint [_posdestino, 0];
		_wp1 setWaypointType "SAD";
		[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
	} else {
		{_x setBehaviour "CARELESS";} forEach units _grupoheli;
		private _tipoGrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
		private _grupo = [_posorigen, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados pushBack _x; [_x] spawn CSATinit} forEach units _grupo;
		_grupos pushBack _grupo;
		[_heli,"CSAT Air Transport"] spawn inmuneConvoy;

		if (random 100 < 50) then
			{
			{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
			private _landpos = [];
			_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
			_landPos set [2, 0];
			private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
			_vehiculos pushBack _pad;
			private _wp0 = _grupoheli addWaypoint [_landpos, 0];
			_wp0 setWaypointType "TR UNLOAD";
			_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'"];
			[_grupoheli,0] setWaypointBehaviour "CARELESS";
			private _wp3 = _grupo addWaypoint [_landpos, 0];
			_wp3 setWaypointType "GETOUT";
			_wp0 synchronizeWaypoint [_wp3];
			private _wp4 = _grupo addWaypoint [_posdestino, 1];
			_wp4 setWaypointType "SAD";
			private _wp2 = _grupoheli addWaypoint [_posorigen, 1];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
			[_grupoheli,1] setWaypointBehaviour "AWARE";
			}
		else
			{[_heli,_grupo,_posdestino,_posorigen,_grupoheli] spawn fastropeCSAT;}
		};
	sleep 20;
	};

private _numCiv = round ((_population * AS_P("civPerc"))/2);
if (_numCiv < 8) then {_numCiv = 8};

private _grupoCivil = createGroup side_blue;
_grupos pushBack _grupoCivil;

for "_i" from 0 to _numCiv do {
	private _pos = _posdestino getPos [_size,random 360];
	private _civ = _grupoCivil createUnit [arrayCivs call BIS_fnc_selectRandom,_pos, [],_size,"NONE"];
	_rnd = random 100;
	if (_rnd < 90) then {
		if (_rnd < 25) then {
			[_civ, "hgun_PDW2000_F", 5, 0] call BIS_fnc_addWeapon;
		} else {
			[_civ, "hgun_Pistol_heavy_02_F", 5, 0] call BIS_fnc_addWeapon;
		};
	};
	_civiles pushBack _civ;
	[_civ] spawn AS_fnc_initUnitCIV;
	sleep 1;
};

[leader _grupoCivil, _mrkDestino, "AWARE","SPAWNED","NOVEH2"] execVM "scripts\UPSMON.sqf";

private _civilMax = {alive _x} count _civiles;
private _solMax = count _soldados;

for "_i" from 0 to round random 2 do {
	[_mrkdestino, selectRandom opCASFW] spawn airstrike;
	sleep 30;
};

{if ((surfaceIsWater position _x) and (vehicle _x == _x)) then {_x setDamage 1}} forEach _soldados;

waitUntil {sleep 5; (({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or ({alive _x} count _soldados < round (_solMax / 3)) or (({(_x distance _posdestino < _size*2) and (not(vehicle _x isKindOf "Air")) and (alive _x) and (!captive _x)} count _soldados) > 4*({(alive _x) and (_x distance _posdestino < _size*2)} count _civiles)) or (time > _tiempo)};

if ((({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or ({alive _x} count _soldados < round (_solMax / 3)) or (time > _tiempo)) then {
	{_x doMove [0,0,0]} forEach _soldados;
	_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["CSAT is making a punishment expedition to %1. They will kill everybody there. Defend the city at all costs",_nombredest],"CSAT Punishment",_mrkDestino],_posdestino,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
	[-5,20,_posdestino] remoteExec ["citySupportChange",2];
	[10,0] remoteExec ["prestige",2];
	{[-5,0,_x] remoteExec ["citySupportChange",2]} forEach (call AS_fnc_location_cities);
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posdestino,"BLUFORSpawn"] call distanceUnits);
	[10,AS_commander] call playerScoreAdd;
}
else {
	_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["CSAT is making a punishment expedition to %1. They will kill everybody there. Defend the city at all costs",_nombredest],"CSAT Punishment",_mrkDestino],_posdestino,"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
	[-5,-20,_posdestino] remoteExec ["citySupportChange",2];
	{[0,-5,_x] remoteExec ["citySupportChange",2]} forEach (call AS_fnc_location_cities);
	AS_Pset("destroyedLocations", AS_P("destroyedLocations") + [_mrkDestino]);
	if (count AS_P("destroyedLocations") > 7) then {
		 ["destroyedCities",false,true] remoteExec ["BIS_fnc_endMission",0];
	};
	for "_i" from 1 to 60 do {
		createMine ["APERSMine",_posdestino,[],_size];
	};
};

[_mrkDestino,true] call AS_fnc_location_despawn;
sleep 15;

[0,_tsk] spawn borrarTask;
[7200] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
{
waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _soldados;
{
waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _pilotos;
{
if (!([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
} forEach _vehiculos;
{deleteGroup _x} forEach _grupos;

waitUntil {sleep 1; not (_mrkDestino call AS_fnc_location_spawned)};

{deleteVehicle _x} forEach _civiles;
deleteGroup _grupoCivil;
