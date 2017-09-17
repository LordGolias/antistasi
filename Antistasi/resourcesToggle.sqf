#include "macros.hpp"
AS_SERVER_ONLY("resourcesToogle.sqf");
params ["_on"];

if isNil "AS_resourcing" then {
	AS_resourcing = false;
};

if (not AS_resourcing and _on) then {
	AS_resourcing = true;
	diag_log "[AS] Server: resources loop started.";

	[] spawn {
		while {AS_resourcing} do {
			call AS_fnc_resourcesUpdate;
			sleep AS_resourcesLoopTime;
		};
	};
};

if (AS_resourcing and not _on) then {
	AS_resourcing = false;
	diag_log "[AS] Server: resources loop stopped.";
};
