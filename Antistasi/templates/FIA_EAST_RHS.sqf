private _dict = ([AS_entities, "RHS_FIA_WEST"] call DICT_fnc_get) call DICT_fnc_copy;
[_dict, "side", str east] call DICT_fnc_set;
[_dict, "name", "ChDKZ (RHS)"] call DICT_fnc_set;
[_dict, "flag", "rhs_flag_ChDKZ"] call DICT_fnc_set;

[_dict, "soldier", "rhsgref_ins_rifleman"] call DICT_fnc_set;
[_dict, "crew", "rhsgref_ins_crew"] call DICT_fnc_set;
[_dict, "survivor", "rhsgref_ins_rifleman"] call DICT_fnc_set;
[_dict, "engineer", "rhsgref_ins_engineer"] call DICT_fnc_set;
[_dict, "medic", "rhsgref_ins_medic"] call DICT_fnc_set;

_dict
