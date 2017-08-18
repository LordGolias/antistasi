enableSaving [false, false];

// set or load AS_profileID. AS_profileID is a "unique" id for every profile that ever runs AS.
// It is used to identify users.
AS_profileID = profileNameSpace getVariable ["AS_profileID", nil];
if(isNil "AS_profileID") then {
	AS_profileID = str(round((random(100000)) + random 10000));
	profileNameSpace setVariable ["AS_profileID", AS_profileID];
};

call compile preprocessFileLineNumbers "scheduler.sqf";
[] spawn AS_scheduler_fnc_initialize;

if (not isDedicated) then {
    // this has to be scheduled because the server is waiting for clients.
	[] execVM "initialization\client.sqf";
} else {
    if not isServer then {
        [] execVM "initialization\headlessClient.sqf";
    };
};
if isServer then {
	[] execVM "initialization\server.sqf";
};
