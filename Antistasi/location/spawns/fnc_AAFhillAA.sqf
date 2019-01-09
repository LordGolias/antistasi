#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	private _grupo = createGroup ("AAF" call AS_fnc_getFactionSide);
	private _grupoCSAT = createGroup ("CSAT" call AS_fnc_getFactionSide);
	private _gns = [];
	private _stcs = [];
	private _vehiculos = [];
	private _grupos = [];
	private _soldados = [];
	private _posicion = _location call AS_location_fnc_position;
	private _objects = _location call AS_fnc_spawnComposition;
	private _AAVeh = [];
	
	{
		call {
			if (typeOf _x == (["CSAT", "self_aa"] call AS_fnc_getEntity)) exitWith {_AAVeh pushBack _x; _vehiculos pushBack _x;};
			if (typeOf _x == (["CSAT", "track_aa"] call AS_fnc_getEntity)) exitWith {_AAVeh pushBack _x; _vehiculos pushBack _x;};
			if (typeOf _x in (["CSAT", "trucks"] call AS_fnc_getEntity)) exitWith {[_x, "CSAT"] call AS_fnc_initVehicle;};
			if (typeOf _x == (["CSAT", "static_mortar"] call AS_fnc_getEntity)) exitWith {[_x] execVM "scripts\UPSMON\MON_artillery_add.sqf"; _stcs pushBack _x};
			if (typeOf _x == (["CSAT", "static_mg"] call AS_fnc_getEntity)) exitWith {_stcs pushBack _x;};
			if (typeOf _x == (["CSAT", "box"] call AS_fnc_getEntity)) exitWith {_vehiculos pushBack _x;};
			if (typeOf _x == (["CSAT", "flag"] call AS_fnc_getEntity)) exitWith {_vehiculos pushBack _x;};
		};
	} forEach _objects;
	_vehiculos append _objects;

	private _crewType = ["CSAT", "crew"] call AS_fnc_getEntity;

	// init the AA
	if !(isnil "_AAVeh") then {
		{
		private _unit = ([_posicion, 0, _crewType, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _x;
		_unit = ([_posicion, 0, _crewType, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInCommander _x;
		} forEach _AAVeh;
	};

	{
		private _unit = ([_posicion, 0, _crewType, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInAny _x;
		_gns pushBack _unit;
	} forEach _stcs;

	private _mrkfin = createMarker [format ["specops%1", random 100],_posicion];
	_mrkfin setMarkerShape "RECTANGLE";
	_mrkfin setMarkerSize [500,500];
	_mrkfin setMarkerType "hd_warning";
	_mrkfin setMarkerColor "ColorRed";
	_mrkfin setMarkerBrush "DiagGrid";

	{[_x,"CSAT"] call AS_fnc_initVehicle} forEach _vehiculos;

	([_posicion, _mrkfin] call AS_fnc_spawnCSATuav) params ["_groups", "_vehicles"];
	_vehiculos append _vehicles;
	_grupos append _groups;

	{_x call AS_fnc_initUnitCSAT; _soldados pushBack _x} forEach units _grupoCSAT;
	_grupos pushBack _grupoCSAT;
	[leader _grupoCSAT, _mrkfin, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] spawn UPSMON;

	// AAF teams
	{
		_grupo = [_posicion, ("AAF" call AS_fnc_getFactionSide), _x] call BIS_Fnc_spawnGroup;
		_grupos pushBack _grupo;
		{[_x, false] call AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
		[leader _grupo, _location, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] spawn UPSMON;
		sleep 1;
	} forEach [
		[["AAF", "teamsAA"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup,
		[["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup
	];

	[_location, "resources", [taskNull, _grupos, _vehiculos, [_mrkfin]]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;

	[_location, "AAvehicle", _AAVeh] call AS_spawn_fnc_set;
	[_location, "statics", _gns] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_location"];
	private _posicion = _location call AS_location_fnc_position;

	private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;
	private _AAVeh = [_location, "AAvehicle"] call AS_spawn_fnc_get;
	private _gns = [_location, "statics"] call AS_spawn_fnc_get;

	// 2/3 killed or fleeing and all gunners dead
	private _maxSol = count _soldados;

	private _fnc_isCleaned = {
		({_x call AS_fnc_canFight} count _soldados < (_maxSol / 3)) and
		({alive _x} count _gns == 0)
	};
	// and AA destroyed
	private _fnc_isAAdestroyed = {true};
	if !(isnil "_AAVeh") then {
		_fnc_isAAdestroyed = {{alive _x} count _AAVeh == 0};
	};

	waitUntil {sleep 1;
		!(_location call AS_location_fnc_spawned) or
		(call _fnc_isAADestroyed) and (call _fnc_isCleaned)};

	if ((call _fnc_isAADestroyed) and (call _fnc_isCleaned)) then {
		[-5,0,_posicion] remoteExec ["AS_fnc_changeCitySupport",2];
		[0,-10] remoteExec ["AS_fnc_changeForeignSupport",2];
		[["TaskSucceeded", ["", "Outpost Cleansed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;

		[_location,"side","FIA"] call AS_location_fnc_set;

		[[_posicion], "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];
		["cl_loc"] remoteExec ["fnc_BE_XP", 2];
	};
};

AS_spawn_createAAFhillAA_states = ["spawn", "wait_capture", "clean"];
AS_spawn_createAAFhillAA_state_functions = [
	_fnc_spawn,
	_fnc_run,
	AS_location_spawn_fnc_AAFlocation_clean
];
