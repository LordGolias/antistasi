#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith {};

private ["_escarretera","_tam","_road","_veh","_grupo","_unit","_roadcon"];

private _posicion = _location call AS_fnc_location_position;
private _grupo = createGroup side_blue;

// find road
private _tam = 1;
private _roads = [];
while {true} do {
	_road = _posicion nearRoads _tam;
	if (count _road > 0) exitWith {};
	_tam = _tam + 5;
};
private _road = (_roads select 0);

private _dirveh = [_road, (roadsConnectedto _road) select 0] call BIS_fnc_DirTo;

// spawn the structures
private _composition = "Compositions\cmpNATO_RB.sqf";
if (hayRHS) then {
	_composition = "Compositions\cmpUSAF_RB.sqf";
};
private _objs = [getpos _road, _dirveh, call compile preprocessFileLineNumbers _composition] call BIS_fnc_ObjectsMapper;

private _vehArray = [];
private _turretArray = [];
private _tempPos = [];
{
	call {
		if (typeOf _x in bluAPC) exitWith {_vehArray pushBack _x;};
		if (typeOf _x in bluStatHMG) exitWith {_turretArray pushBack _x;};
		if (typeOf _x in bluStatAA) exitWith {_turretArray pushBack _x;};
		if (typeOf _x == "Land_Camping_Light_F") exitWith {_tempPos = _x;};
	};
} forEach _objs;

// spawn crew for statics
{
	// AAs are not spawned below 50
	if (AS_P("prestigeNATO") < 50 and (typeOf _x in bluStatAA)) then {
		_x enableSimulation false;
	    _x hideObjectGlobal true;
	} else {
		_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _x;
		[_x, "NATO"] call AS_fnc_initVehicle;
	};
} forEach _turretArray;

// spawn crew for vehicles
{
	[_x, "NATO"] call AS_fnc_initVehicle;
	_x allowCrewInImmobile true;
	_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _x;
	_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
	_unit moveInCommander _x;
} forEach _vehArray;

// init units
{[_x] spawn NATOinitCA} forEach units _grupo;

// spawn infantry group
private _grupoInf = [getpos _tempPos, side_blue,
	[bluATTeam, side_blue] call fnc_pickGroup] call BIS_Fnc_spawnGroup;

_infdir = _dirveh + 180;
if (_infdir >= 360) then {_infdir = _infdir - 360};
_grupoInf setFormDir _infdir;

{[_x] spawn NATOinitCA} forEach units _grupoInf;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

private _fnc_isDestroyed = {
	({alive _x} count units _grupo == 0) and
	({alive _x} count units _grupoInf == 0)
};

waitUntil {sleep 1;
	!(_location call AS_fnc_location_spawned) or
	!(_location call AS_fnc_location_exists) or
	(call _fnc_isDestroyed)
};

// Lost the outpost
if (call _fnc_isDestroyed) then {
	_location call AS_fnc_location_delete;
	[5,-5,_posicion] remoteExec ["citySupportChange",2];
	[["TaskFailed", ["", "Roadblock Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
};

waitUntil {sleep 1;
	!(_location call AS_fnc_location_spawned) or
	!(_location call AS_fnc_location_exists)
};

{deleteVehicle _x} forEach _objs;
{deleteVehicle _x} forEach units _grupo;
deleteGroup _grupo;

{deleteVehicle _x} forEach units _grupoInf;
deleteGroup _grupoInf;
