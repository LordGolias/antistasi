// called when a client (owner) drops.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_spawn_fnc_drop");
params ["_owner"];
private _spawns = call AS_spawn_fnc_spawns;
// all spawns from the dropped owner
_spawns = _spawns select {([_x, "spawnOwner"] call AS_spawn_fnc_get) == _owner};

// delegate the spawns to the server
{
    // start the UPSMON on all groups that are UPSMON controlled (UPSMON is local)
    if (["spawn", _x, "resources"] call DICT_fnc_exists) then {
         private _groups = ([_x, "resources"] call AS_spawn_fnc_get) select 1;
        {
            private _upsmon_params = _x getVariable ["AS_UPSMON_controlled", []];
            if (count _upsmon_params != 0) then {
                _upsmon_params spawn UPSMON;
            };
        } forEach _groups;
    };

    [_x] spawn AS_spawn_fnc_execute;
} forEach _spawns;
