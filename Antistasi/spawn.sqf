AS_spawn_fnc_states = {
    params ["_type", "_spawn"];
    if (_type == "mission") exitWith {
        _spawn call AS_fnc_mission_spawn_states
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
    params ["_name"];
    ["spawn", _name] call AS_fnc_object_add;
    [_name, "state_index", 0] call AS_spawn_fnc_set;
};

AS_spawn_fnc_remove = {
    params ["_name"];
    ["spawn", _name] call AS_fnc_object_remove;
};

AS_spawn_fnc_start = {
    params ["_type", "_spawn"];

    ([_spawn, _type] call AS_spawn_fnc_states) params ["_states", "_functions"];

    // it is a new spawn: initialize its current state
    if not (_spawn in (call AS_spawn_fnc_spawns)) then {
        diag_log ["[AS] %1: new spawn '%2'", clientOwner, _spawn];
        [_spawn] call AS_spawn_fnc_add;
    };
    // else, it is an existing spawn: pick from where it was left

    private _state_index = [_spawn, "state_index"] call AS_spawn_fnc_get;
    while {_state_index < (count _functions - 1)} do {
        diag_log ["[AS] %1: spawn '%2' started state '%3'", clientOwner, _spawn, _states select _state_index];
        _spawn call (_functions select _state_index);
        diag_log ["[AS] %1: spawn '%2' finished state '%3'", clientOwner, _spawn, _states select _state_index];
        // the function above can change the `state_index` to a new one. We load it and use it
        _state_index = [_spawn, "state_index"] call AS_spawn_fnc_get;
        [_spawn, "state_index", _state_index + 1] call AS_spawn_fnc_set;
    };
    _spawn call AS_spawn_fnc_remove;
};
