#include "macros.hpp"
AS_SERVER_ONLY("spawnToogle.sqf");
params ["_on"];

if isNil "AS_spawning" then {
	AS_spawning = false;
};

if (not AS_spawning and _on) then {
	AS_spawning = true;
	diag_log "[AS] Server: spawn loop started.";

	[] spawn {
		while {AS_spawning} do {
			call AS_fnc_spawnUpdate;
			sleep AS_spawnLoopTime;
		};
	};
};

if (AS_spawning and not _on) then {
	AS_spawning = false;
	diag_log "[AS] Server: spawn loop stopped.";
};
