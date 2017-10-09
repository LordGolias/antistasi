private _dict = ([AS_entities, "RHS_FIA_WEST"] call DICT_fnc_get) call DICT_fnc_copyLocal;
[_dict, "side", str east] call DICT_fnc_setLocal;
[_dict, "name", "ChDKZ (RHS)"] call DICT_fnc_setLocal;
[_dict, "flag", "rhs_flag_ChDKZ"] call DICT_fnc_setLocal;

[_dict, "soldier", "rhsgref_ins_rifleman"] call DICT_fnc_setLocal;
[_dict, "crew", "rhsgref_ins_crew"] call DICT_fnc_setLocal;
[_dict, "survivor", "rhsgref_ins_rifleman"] call DICT_fnc_setLocal;
[_dict, "engineer", "rhsgref_ins_engineer"] call DICT_fnc_setLocal;
[_dict, "medic", "rhsgref_ins_medic"] call DICT_fnc_setLocal;

_dict
