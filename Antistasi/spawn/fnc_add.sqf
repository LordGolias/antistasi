params ["_name", "_type"];
diag_log format ["[AS] %1: new spawn '%2'", clientOwner, _name];
[call AS_spawn_fnc_dictionary, _name] call DICT_fnc_add;
[_name, "state_index", 0] call AS_spawn_fnc_set;
[_name, "spawn_type", _type] call AS_spawn_fnc_set;
