/*
    Code that only runs on the server of a multiplayer game.
*/
if (!isMultiplayer) exitWith {};
if (!(isNil "serverInitDone")) exitWith {};
diag_log "Antistasi MP Server init";
call compile preprocessFileLineNumbers "initFuncs.sqf";
diag_log "Antistasi MP Server.initFuncs finished";
call compile preprocessFileLineNumbers "initVar.sqf";
diag_log "Antistasi MP Server. initVar finished";
call compile preprocessFileLineNumbers "initZones.sqf";
diag_log "Antistasi MP Server. initZones finished";

call compile preprocessFileLineNumbers "initPetros.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;

// tell every client that the server is ready to receive players (see initPlayerLocal.sqf)
serverInitVarsDone = true; publicVariable "serverInitVarsDone";

waitUntil {(count playableUnits) > 0};
waitUntil {({(isPlayer _x) and (!isNull _x) and (_x == _x)} count allUnits) == (count playableUnits)};//ya estamos todos
[] execVM "modBlacklist.sqf";

addMissionEventHandler ["HandleDisconnect",{[_this select 0] call onPlayerDisconnect;false}];

stavros = objNull;
maxPlayers = playableSlotsNumber west;
if (serverName in servidoresOficiales) then
    {
    [] execVM "serverAutosave.sqf";
    }
else
    {
    if (isNil "comandante") then {comandante = (playableUnits select 0)};
    if (isNull comandante) then {comandante = (playableUnits select 0)};
    {
    if (_x!=comandante) then
        {
        //_x setVariable ["score", 0,true];
        }
    else
        {
        stavros = _x;
        publicVariable "stavros";
        _x setRank "CORPORAL";
        [_x,"CORPORAL"] remoteExec ["ranksMP"];
        //_x setVariable ["score", 25,true];
        };
    } forEach playableUnits;
    diag_log "Antistasi MP Server. Players are in";
    };
publicVariable "maxPlayers";

hcArray = [];

//{if (owner _x != owner server) then {hcArray pushBack _x}} forEach entities "HeadlessClient_F";

if (!isNil "HC1") then {hcArray pushBack HC1};
if (!isNil "HC2") then {hcArray pushBack HC2};
if (!isNil "HC3") then {hcArray pushBack HC3};

HCciviles = 2;
HCgarrisons = 2;
HCattack = 2;
if (count hcArray > 0) then
    {
    HCciviles = hcArray select 0;
    HCgarrisons = hcArray select 0;
    HCattack = hcArray select 0;
    diag_log "Antistasi MP Server. Headless Client 1 detected";
    if (count hcArray > 1) then
        {
        HCciviles = hcArray select 1;
        HCattack = hcArray select 1;
        diag_log "Antistasi MP Server. Headless Client 2 detected";
        if (count hcArray > 2) then
            {
            HCciviles = hcArray select 2;
            diag_log "Antistasi MP Server. Headless Client 3 detected";
            };
        };
    };

publicVariable "HCciviles";
publicVariable "HCgarrisons";
publicVariable "HCattack";
publicVariable "hcArray";

caja addEventHandler ["ContainerOpened",
    {
    _jugador = _this select 1;
    if (not([_jugador] call isMember)) then
        {
        _jugador setPos position petros;
        "You are not in the Member's List of this Server.\n\nAsk the Commander in order to be allowed to access the HQ Ammobox.\n\nIn the meantime you may use the other box to store equipment and share it with others." remoteExecCall ["hint", _jugador];
        };
    }
];

serverInitDone = true; publicVariable "serverInitDone";
diag_log "Antistasi MP Server. serverInitDone set to true.";