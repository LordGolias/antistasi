#include "macros.hpp"
AS_SERVER_ONLY("fnc_destroy_location.sqf");

params ["_location", ["_add", true]];

private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;
private _side = _location call AS_location_fnc_size;

private _buildings = _posicion nearObjects ["house",_size];

{
	if (random 100 < 70) then {
		for "_i" from 1 to 7 do {
			_x sethit [format ["dam%1",_i],1];
			_x sethit [format ["dam %1",_i],1];
		};
	} else {
		_x setDamage 1;
	};
} forEach _buildings;

if (_location call AS_location_fnc_type == "powerplant") then {
	[_location] call AS_fnc_recomputePowerGrid;
};

if _add then {
	AS_Pset("destroyedLocations", AS_P("destroyedLocations") + [_location]);
};

if (count (AS_P("destroyedLocations") arrayIntersect (call AS_location_fnc_cities)) > 7) then {
	 "destroyedCities" call BIS_fnc_endMissionServer;
};
