#include "../../macros.hpp"

#define ORIGIN (getMarkerPos "spawnCSAT")

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;

	private _tskTitle = "CSAT Punishment";
	private _tskDesc = format ["CSAT is making a punishment expedition to %1. They will kill everybody there. Defend the city at all costs",[_location] call AS_fnc_location_name];

	[_mission, [_tskDesc,_tskTitle,_location], _position, "Defend"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _population = [_location, "population"] call AS_location_fnc_get;

	private _grupos = [];
	private _pilotos = [];
	private _vehiculos = [];
	private _civilians = [];

	for "_i" from 1 to 3 do {
		private _tipoveh = selectRandom opAir;
		private _timeOut = 0;
		private _pos = ORIGIN findEmptyPosition [0,100,_tipoveh];
		while {_timeOut < 60 or {count _pos == 0}} do {
			_timeOut = _timeOut + 1;
			_pos = ORIGIN findEmptyPosition [0,100,_tipoveh];
			sleep 1;
		};
		if (count _pos == 0) then {_pos = ORIGIN};

		private _vehicle = [_pos, 0, _tipoveh, ("CSAT" call AS_fnc_getFactionSide)] call bis_fnc_spawnvehicle;
		private _heli = _vehicle select 0;
		private _heliCrew = _vehicle select 1;
		private _grupoheli = _vehicle select 2;
		_pilotos append _heliCrew;
		{_x call AS_fnc_initUnitCSAT} forEach _heliCrew;
		_grupos pushBack _grupoheli;
		_vehiculos pushBack _heli;

		if (_tipoveh != opHeliFR) then {
			private _wp1 = _grupoheli addWaypoint [_position, 0];
			_wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn AS_fnc_setConvoyImmune;
		} else {
			{_x setBehaviour "CARELESS";} forEach units _grupoheli;
			private _tipoGrupo = [["CSAT", "squads"] call AS_fnc_getEntity, "CSAT"] call AS_fnc_pickGroup;
			private _grupo = [ORIGIN, ("CSAT" call AS_fnc_getFactionSide), _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _x call AS_fnc_initUnitCSAT} forEach units _grupo;
			_grupos pushBack _grupo;
			[_heli,"CSAT Air Transport"] spawn AS_fnc_setConvoyImmune;

			if (random 100 < 50) then {
				_vehiculos append ([ORIGIN, _position, _grupoheli, _location, _grupo] call AS_tactics_fnc_heli_disembark);
			} else {
				[ORIGIN, _position, _grupoheli, _location, _grupo] call AS_tactics_fnc_heli_fastrope;
			};
		};
		sleep 20;
	};

	private _numCiv = round ((_population * AS_P("civPerc"))/2);
	if (_numCiv < 8) then {_numCiv = 8};

	private _grupoCivil = createGroup ("FIA" call AS_fnc_getFactionSide);
	_grupos pushBack _grupoCivil;

	for "_i" from 0 to _numCiv do {
		private _pos = _position getPos [_size,random 360];
		private _civ = _grupoCivil createUnit [selectRandom (["CIV", "units"] call AS_fnc_getEntity),_pos, [],_size,"NONE"];
		private _rnd = random 100;
		if (_rnd < 90) then {
			if (_rnd < 25) then {
				[_civ, "hgun_PDW2000_F", 5, 0] call BIS_fnc_addWeapon;
			} else {
				[_civ, "hgun_Pistol_heavy_02_F", 5, 0] call BIS_fnc_addWeapon;
			};
		};
		_civilians pushBack _civ;
		[_civ] spawn AS_fnc_initUnitCIV;
		sleep 1;
	};

	[leader _grupoCivil, _location, "AWARE","SPAWNED","NOVEH2"] spawn UPSMON;

	[_location,true] call AS_location_fnc_spawn;
	[_location] spawn AS_fnc_dropArtilleryShells;

	for "_i" from 0 to round random 2 do {
		[_location, selectRandom opCASFW] spawn AS_fnc_activateAirstrike;
	};

	private _soldiers = [];
	{_soldiers append (units _x)} forEach _grupos;

	{if ((surfaceIsWater position _x) and (vehicle _x == _x)) then {_x setDamage 1}} forEach _soldiers;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
    [_mission, "resources", [_task, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_mission, "soldiers", _soldiers] call AS_spawn_fnc_set;
	[_mission, "civilians", _civilians] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;

	private _soldiers = [_mission, "soldiers"] call AS_spawn_fnc_get;
	private _civilians = [_mission, "civilians"] call AS_spawn_fnc_get;

	private _max_incapacitated = round ((count _soldiers)/2);
	private _max_killed_civs = round ((count _civilians)/2);
	private _max_time = time + 60*60;

	private _csat_arrived = false; // true once the CSAT forces arrived the city

	private _fnc_missionFailedCondition = {
		if (not _csat_arrived and {{_x distance _position > 1.5*_size} count _soldiers > _max_incapacitated/2}) then {
			_csat_arrived = true;
		};
		True and _csat_arrived and {{(alive _x) and (_x distance _position < _size*2)} count _civilians > _max_killed_civs}
	};
	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};
	private _fnc_missionSuccessfulCondition = {
		(True and _csat_arrived and
		 {(_x distance _position > 1.5*_size) or
		  not alive _x or
		  captive _x} count _soldiers > _max_incapacitated) or
		{time > _max_time}
	};
	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_success", 2];

		{_x doMove ORIGIN} forEach _soldiers;
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

private _fnc_clean = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	[_location,true] call AS_location_fnc_despawn;
	_mission call AS_mission_spawn_fnc_clean;
};

AS_mission_defendCity_states = ["initialize", "spawn", "run", "clean"];
AS_mission_defendCity_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
