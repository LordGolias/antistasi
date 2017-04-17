#include "../macros.hpp"
params ["_marcador"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _spatrol = [];

private _posicion = getMarkerPos _marcador;
private _size = [_marcador] call sizeMarker;
private _frontera = [_marcador] call isFrontline;
private _buildings = nearestObjects [_posicion, listMilBld, _size*1.5];
private _busy = if (dateToNumber date > server getVariable _marcador) then {false} else {true};

private _grupo = createGroup side_green;
_grupos pushBack _grupo;

([_marcador, side_green, _grupo] call AS_fnc_populateMilBuildings) params ["_gunners", "_vehicles"];
_soldados pushBack _gunners;
_vehiculos pushBack _vehicles;

// spawn flag and crate
_bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_bandera allowDamage false;
[[_bandera,"take"],"flagaction"] call BIS_fnc_MP;
_veh = "I_supplyCrate_F" createVehicle _posicion;
[_veh, "Watchpost"] call AS_fnc_fillCrateAAF;
_vehiculos append [_bandera, _veh];

// spawn up to 4 mortars
for "_i" from 1 to ((round (_size / 30)) min 4) do {
	if !(spawner getVariable _marcador) exitWith {};
	private _pos = [_posicion] call mortarPos;
	private _veh = statMortar createVehicle _pos;
	[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
	[_veh, "AAF"] call AS_fnc_initVehicle;
	private _unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
	[_unit, false] spawn AS_fnc_initUnitAAF;
	_unit moveInGunner _veh;
	_soldados pushBack _unit;
	_vehiculos pushBack _veh;
	sleep 1;
};

// spawn AT road checkpoint
if ((spawner getVariable _marcador) and _frontera) then {
	([_posicion, _grupo] call AS_fnc_spawnAAF_roadAT) params ["_units1", "_vehicles1"];
	_soldados append _units1;
	_vehiculos append _vehicles1;
};

// spawn parked vehicles
private _groupCount = (round (_size/30)) max 1;

if (!_busy) then {
	_arrayVehAAF = ["trucks", "apcs"] call AS_fnc_AAFarsenal_all;
	private _pos = _posicion;

	for "_i" from 1 to _groupCount do {
		if (!(spawner getVariable _marcador) or diag_fps < AS_P("minimumFPS")) exitWith {};
		private _tipoVeh = _arrayVehAAF call BIS_fnc_selectRandom;
		private _pos = [];
		if (_size > 40) then {
			_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		} else {
			_pos = _pos findEmptyPosition [10,60,_tipoVeh];
		};
		private _veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
		_veh setDir random 360;
		[_veh, "AAF"] call AS_fnc_initVehicle;
		_vehiculos pushBack _veh;
		sleep 1;
	};
};

// spawn patrols
// _mrk => to be deleted at the end
([_marcador, _groupCount] call AS_fnc_spawnAAF_patrol) params ["_units1", "_groups1", "_mrk"];
_spatrol append _units1;
_grupos append _groups1;

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
	 3*({(alive _x) and (!(captive _x)) and (_x distance _posicion < _size)} count _soldados))
};

if ((spawner getVariable _marcador) and (not(_marcador in mrkFIA))) then {
	[_bandera] remoteExec ["mrkWIN",2];
};

waitUntil {sleep 1; not (spawner getVariable _marcador)};

{
	if ((!alive _x) and (not(_x in destroyedBuildings))) then {
		destroyedBuildings pushBack (position _x);
		publicVariableServer "destroyedBuildings"
	};
} forEach _buildings;

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{if (alive _x) then {deleteVehicle _x}} forEach _spatrol;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{
	if (not(_x in staticsToSave)) then {
		if (!([(AS_P("spawnDistance")-_size),1,_x,"BLUFORSpawn"] call distanceUnits)) then {
			deleteVehicle _x
		};
	};
} forEach _vehiculos;
deleteMarker _mrk;
