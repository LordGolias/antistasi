AS_spawn_fnc_states = {
    params ["_type", "_spawn"];
    if (_type == "mission" and _spawn == "nato_uav") exitWith {
        [AS_mission_natoUAV_states, AS_mission_natoUAV_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_armor") exitWith {
        [AS_mission_natoArmor_states, AS_mission_natoArmor_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_cas") exitWith {
        [AS_mission_natoCAS_states, AS_mission_natoCAS_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_qrf") exitWith {
        [AS_mission_natoQRF_states, AS_mission_natoQRF_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_qrf") exitWith {
        [AS_mission_natoAttack_states, AS_mission_natoAttack_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_artillery") exitWith {
        [AS_mission_natoArtillery_states, AS_mission_natoArtillery_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_roadblock") exitWith {
        [AS_mission_natoRoadblock_states, AS_mission_natoRoadblock_state_functions]
    };
    if (_type == "mission" and _spawn == "nato_ammo") exitWith {
        [AS_mission_natoAmmo_states, AS_mission_natoAmmo_state_functions]
    };
    if (_type == "mission" and _spawn == "steal_ammo") exitWith {
        [AS_mission_stealAmmo_states, AS_mission_stealAmmo_state_functions]
    };
    if (_type == "mission" and _spawn == "repair_antenna") exitWith {
        [AS_mission_repairAntenna_states, AS_mission_repairAntenna_state_functions]
    };
    if (_type == "mission" and _spawn in ["kill_specops", "kill_officer"]) exitWith {
        [AS_mission_assassinate_states, AS_mission_assassinate_state_functions]
    };
    if (_type == "mission" and _spawn == "kill_traitor") exitWith {
        [AS_mission_killTraitor_states, AS_mission_killTraitor_state_functions]
    };
    if (_type == "mission" and _spawn == "destroy_vehicle") exitWith {
        [AS_mission_destroyVehicle_states, AS_mission_destroyVehicle_state_functions]
    };
    if (_type == "mission" and _spawn == "destroy_antenna") exitWith {
        [AS_mission_destroyAntenna_states, AS_mission_destroyAntenna_state_functions]
    };
    if (_type == "mission" and _spawn == "destroy_helicopter") exitWith {
        [AS_mission_destroyHelicopter_states, AS_mission_destroyHelicopter_state_functions]
    };
    if (_type == "mission" and _spawn in ["rescue_prisioners", "rescue_refugees"]) exitWith {
        [AS_mission_rescue_states, AS_mission_rescue_state_functions]
    };
    if (_type == "mission" and _spawn == "conquer") exitWith {
        [AS_mission_conquer_states, AS_mission_conquer_state_functions]
    };
    if (_type == "mission" and _spawn == "rob_bank") exitWith {
        [AS_mission_robBank_states, AS_mission_robBank_state_functions]
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

AS_spawn_fnc_saveTask = {
    [_this select 0, "task", _this] call AS_spawn_fnc_set;
};

AS_spawn_fnc_loadTask = {
    params ["_mission", "_status"];
    private _params = [_mission, "task"] call AS_spawn_fnc_get;

    [_params select 0,[side_blue,civilian],
     _params select 1,
     _params select 2,
     _status, 5,true,true,
     _params select 3]
};

AS_spawn_fnc_checkpoint = {
    params ["_name"];
    private _state_index = [_name, "state_index"] call AS_spawn_fnc_get;
    [_name, "state_index", _state_index + 1] call AS_spawn_fnc_set;
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
        _spawn call AS_spawn_fnc_checkpoint;
        diag_log ["[AS] %1: spawn '%2' finished state '%3'", clientOwner, _spawn, _states select _state_index];
        _state_index = [_spawn, "state_index"] call AS_spawn_fnc_get;
    };
    _spawn call AS_spawn_fnc_remove;
};
