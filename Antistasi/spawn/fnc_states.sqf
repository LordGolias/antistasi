/*
	Description:
	Returns the lists of state functions and state names
*/
params ["_type", "_spawn"];
if (_type == "mission") exitWith {
    _spawn call AS_mission_fnc_spawn_states
};
if (_type == "location") exitWith {
    _spawn call AS_location_fnc_spawn_states
};
if (_type == "AAFpatrol") exitWith {
    [AS_spawn_patrolAAF_states, AS_spawn_patrolAAF_state_functions]
};
if (_type == "AAFroadPatrol") exitWith {
    [AS_spawn_AAFroadPatrol_states, AS_spawn_AAFroadPatrol_state_functions]
};

diag_log format ["[AS] Error: spawn_states: invalid arguments [%1, %2]", _type, _spawn];
[[], []]  // default is to not do anything (no states)
