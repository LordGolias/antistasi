private _dict = ([AS_entities, "FIA_WEST"] call DICT_fnc_get) call DICT_fnc_copyLocal;
[_dict, "name", "CZ (CUP)"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_FIA_F"] call DICT_fnc_setLocal;

[_dict, "soldier", "CUP_B_CZ_soldier_DES"] call DICT_fnc_setLocal;
[_dict, "crew", "CUP_B_CZ_crew_DES"] call DICT_fnc_setLocal;
[_dict, "survivor", "CUP_B_CZ_soldier_light_DES"] call DICT_fnc_setLocal;
[_dict, "engineer", "CUP_B_CZ_engineer_DES"] call DICT_fnc_setLocal;
[_dict, "medic", "CUP_B_CZ_medic_DES"] call DICT_fnc_setLocal;

[_dict, "unlockedWeapons", ["CUP_arifle_AKS74U","CUP_hgun_Makarov"]] call DICT_fnc_setLocal;

[_dict, "unlockedMagazines", ["CUP_30Rnd_545x39_AK_M","CUP_8Rnd_9x18_Makarov_M"]] call DICT_fnc_setLocal;

[_dict, "unlockedBackpacks", ["CUP_B_CivPack_WDL"]] call DICT_fnc_setLocal;

[_dict, "vans", ["CUP_C_LR_Transport_CTK"]] call DICT_fnc_setLocal;

// FIA minefield uses first of this list
[_dict, "land_vehicles", ["CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_LR_Transport_CTK","CUP_C_V3S_Open_TKC","CUP_I_Datsun_PK"]] call DICT_fnc_setLocal;
[_dict, "water_vehicles", ["B_G_Boat_Transport_01_F"]] call DICT_fnc_setLocal;
// First helicopter of this list is undercover
[_dict, "air_vehicles", ["CUP_B_MH6J_OBS_USA"]] call DICT_fnc_setLocal;

// costs of **land vehicle**. Every vehicle in `"land_vehicles"` must be here.
private _costs = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "costs"] call DICT_fnc_delete; // delete old
[_dict, "costs", _costs] call DICT_fnc_setLocal;
[_costs, "CUP_C_UAZ_Unarmed_TK_CIV", 300] call DICT_fnc_setLocal;
[_costs, "CUP_C_LR_Transport_CTK", 300] call DICT_fnc_setLocal;
[_costs, "CUP_C_V3S_Open_TKC", 600] call DICT_fnc_setLocal;
[_costs, "CUP_I_Datsun_PK", 700] call DICT_fnc_setLocal;

_dict
