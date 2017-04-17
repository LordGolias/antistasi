#include "../macros.hpp"
params ["_marcador"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _posicion = getMarkerPos (_marcador);
private _size = [_marcador] call sizeMarker;
private _frontera = [_marcador] call isFrontline;
private _busy = if (dateToNumber date > server getVariable _marcador) then {false} else {true};

// spawn flag
private _flag = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_flag allowDamage false;
[[_flag,"take"],"flagaction"] call BIS_fnc_MP;
_vehiculos pushBack _flag;

// spawn crate
private _veh = "I_supplyCrate_F" createVehicle _posicion;
[_veh, "Airbase"] call AS_fnc_fillCrateAAF;
_vehiculos pushBack _veh;

// spawn AT road block
if ((spawner getVariable _marcador) and _frontera) then {
	([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
	_soldados append _units1;
	_vehiculos append _vehicles1;
};

// spawn 4 patrols
// _mrk => to be deleted at the end
([_marcador, 4] call AS_fnc_spawnAAF_patrol) params ["_units1", "_groups1", "_mrk"];
_spatrol append _units1;
_grupos append _groups1;

// spawn parked air vehicles
if (!_busy) then {
	private _buildings = nearestObjects [_posicion, ["Land_LandMark_F"], _size / 2];
	if (count _buildings > 1) then {
		private _pos1 = getPos (_buildings select 0);
		private _pos2 = getPos (_buildings select 1);
		private _ang = [_pos1, _pos2] call BIS_fnc_DirTo;

		private _pos = [_pos1, 5,_ang] call BIS_fnc_relPos;
		private _grupo = createGroup side_green;
		_grupos pushBack _grupo;

		for "_i" from 1 to 5 do {
			if !(spawner getVariable _location) exitWith {};

			_tipoveh = (["planes", "armedHelis", "transportHelis"] call AS_fnc_AAFarsenal_all) call BIS_fnc_selectRandom;
			private _veh = createVehicle [_tipoveh, _pos, [],3, "NONE"];
			_veh setDir (_ang + 90);
			sleep 1;
			_vehiculos pushBack _veh;
			[_veh, "AAF"] call AS_fnc_initVehicle;
			private _pos = [_pos, 20,_ang] call BIS_fnc_relPos;
			private _unit = ([_posicion, 0, infPilot, _grupo] call bis_fnc_spawnvehicle) select 0;
			[_unit, false] spawn AS_fnc_initUnitAAF;
			_soldados pushBack _unit;
		};
		[leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH"] execVM "scripts\UPSMON.sqf";
		sleep 1;
	};
};

// spawn parked land vehicles
private _groupCount = round (_size/60);
for "_i" from 1 to _groupCount do {
	if (!(spawner getVariable _marcador) or diag_fps < AS_P("minimumFPS")) exitWith {};
	private _tipoVeh = (["trucks", "apcs"] call AS_fnc_AAFarsenal_all) call BIS_fnc_selectRandom;
	_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
	_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
	_veh setDir random 360;
	_vehiculos pushBack _veh;
	[_veh, "AAF"] call AS_fnc_initVehicle;
	sleep 1;
};

// spawn guarding squads
if (_frontera) then {_groupCount = _groupCount * 2};
([_marcador, 1 + _groupCount] call AS_fnc_spawnAAF_patrolSquad) params ["_units1", "_groups1"];
_soldados append _units1;
_grupos append _groups1;

private _journalist = [_marcador, _grupos] call AS_fnc_createJournalist;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

waitUntil {sleep 1;
	(not (spawner getVariable _marcador)) or
	(({(not(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) >
	 3*({(alive _x) and (!(captive _x)) and (_x distance _posicion < _size)} count _soldados))};

if ((spawner getVariable _marcador) and (not(_marcador in mrkFIA))) then {
	[_flag] remoteExec ["mrkWIN",2];
};

waitUntil {sleep 1; not (spawner getVariable _marcador)};

deleteMarker _mrk;
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{if (!([AS_P("spawnDistance")-_size,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x}} forEach _vehiculos;
