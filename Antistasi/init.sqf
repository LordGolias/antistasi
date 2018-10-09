enableSaving [false, false];

if hasInterface then {
	// this has to be scheduled because the server is waiting for clients.
	[] execVM "initialization\client.sqf";
} else {
	if not isDedicated then {
		[] execVM "initialization\headlessClient.sqf";
	};
};
if isServer then {
	[] execVM "initialization\server.sqf";
};

#include "Scripts\SHK_Fastrope.sqf"
