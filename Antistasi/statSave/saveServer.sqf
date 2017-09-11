#include "../macros.hpp"
AS_SERVER_ONLY("statSave/saveServer.sqf");
params ["_saveName"];

if (!isNil "AS_savingServer") exitWith {
    ["Canceled: save already in process."] remoteExecCall ["hint",AS_commander];
    diag_log "[AS] Server: saving already in progress...";
};
AS_savingServer = true;
["Saving game..."] remoteExecCall ["hint",AS_commander];
diag_log "[AS] Server: saving game...";

// spawn and wait for all clients to report their data.
private _savingPlayersHandle = ([_saveName] spawn {
    params ["_saveName"];
    call AS_fnc_getPlayersData;
    // todo: This is bad: we want to wait for every client to answer or timeout.
    sleep 5;  // brute force method of waiting for every client...
    [_saveName] call AS_fnc_savePlayers;
});

[_saveName, "BE_data", ([] call fnc_BE_save)] call AS_fnc_saveStat;

[_saveName, "miembros", miembros] call AS_fnc_saveStat;
[_saveName, "fecha", date] call AS_fnc_saveStat;

[_saveName] call AS_AAFarsenal_fnc_save;

diag_log "[AS] Server: saving locations...";
[_saveName, "AS_locations", call AS_fnc_location_serialize] call AS_fnc_saveStat;
[_saveName] call AS_fnc_saveHQ;

diag_log "[AS] Server: saving arsenal...";
// save all units as hr and money.
private _resfondo = AS_P("resourcesFIA");

private _cargoArray = [caja, true] call AS_fnc_getBoxArsenal;  // restricted to locked weapons
private _cargo_w = _cargoArray select 0;
private _cargo_m = _cargoArray select 1;
private _cargo_i = _cargoArray select 2;
private _cargo_b = _cargoArray select 3;

{
    if (_x getVariable ["BLUFORSpawn",false] and
            {alive _x} and
            {!isPlayer _x} and
            {isPlayer leader _x or (group _x) in (hcAllGroups AS_commander)} and
            {not(group _x getVariable ["esNATO",false])}) then {
        if (isPlayer (leader group _x)) then {
            if (!isMultiplayer) then {
                private _precio = AS_data_allCosts getVariable (_x call AS_fnc_getFIAUnitName);
                if (!(isNil "_precio")) then {_resfondo = _resfondo + _precio};
            };
            private _arsenal = [_x, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
            _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
            _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
            _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
            _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
        };
        // there is a vehicle in the group
        if (vehicle _x != _x) then {
            private _veh = vehicle _x;
            private _tipoVeh = typeOf _veh;
            if (not(_veh in AS_P("vehicles")) and {(_veh isKindOf "StaticWeapon") or (driver _veh == _x)} and
                {(group _x in (hcAllGroups AS_commander)) or (!isMultiplayer)}) then {
                    _resfondo = _resfondo + ([_tipoVeh] call FIAvehiclePrice);
                    if (count attachedObjects _veh != 0) then {
                        {_resfondo = _resfondo + ([typeOf _x] call FIAvehiclePrice)} forEach attachedObjects _veh
                    };
            };
        };
    };
} forEach allUnits;

private _hrfondo = AS_P("hr") + ({(alive _x) and (not isPlayer _x) and (_x getVariable ["BLUFORSpawn",false]) and {not(group _x getVariable ["esNATO",false])}} count allUnits);
[_saveName, ["resourcesFIA", "hr"], [_resfondo, _hrfondo]] call AS_fnc_savePersistents;

if (isMultiplayer) then {
    {
        private _arsenal = [_x, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
        _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
        _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
        _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
        _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
    } forEach playableUnits;
}
else {
    private _arsenal = [player, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
    _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
    _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
    _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
    _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
};

// list of locations where static weapons are saved.
private _statMrks = [];
{
    _statMrks pushBack _x;
} forEach ("FIA" call AS_fnc_location_S);

// store in "_arrayEst" the list of vehicles.
private _arrayEst = [];
{
    private _veh = _x;
    private _tipoVeh = typeOf _veh;

    private _test = [_statMrks, getPos _veh] call BIS_fnc_nearestPosition;
    private _testDist = _veh distance (getMarkerPos _test);

    // saves static weapons everywhere.
    if ((_veh isKindOf "StaticWeapon") and (_testDist < 50)) then {
        _arrayEst = _arrayEst + [[_tipoVeh,getPos _veh,getDir _veh]];
    };

    // saves vehicles close to the HQ.
    if (_veh distance getMarkerPos "FIA_HQ" < 50) then {
        if (!(_veh isKindOf "StaticWeapon") and
            !(_veh isKindOf "ReammoBox") and
            !(_veh isKindOf "FlagCarrier") and
            !(_veh isKindOf "Building") and
            !(_tipoVeh in planesNATO) and
            !(_tipoVeh in vehNATO) and
            (count attachedObjects _veh == 0) and
            (alive _veh) and
            ({(alive _x) and (!isPlayer _x)} count crew _veh == 0) and
            !(_tipoVeh == "WeaponHolderSimulated")) then {
            _arrayEst = _arrayEst + [[_tipoVeh, getPos _veh, getDir _veh]];

            private _arsenal = [_veh, true] call AS_fnc_getBoxArsenal;  // restricted to locked weapons
            _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
            _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
            _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
            _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
        };
    };
} forEach vehicles - AS_permanent_HQplacements;

[_saveName, "estaticas", _arrayEst] call AS_fnc_saveStat;

[_saveName, _cargo_w, _cargo_m, _cargo_i, _cargo_b] call AS_fnc_saveArsenal;

diag_log "[AS] Server: saving missions...";
[_saveName] call AS_fnc_mission_save;

// if the spawning is faster, let us wait until it is finished.
diag_log "[AS] Server: saving players...";
waitUntil {scriptDone _savingPlayersHandle};

[] call fn_SaveProfile;

AS_savingServer = nil;

diag_log "[AS] Server: saving completed.";
["Game saved"] remoteExecCall ["hint",AS_commander];
