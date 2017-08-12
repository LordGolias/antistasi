#include "../macros.hpp"
params ["_location"];

private _position = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;
private _size = _location call AS_fnc_location_size;
private _population = [_location, "population"] call AS_fnc_location_get;

private _tskTitle = "CSAT Punishment";
private _tskDesc = format ["CSAT is making a punishment expedition to %1. They will kill everybody there. Defend the city at all costs",_nombredest];

private _mission = ["csat_attack", _location] call AS_fnc_mission_add;
[_mission, "status", "active"] call AS_fnc_mission_set;
private _task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;

[_location,true] call AS_fnc_location_spawn;
private _grupos = [];
private _pilotos = [];
private _vehiculos = [];
private _civiles = [];

private _fnc_clean = {
	[_location,true] call AS_fnc_location_despawn;
	[_grupos, _vehiculos] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _posorigen = getMarkerPos "spawnCSAT";

for "_i" from 1 to 3 do {
	private _tipoveh = selectRandom opAir;
	private _timeOut = 0;
	private _pos = _posorigen findEmptyPosition [0,100,_tipoveh];
	while {_timeOut < 60 or {count _pos == 0}} do {
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
		private _wp1 = _grupoheli addWaypoint [_position, 0];
		_wp1 setWaypointType "SAD";
		[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
	} else {
		{_x setBehaviour "CARELESS";} forEach units _grupoheli;
		private _tipoGrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
		private _grupo = [_posorigen, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] spawn CSATinit} forEach units _grupo;
		_grupos pushBack _grupo;
		[_heli,"CSAT Air Transport"] spawn inmuneConvoy;

		if (random 100 < 50) then {
			{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
			private _landpos = [];
			_landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
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
			private _wp4 = _grupo addWaypoint [_position, 1];
			_wp4 setWaypointType "SAD";
			private _wp2 = _grupoheli addWaypoint [_posorigen, 1];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
			[_grupoheli,1] setWaypointBehaviour "AWARE";
		} else {
			[_grupoheli, _pos, _position, _location, [_grupo], 25*60] call fnc_QRF_fastrope;
		};
	};
	sleep 20;
};

private _numCiv = round ((_population * AS_P("civPerc"))/2);
if (_numCiv < 8) then {_numCiv = 8};

private _grupoCivil = createGroup side_blue;
_grupos pushBack _grupoCivil;

for "_i" from 0 to _numCiv do {
	private _pos = _position getPos [_size,random 360];
	private _civ = _grupoCivil createUnit [arrayCivs call BIS_fnc_selectRandom,_pos, [],_size,"NONE"];
	private _rnd = random 100;
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

[leader _grupoCivil, _location, "AWARE","SPAWNED","NOVEH2"] execVM "scripts\UPSMON.sqf";


[_location] spawn artilleria;

for "_i" from 0 to round random 2 do {
	[_location, selectRandom opCASFW] spawn airstrike;
	sleep 30;
};

private _soldiers = [];
{_soldiers append (units _x)} forEach _grupos;

{if ((surfaceIsWater position _x) and (vehicle _x == _x)) then {_x setDamage 1}} forEach _soldiers;

private _max_incapacitated = round ((count _soldiers)/2);
private _max_killed_civs = round ((count _civiles)/2);
private _max_time = time + 60*60;

private _csat_arrived = false; // true once the CSAT forces arrived the city

private _fnc_missionFailedCondition = {
	if (not _csat_arrived and {{_x distance _position > 1.5*_size} count _soldiers > _max_incapacitated/2}) then {
		_csat_arrived = true;
	};
	True and _csat_arrived and {{(alive _x) and (_x distance _position < _size*2)} count _civiles > _max_killed_civs}
};
private _fnc_missionFailed = {
	_task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
};
private _fnc_missionSuccessfulCondition = {
	(True and _csat_arrived and
	 {(_x distance _position > 1.5*_size) or
	  not alive _x or
	  captive _x} count _soldiers > _max_incapacitated) or
	{time > _max_time}
};
private _fnc_missionSuccessful = {
	_task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	{_x doMove _posorigen} forEach _soldiers;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
