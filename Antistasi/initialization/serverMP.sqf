waitUntil {(count playableUnits) > 0};
waitUntil {({(isPlayer _x) and (!isNull _x) and (_x == _x)} count allUnits) == (count playableUnits)};

[] execVM "Scripts\fn_advancedTowingInit.sqf"; // the installation is done for all clients by this
[] execVM "modBlacklist.sqf";

addMissionEventHandler ["HandleDisconnect", {[_this select 0] call onPlayerDisconnect;false}];

maxPlayers = playableSlotsNumber west;
publicVariable "maxPlayers";
AS_commander = playableUnits select 0;
AS_commander setUnitRank "CORPORAL";
publicVariable "AS_commander";

diag_log "[AS] Server MP: players are in";

hcArray = [];
if (!isNil "HC1") then {hcArray pushBack HC1};
if (!isNil "HC2") then {hcArray pushBack HC2};
if (!isNil "HC3") then {hcArray pushBack HC3};

HCciviles = 2;
HCgarrisons = 2;
HCattack = 2;
if (count hcArray > 0) then {
    HCciviles = hcArray select 0;
    HCgarrisons = hcArray select 0;
    HCattack = hcArray select 0;
    diag_log "[AS] Server: Headless Client 1 detected";
    if (count hcArray > 1) then {
        HCciviles = hcArray select 1;
        HCattack = hcArray select 1;
        diag_log "[AS] Server: Headless Client 2 detected";
        if (count hcArray > 2) then {
            HCciviles = hcArray select 2;
            diag_log "[AS] Server: Headless Client 3 detected";
        };
    };
};

publicVariable "HCciviles";
publicVariable "HCgarrisons";
publicVariable "HCattack";
publicVariable "hcArray";
