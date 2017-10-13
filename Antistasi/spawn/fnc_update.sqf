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
            private _type = _x call AS_location_fnc_type;
            private _spawnType = call {
                if (_type in ["hill", "hillAA", "city", "base", "roadblock", "airfield", "outpostAA"]) exitWith {
                    "AAF" + _type;
                };
                if (_type in ["outpost", "seaport"]) exitWith {
                    "AAFoutpost"
                };
                if (_type in ["resource", "powerplant", "factory"]) exitWith {
                    "AAFgeneric"
                };
                if (_type == "minefield") exitWith {
                    "minefield"
                };
                ""
            };
            if (_spawnType != "") then {
                if (_spawnType == "AAFcity") then {
                    [_x + "_civ", "CIVcity"] call AS_spawn_fnc_add;
                    [_x + "_civ", "location", _x] call AS_spawn_fnc_set;
                    [[_x + "_civ"], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
                [_x, _spawnType] call AS_spawn_fnc_add;
                [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
            } else {
                diag_log format ["[AS] Error: spawnUpdate tried to spawn location of type '%s' but that has no spawn type", _type];
            };
        };
        if (_isSpawned and !_spawnCondition) then {
            _x call AS_location_fnc_despawn;
        };
    };
    if (_x call AS_location_fnc_side == "FIA") then {
        // not clear what this is doing. owner is about who controls it, not something else.
        private _playerIsClose = (_x call AS_location_fnc_forced_spawned) or
                                 {{((_x getVariable ["owner", _x]) == _x) and {_x distance _position < AS_P("spawnDistance")}} count _spawningBLUFORunits > 0};
        // enemies are close.
        private _spawnCondition = _playerIsClose or {{_x distance _position < AS_P("spawnDistance")} count _spawningOPFORunits > 0};
        if (!_isSpawned and _spawnCondition) then {
            _x call AS_location_fnc_spawn;

            private _type = _x call AS_location_fnc_type;
            switch (true) do {
                case (_type == "city"): {
                    if (_playerIsClose) then {
                        [_x + "_civ", "CIVcity"] call AS_spawn_fnc_add;
                        [_x + "_civ", "location", _x] call AS_spawn_fnc_set;
                        [[_x + "_civ"], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                    };
                    // FIA does not spawn anything in a city
                };
                case (_type in ["resource","powerplant","factory","fia_hq","outpost","outpostAA"]): {
                    [_x, "FIAgeneric"] call AS_spawn_fnc_add;
                    [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
                case (_type == "airfield"): {
                    [_x, "FIAairfield"] call AS_spawn_fnc_add;
                    [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
                case (_type == "base"): {
                    [_x, "FIAbase"] call AS_spawn_fnc_add;
                    [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
                case (_type in ["roadblock","watchpost","camp"]): {
                    [_x, "FIAbuilt_location"] call AS_spawn_fnc_add;
                    [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
                case (_type == "NATOroadblock"): {
                    [_x, "NATOroadblock"] call AS_spawn_fnc_add;
                    [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
                case (_type == "minefield"): {
                    [_x, "minefield"] call AS_spawn_fnc_add;
                    [[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
                };
            };
        };
        if (_isSpawned and !_spawnCondition) then {
            _x call AS_location_fnc_despawn;
        };
    };
} forEach (call AS_location_fnc_all);
