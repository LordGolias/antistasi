/*
	Description:
	Returns the lists of state functions and state names
*/
params ["_type", "_spawn"];
if (_type == "mission") exitWith {
    _spawn call AS_mission_fnc_spawn_states
};
if (_type == "AAFpatrol") exitWith {
    [AS_spawn_patrolAAF_states, AS_spawn_patrolAAF_state_functions]
};
if (_type == "AAFroadPatrol") exitWith {
    [AS_spawn_AAFroadPatrol_states, AS_spawn_AAFroadPatrol_state_functions]
};
if (_type == "AAFgeneric") exitWith {
    [AS_spawn_createAAFgeneric_states, AS_spawn_createAAFgeneric_state_functions]
};
if (_type == "AAFroadblock") exitWith {
    [AS_spawn_createAAFroadblock_states, AS_spawn_createAAFroadblock_state_functions]
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
if (_type == "NATOroadblock") exitWith {
    [AS_spawn_createNATOroadblock_states, AS_spawn_createNATOroadblock_state_functions]
};

diag_log format ["[AS] Error: spawn_states: invalid arguments [%1, %2]", _type, _spawn];
[[], []]  // default is to not do anything (no states)
