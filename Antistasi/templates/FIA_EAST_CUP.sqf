private _dict = ([AS_entities, "CUP_FIA_WEST"] call DICT_fnc_get) call DICT_fnc_copy;
[_dict, "side", str east] call DICT_fnc_set;
[_dict, "name", "CMRS (CUP)"] call DICT_fnc_set;
[_dict, "flag", "Flag_FIA_F"] call DICT_fnc_set;

[_dict, "soldier", "CUP_O_INS_Soldier"] call DICT_fnc_set;
[_dict, "crew", "CUP_O_INS_Crew"] call DICT_fnc_set;
[_dict, "survivor", "CUP_O_INS_Soldier"] call DICT_fnc_set;
[_dict, "engineer", "CUP_O_INS_Soldier_Engineer"] call DICT_fnc_set;
[_dict, "medic", "CUP_O_INS_Medic"] call DICT_fnc_set;

_dict
