/*
An API to manage spawns. A spawn is a set of steps with memory that
are executed sequentially.
*/
#include "macros.hpp"

AS_spawn_fnc_initialize = {
    AS_SERVER_ONLY("spawn_fnc_initialize");
    ["spawn", true] call AS_fnc_container_add;
};

// given a spawn type and its name, returns its states and functions
AS_spawn_fnc_states = {
    params ["_type", "_spawn"];
    if (_type == "mission") exitWith {
        _spawn call AS_fnc_mission_spawn_states
    };
    if (_type == "AAFpatrol") exitWith {
        [AS_spawn_patrolAAF_states, AS_spawn_patrolAAF_state_functions]
    };
    if (_type == "AAFroadPatrol") exitWith {
        [AS_spawn_AAFroadPatrol_states, AS_spawn_AAFroadPatrol_state_functions]
    };
    if (_type == "AAFgeneric") exitWith {
        [AS_spawn_AAFgeneric_states, AS_spawn_AAFgeneric_state_functions]
    };
    if (_type == "AAFroadblock") exitWith {
        [AS_spawn_AAFroadblock_states, AS_spawn_AAFroadblock_state_functions]
    };
    if (_type == "AAFhill") exitWith {
        [AS_spawn_createAAFhill_states, AS_spawn_createAAFhill_state_functions]
    };
    if (_type == "AAFhillAA") exitWith {
        [AS_spawn_createAAFhillAA_states, AS_spawn_createAAFhillAA_state_functions]
    };
    if (_type == "AAFoutpost") exitWith {
        [AS_spawn_createAAFoutpost_states, AS_spawn_createAAFoutpost_state_functions]
    };
    if (_type == "AAFoutpostAA") exitWith {
        [AS_spawn_createAAFoutpostAA_states, AS_spawn_createAAFoutpostAA_state_functions]
    };
    if (_type == "AAFbase") exitWith {
        [AS_spawn_createAAFbase_states, AS_spawn_createAAFbase_state_functions]
    };
    if (_type == "AAFairfield") exitWith {
        [AS_spawn_createAAFairfield_states, AS_spawn_createAAFairfield_state_functions]
    };
    if (_type == "AAFcity") exitWith {
        [AS_spawn_createAAFcity_states, AS_spawn_createAAFcity_state_functions]
    };
    if (_type == "CIVcity") exitWith {
        [AS_spawn_createCIVcity_states, AS_spawn_createCIVcity_state_functions]
    };
    if (_type == "FIAgeneric") exitWith {
        [AS_spawn_createFIAgeneric_states, AS_spawn_createFIAgeneric_state_functions]
    };
    if (_type == "FIAairfield") exitWith {
        [AS_spawn_createFIAairfield_states, AS_spawn_createFIAairfield_state_functions]
    };
    if (_type == "FIAbase") exitWith {
        [AS_spawn_createFIAbase_states, AS_spawn_createFIAbase_state_functions]
    };
    if (_type == "FIAbuilt_location") exitWith {
        [AS_spawn_createFIAbuilt_location_states, AS_spawn_createFIAbuilt_location_state_functions]
    };
    if (_type == "minefield") exitWith {
        [AS_spawn_createMinefield_states, AS_spawn_createMinefield_state_functions]
    };

    diag_log format ["[AS] Error: spawn_states: invalid arguments [%1, %2]", _type, _spawn];
    [[], []]  // default is to not do anything (no states)
};

AS_spawn_fnc_spawns = {
    ["spawn"] call AS_fnc_objects
};

AS_spawn_fnc_get = {
    params ["_spawn", "_property"];
    ["spawn", _spawn, _property] call AS_fnc_object_get
};

AS_spawn_fnc_set = {
    params ["_spawn", "_property", "_value"];
    ["spawn", _spawn, _property, _value] call AS_fnc_object_set
};

AS_spawn_fnc_add = {
    params ["_name", "_type"];
    diag_log format ["[AS] %1: new spawn '%2'", clientOwner, _name];
    ["spawn", _name] call AS_fnc_object_add;
    [_name, "state_index", 0] call AS_spawn_fnc_set;
    [_name, "spawn_type", _type] call AS_spawn_fnc_set;
};

AS_spawn_fnc_remove = {
    params ["_name"];
    ["spawn", _name] call AS_fnc_object_remove;
};

// Function to execute a spawn. It
// starts from the state where the spawn was left.
AS_spawn_fnc_execute = {
    params ["_spawn"];

    if not (_spawn in (call AS_spawn_fnc_spawns)) exitWith {
        diag_log format ["[AS] Error: spawn_fnc_execute: spawn '%1' does not exist", _spawn];
    };

    private _type = [_spawn, "spawn_type"] call AS_spawn_fnc_get;

    ([_type, _spawn] call AS_spawn_fnc_states) params ["_states", "_functions"];

    // take ownership of this spawn
    [_spawn, "spawnOwner", clientOwner] call AS_spawn_fnc_set;

    private _state_index = [_spawn, "state_index"] call AS_spawn_fnc_get;
    while {_state_index < count _functions} do {
        diag_log format ["[AS] %1: spawn '%2' started state '%3'", clientOwner, _spawn, _states select _state_index];
        _spawn call (_functions select _state_index);
        diag_log format ["[AS] %1: spawn '%2' finished state '%3'", clientOwner, _spawn, _states select _state_index];
        // the function above can change the `state_index` to a new one. We load it and use it
        _state_index = [_spawn, "state_index"] call AS_spawn_fnc_get;
        _state_index = _state_index + 1;
        [_spawn, "state_index", _state_index] call AS_spawn_fnc_set;
    };
    _spawn call AS_spawn_fnc_remove;
};

// called when a client (owner) drops.
AS_spawn_fnc_drop = {
    AS_SERVER_ONLY("spawn_fnc_drop");
    params ["_owner"];
    private _spawns = call AS_spawn_fnc_spawns;
    // all spawns from the dropped owner
    _spawns = _spawns select {([_x, "spawnOwner"] call AS_spawn_fnc_get) == _owner};

    // delegate the spawns to the server
    {
        // start the UPSMON on all groups that are UPSMON controlled (UPSMON is local)
        private _properties = ["spawn", _x] call AS_fnc_object_properties;
        if ("resources" in _properties) then {
             private _groups = ([_x, "resources"] call AS_spawn_fnc_get) select 1;
            {
                private _upsmon_params = _x getVariable ["AS_UPSMON_controlled", []];
                if (count _upsmon_params != 0) then {
                    _upsmon_params execVM "scripts\UPSMON.sqf";
                };
            } forEach _groups;
        };

        [_x] spawn AS_spawn_fnc_execute;
    } forEach _spawns;
};
