#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];
private _soldadosFIA = [];
private _gruposFIA = [];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _estaticas = AS_P("vehicles") select {_x distance _posicion < _size};
private _prestigio = AS_P("NATOsupport")/100;
private _buildings = nearestObjects [_posicion, ["Land_LandMark_F"], _size / 2];

if (count _buildings > 1) then {
	_pos1 = getPos (_buildings select 0);
	_pos2 = getPos (_buildings select 1);
	_ang = [_pos1, _pos2] call BIS_fnc_DirTo;

	private _pos = [_pos1, 5,_ang] call BIS_fnc_relPos;
	private _grupo = createGroup side_blue;
	_grupos pushBack _grupo;
	for "_i" from 1 to (round (5*_prestigio)) do {
		if !(_location call AS_fnc_location_spawned) exitWith {};
		private _tipoveh = (planesNATO - bluCASFW) call BIS_fnc_selectRandom;
		private _veh = createVehicle [_tipoveh, _pos, [],3, "NONE"];
		_veh setDir (_ang + 90);
		[_veh, "NATO"] call AS_fnc_initVehicle;
		_vehiculos pushBack _veh;

		_unit = ([_posicion, 0, bluPilot, _grupo] call bis_fnc_spawnvehicle) select 0;
		[_unit] call AS_fnc_initUnitNATO;
		_soldados pushBack _unit;

		// new position
		_pos = [_pos, 20,_ang] call BIS_fnc_relPos;
		sleep 1;
		};
	[leader _grupo, _location, "SAFE","SPAWNED","NOFOLLOW","NOVEH"] execVM "scripts\UPSMON.sqf";
};

// create flag
private _pos = [_posicion, 3,0] call BIS_fnc_relPos;
_veh = createVehicle [bluFlag, _pos, [],0, "CAN_COLLIDE"];
_veh allowDamage false;
[[_veh,"unit"],"AS_fnc_addAction"] call BIS_fnc_MP;
[[_veh,"vehicle"],"AS_fnc_addAction"] call BIS_fnc_MP;
[[_veh,"garage"],"AS_fnc_addAction"] call BIS_fnc_MP;
_vehiculos pushBack _veh;

// number of vehicles and groups spawned (at least 1)
private _nVeh = (round ((_size/100)*_prestigio)) max 1;

// create vehicles
for "_i" from 1 to _nVeh do {
	if (!(_location call AS_fnc_location_spawned) or (diag_fps < AS_P("minimumFPS"))) exitWith {};

	private _tipoVeh = vehNATO call BIS_fnc_selectRandom;
	private _pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
	private _veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
	_veh setDir random 360;
	_vehiculos pushBack _veh;
	[_veh, "NATO"] call AS_fnc_initVehicle;
	sleep 1;
};
{[_x] spawn cleanserVeh} forEach _vehiculos;

// create NATO garrison (creates at least 1)
for "_i" from 1 to _nVeh do {
	if (!(_location call AS_fnc_location_spawned) or (_i != 1 and diag_fps < AS_P("minimumFPS"))) exitWith {};

	// get random pos
	private _pos = [];
	while {true} do {
		_pos = [_posicion, random _size,random 360] call BIS_fnc_relPos;
		if (!surfaceIsWater _pos) exitWith {};
	};
	private _grupo = [_pos, side_blue, [bluSquad, "NATO"] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
	_grupos pushBack _grupo;
	{[_x] call AS_fnc_initUnitNATO; _soldados pushBack _x} forEach units _grupo;
	[leader _grupo, _location, "SAFE","SPAWNED", "RANDOM","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	sleep 1;
};

// Create FIA garrison
(_location call AS_fnc_createFIAgarrison) params ["_soldados1", "_grupos1", "_vehiculos1"];
_soldadosFIA append _soldados1;
_gruposFIA append _grupos1;
_vehiculos append _vehiculos1;

private _journalist = [_location, _grupos] call AS_fnc_createJournalist;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

waitUntil {sleep 1;
	(not (_location call AS_fnc_location_spawned)) or
	(({not(vehicle _x isKindOf "Air")} count ([_size,0,_posicion,"OPFORSpawn"] call distanceUnits)) >
	 3*(({alive _x} count _soldados) + count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)))};

if (_location call AS_fnc_location_spawned) then {
	[_location] remoteExec ["AS_fnc_location_lose",2];
};

waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};

{
	if (_location call AS_fnc_location_side == "FIA") then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach _soldadosFIA;
{deleteGroup _x} forEach _gruposFIA;

[_grupos, _vehiculos, []] call AS_fnc_cleanResources;
