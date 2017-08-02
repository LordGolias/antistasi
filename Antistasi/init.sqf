enableSaving [ false, false ];
if (isServer and (isNil "serverInitDone")) then {skipTime random 24};

// it is a SP game, initialize the server.
if (!isMultiPlayer) then {
    call compile preprocessFileLineNumbers "debug\init.sqf";
    {
        if (not isPlayer _x) then {
            private _grupete = group _x;
            deleteVehicle _x;
            deleteGroup _grupete;
        };
    } forEach playableUnits;
    diag_log "[AS] Server: start SP";
    call compile preprocessFileLineNumbers "initFuncs.sqf";
    diag_log "[AS] Server SP: initFuncs finished";
    call compile preprocessFileLineNumbers "initLocations.sqf";
    diag_log "[AS] Server SP: initLocations finished";
    call compile preprocessFileLineNumbers "initVar.sqf";
    diag_log "[AS] Server SP: initVar finished";

    HCciviles = 2;
    HCgarrisons = 2;
    HCattack = 2;
    hcArray = [HC1,HC2,HC3];
    serverInitDone = true;
    diag_log "[AS] Server SP: serverInitDone.";
    [] execVM "modBlacklist.sqf";
};

waitUntil {(!isNil "saveFuncsLoaded") and (!isNil "serverInitDone")};


// set or load AS_profileID. AS_profileID is a "unique" id for every profile that ever runs AS.
// It is used to identify users.
AS_profileID = profileNameSpace getVariable ["AS_profileID", nil];
if(isNil "AS_profileID") then {
	AS_profileID = str(round((random(100000)) + random 10000));
	profileNameSpace setVariable ["AS_profileID", AS_profileID];
};

if(isServer) then {
	miembros = [];
    if (serverName in servidoresOficiales) then
        {
		[] execVM "orgPlayers\mList.sqf";
        ["miembros"] call fn_LoadStat;
        {
            if (([_x] call isMember) and (isNull AS_commander)) then {
                AS_commander = _x;
            };
        } forEach playableUnits;
        publicVariable "AS_commander";
        if (isNull AS_commander) then
            {
            [] execVM "statSave\loadAccount.sqf"; switchCom = false; publicVariable "switchCom";
            diag_log "Antistasi MP Server. Players are in, no members";
            }
        else
            {
            diag_log "Antistasi MP Server. Players are in, member detected";
            };
        }
    else
        {
        waitUntil {!isNil "AS_commander"};
        waitUntil {isPlayer AS_commander};
        };
    publicVariable "miembros";
    fpsCheck = [] execVM "fpsCheck.sqf";
    waitUntil {!(isNil "placementDone")};
    [caja, 10] call AS_fnc_fillCrateNATO;
    [] spawn AS_fnc_spawnLoop;
    resourcecheck = [] execVM "resourcecheck.sqf";
    if (serverName in servidoresOficiales) then {
        [] execVM "orgPlayers\mList.sqf";
    };
};

[] execVM "Scripts\fn_advancedTowingInit.sqf";
