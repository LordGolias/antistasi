#include "macros.hpp"
params ["_location", "_civilians"];

while {_location call AS_fnc_location_spawned} do {
	if ({(alive _x) and (not(isNull _x))} count _civilians == 0) exitWith {
		AS_Pset("destroyedLocations", AS_P("destroyedLocations") + [_location]);
		[["TaskFailed", ["", format ["%1 Destroyed",[_location] call localizar]]], "BIS_fnc_showNotification"] call BIS_fnc_MP;
		if (_location call AS_fnc_location_type == "powerplant") then {
			[_location] remoteExec ["powerReorg",2];
		};
	};
	sleep 5;
};
