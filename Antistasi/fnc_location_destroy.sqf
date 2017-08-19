#include "macros.hpp"
AS_SERVER_ONLY("fnc_location_destroy.sqf");

params ["_location", ["_add", true]];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _side = _location call AS_fnc_location_size;

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

if (_location call AS_fnc_location_type == "powerplant") then {
	[_location] call powerReorg;
};

if _add then {
	AS_Pset("destroyedLocations", AS_P("destroyedLocations") + [_location]);
};

if (count (AS_P("destroyedLocations") arrayIntersect (call AS_fnc_location_cities)) > 7) then {
	 ["destroyedCities",false,true] remoteExec ["BIS_fnc_endMission",0];
};
