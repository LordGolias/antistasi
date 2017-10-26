#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	private _grupo = createGroup side_red;
	private _grupoCSAT = createGroup side_red;
	private _gns = [];
	private _stcs = [];
	private _vehiculos = [];
	private _grupos = [];
	private _soldados = [];

	private _posicion = _location call AS_location_fnc_position;

	([_location] call AS_fnc_selectHillAAdata) params ["_posCmp", "_cmp"];
	private _objs = [_posCmp, 0, _cmp] call BIS_fnc_ObjectsMapper;

	private _AAVeh = objNull;
	{
		call {
			if (typeOf _x in (["CSAT", "self_aa"] call AS_fnc_getEntity)) exitWith {_AAVeh = _x; _vehiculos pushBack _x;};
			if (typeOf _x in (["CSAT", "trucks"] call AS_fnc_getEntity)) exitWith {[_x, "CSAT"] call AS_fnc_initVehicle;};
			if (typeOf _x == (["CSAT", "static_mortar"] call AS_fnc_getEntity)) then {[_x] execVM "scripts\UPSMON\MON_artillery_add.sqf";};
			if (typeOf _x in AS_allStatics) exitWith {_stcs pushBack _x;};
			if (typeOf _x == (["CSAT", "box"] call AS_fnc_getEntity)) exitWith {_vehiculos pushBack _x;};
			if (typeOf _x == (["CSAT", "flag"] call AS_fnc_getEntity)) exitWith {_vehiculos pushBack _x;};
		};
	} forEach _objs;
	_vehiculos append _objs;

	private _crewType = ["CSAT", "crew"] call AS_fnc_getEntity;

	// init the AA
	if !(isNull _AAVeh) then {
		private _unit = ([_posicion, 0, _crewType, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _AAVeh;
		_unit = ([_posicion, 0, _crewType, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInCommander _AAVeh;
		_AAVeh lock 2;
	};

	{
		_vehiculos pushBack _x;
		{
			private _unit = ([_posicion, 0, _crewType, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
			_unit moveInAny _x;
			_gns pushBack _unit;
		} forEach ([typeof _x, false] call BIS_fnc_crewCount);
	} forEach _stcs;

	private _mrkfin = createMarker [format ["specops%1", random 100],_posCmp];
	_mrkfin setMarkerShape "RECTANGLE";
	_mrkfin setMarkerSize [500,500];
	_mrkfin setMarkerType "hd_warning";
	_mrkfin setMarkerColor "ColorRed";
	_mrkfin setMarkerBrush "DiagGrid";

	{[_x,"CSAT"] call AS_fnc_initVehicle} forEach _vehiculos;

	([_posCmp, _mrkfin] call AS_fnc_spawnCSATuav) params ["_groups", "_vehicles"];
	_vehiculos append _vehicles;
	_grupos append _groups;

	{_x call AS_fnc_initUnitCSAT; _soldados pushBack _x} forEach units _grupoCSAT;
	_grupos pushBack _grupoCSAT;
	[leader _grupoCSAT, _mrkfin, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] spawn UPSMON;

	// AAF teams
	{
		_grupo = [_posicion, side_red, _x] call BIS_Fnc_spawnGroup;
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
	if (!isNull _AAVeh) then {
		_fnc_isAAdestroyed = {(not alive _AAVeh)};
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
