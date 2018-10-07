
/*
    Given a spawnName for a location, returns the spawn states and functions.
*/
params ["_spawnName"];

private _location = _spawnName;
private _side = _location call AS_location_fnc_side;
if (_spawnName find "civ_" == 0) then {
    _location = _spawnName select [4];
    _side = 'CIV';
};

private _type = _location call AS_location_fnc_type;

private _spawn_type = "";

if (_side == "CIV") then {
    switch (true) do {
        case (_type == "city"): {
            _spawn_type = "CIVcity";
        };
    };
};
if (_side == "FIA") then {
    switch (true) do {
        case (_type in ["resource","powerplant","factory","fia_hq","city","outpost","outpostAA"]): {
            _spawn_type = "FIAgeneric";
        };
        case (_type == "airfield"): {
            _spawn_type = "FIAairfield";
        };
        case (_type == "base"): {
            _spawn_type = "FIAbase";
        };
        case (_type in ["roadblock","watchpost","camp"]): {
            _spawn_type = "FIAbuilt_location";
        };
        case (_type == "NATOroadblock"): {
            _spawn_type = "NATOroadblock";
        };
        case (_type == "minefield"): {
            _spawn_type = "minefield";
        };
    };
};
if (_side == "AAF") then {
    _spawn_type = call {
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
};

if (_spawn_type == "AAFgeneric") exitWith {
    [AS_spawn_createAAFgeneric_states, AS_spawn_createAAFgeneric_state_functions]
};
if (_spawn_type == "AAFroadblock") exitWith {
    [AS_spawn_createAAFroadblock_states, AS_spawn_createAAFroadblock_state_functions]
};
if (_spawn_type == "AAFhill") exitWith {
    [AS_spawn_createAAFhill_states, AS_spawn_createAAFhill_state_functions]
};
if (_spawn_type == "AAFhillAA") exitWith {
    [AS_spawn_createAAFhillAA_states, AS_spawn_createAAFhillAA_state_functions]
};
if (_spawn_type == "AAFoutpost") exitWith {
    [AS_spawn_createAAFoutpost_states, AS_spawn_createAAFoutpost_state_functions]
};
if (_spawn_type == "AAFoutpostAA") exitWith {
    [AS_spawn_createAAFoutpostAA_states, AS_spawn_createAAFoutpostAA_state_functions]
};
if (_spawn_type == "AAFbase") exitWith {
    [AS_spawn_createAAFbase_states, AS_spawn_createAAFbase_state_functions]
};
if (_spawn_type == "AAFairfield") exitWith {
    [AS_spawn_createAAFairfield_states, AS_spawn_createAAFairfield_state_functions]
};
if (_spawn_type == "AAFcity") exitWith {
    [AS_spawn_createAAFcity_states, AS_spawn_createAAFcity_state_functions]
};
if (_spawn_type == "CIVcity") exitWith {
    [AS_spawn_createCIVcity_states, AS_spawn_createCIVcity_state_functions]
};
if (_spawn_type == "FIAgeneric") exitWith {
    [AS_spawn_createFIAgeneric_states, AS_spawn_createFIAgeneric_state_functions]
};
if (_spawn_type == "FIAairfield") exitWith {
    [AS_spawn_createFIAairfield_states, AS_spawn_createFIAairfield_state_functions]
};
if (_spawn_type == "FIAbase") exitWith {
    [AS_spawn_createFIAbase_states, AS_spawn_createFIAbase_state_functions]
};
if (_spawn_type == "FIAbuilt_location") exitWith {
    [AS_spawn_createFIAbuilt_location_states, AS_spawn_createFIAbuilt_location_state_functions]
};
if (_spawn_type == "minefield") exitWith {
    [AS_spawn_createMinefield_states, AS_spawn_createMinefield_state_functions]
};
if (_spawn_type == "NATOroadblock") exitWith {
    [AS_spawn_createNATOroadblock_states, AS_spawn_createNATOroadblock_state_functions]
};
diag_log format ["[AS] Error: location_spawn_states: location '%1' has no spawn states defined", _location];
[[], []]
