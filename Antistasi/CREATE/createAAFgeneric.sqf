#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith{};

private _soldados = [];
private _grupos = [];
private _vehiculos = [];
private _civs = [];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _isDestroyed = _location in AS_P("destroyedLocations");

// spawn flag
private _flag = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_flag allowDamage false;
[[_flag,"take"],"AS_fnc_addAction"] call BIS_fnc_MP;
_vehiculos pushBack _flag;

// spawn 2 patrols
// _mrk => to be deleted at the end
([_location, 2] call AS_fnc_spawnAAF_patrol) params ["_units1", "_groups1", "_mrk"];
_soldados append _units1;
_grupos append _groups1;

// spawn workers
if !(_isDestroyed) then {
	if ((daytime > 8) and (daytime < 18)) then {
		private _grupo = createGroup civilian;
		_grupos pushBack _grupo;

		for "_i" from 1 to 8 do {
			_civ = _grupo createUnit ["C_man_w_worker_F", _posicion, [],0, "NONE"];
			[_civ] call AS_fnc_initUnitCIV;
			_civs pushBack _civ;
		};
		[_location, _civs] spawn destroyCheck;
		[leader _grupo, _location, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX","NOVEH2"] execVM "scripts\UPSMON.sqf";
	};
};

// spawn truck
([_location] call AS_fnc_spawnAAF_truck) params ["_vehicles1"];
_vehiculos append _vehicles1;

// spawn guarding squads
private _groupCount = round (_size/50);
if (_location call isFrontline) then {_groupCount = _groupCount * 2};
_groupCount = _groupCount max 1;

([_location, _groupCount] call AS_fnc_spawnAAF_patrolSquad) params ["_units1", "_groups1"];
_soldados append _units1;
_grupos append _groups1;

private _journalist = [_location, _grupos] call AS_fnc_createJournalist;

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

waitUntil {sleep 1;
	!(_location call AS_fnc_location_spawned) or
	(({(not(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) >
	3*({(alive _x) and (!(captive _x)) and (_x distance _posicion < _size)} count _soldados))
};

if ((_location call AS_fnc_location_spawned) and (_location call AS_fnc_location_side == "AAF")) then {
	[_flag] remoteExec ["mrkWIN",2];
};

waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};

deleteMarker _mrk;
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteVehicle _x} forEach _civs;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{
	if (!([AS_P("spawnDistance")-_size,1,_x,"BLUFORSpawn"] call distanceUnits)) then {
		deleteVehicle _x
	};
} forEach _vehiculos;
