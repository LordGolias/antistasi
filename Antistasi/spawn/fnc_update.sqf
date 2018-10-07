#include "../macros.hpp"
AS_SERVER_ONLY("AS_spawn_fnc_update");

// get units that spawn locations
private _spawningBLUFORunits = [];
private _spawningOPFORunits = [];
{
    if (_x getVariable ["BLUFORSpawn",false]) then {
        _spawningBLUFORunits pushBack _x;
        if (isPlayer _x) then {
            if (!isNull (getConnectedUAV _x)) then {
                _spawningBLUFORunits pushBack (getConnectedUAV _x);
            };
        };
    } else {
        if (_x getVariable ["OPFORSpawn",false]) then {
            _spawningOPFORunits pushBack _x;
        };
    };
} forEach allUnits;

// check whether a location is spawned or not
{ // forEach location
    private _position = _x call AS_location_fnc_position;
    private _isSpawned = _x call AS_location_fnc_spawned;

    if (_x call AS_location_fnc_side == "AAF") then {
        private _spawnCondition = (_x call AS_location_fnc_forced_spawned) or {{(_x distance _position < AS_P("spawnDistance"))} count _spawningBLUFORunits > 0};
        if (!_isSpawned and _spawnCondition) then {
            _x call AS_location_fnc_spawn;

            [_x, "location"] call AS_spawn_fnc_add;
            [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;

            private _type = _x call AS_location_fnc_type;
            if (_type == "city") then {
                ["civ_" + _x, "location"] call AS_spawn_fnc_add;
                ["civ_" + _x, "location", _x] call AS_spawn_fnc_set;
                [["civ_" + _x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
            };
        };
        if (_isSpawned and !_spawnCondition) then {
            _x call AS_location_fnc_despawn;
        };
    };
    if (_x call AS_location_fnc_side == "FIA") then {
        // not clear what this is doing. owner is about who controls it, not something else.
        private _playerIsClose = (_x call AS_location_fnc_forced_spawned) or
                                 {{not (_x call AS_fnc_controlsAI) and {_x distance _position < AS_P("spawnDistance")}} count _spawningBLUFORunits > 0};
        // enemies are close.
        private _spawnCondition = _playerIsClose or {{_x distance _position < AS_P("spawnDistance")} count _spawningOPFORunits > 0};
        if (!_isSpawned and _spawnCondition) then {
            _x call AS_location_fnc_spawn;

            [_x, "location"] call AS_spawn_fnc_add;
            [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;

            private _type = _x call AS_location_fnc_type;
            if (_type == "city") then {
                ["civ_" + _x, "location"] call AS_spawn_fnc_add;
                ["civ_" + _x, "location", _x] call AS_spawn_fnc_set;
                [["civ_" + _x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
            };
        };
        if (_isSpawned and !_spawnCondition) then {
            _x call AS_location_fnc_despawn;
        };
    };
} forEach (call AS_location_fnc_all);
