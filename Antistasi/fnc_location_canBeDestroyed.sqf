#include "macros.hpp"
params ["_location", "_civilians"];

while {_location call AS_location_fnc_spawned} do {
	if ({(alive _x) and (not(isNull _x))} count _civilians == 0) exitWith {
		[_location] remoteExec ["AS_fnc_destroy_location", 2];
	};
	sleep 5;
};
