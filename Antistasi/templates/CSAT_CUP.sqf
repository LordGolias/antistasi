private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str east] call DICT_fnc_setLocal;
[_dict, "roles", ["state", "foreign"]] call DICT_fnc_setLocal;

[_dict, "helis_transport", ["CUP_O_Mi8_medevac_RU"]] call DICT_fnc_setLocal;
[_dict, "helis_attack", ["CUP_O_Ka52_RU"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["CUP_O_Mi8_RU"]] call DICT_fnc_setLocal;
[_dict, "planes", ["CUP_O_SU34_AGM_RU"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["CUP_O_Pchela1T_RU"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

[_dict, "tanks", ["CUP_O_T72_RU", "CUP_O_T90_RU"]] call DICT_fnc_setLocal;
[_dict, "boats", ["O_Boat_Armed_01_hmg_F"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["CUP_O_Ural_RU", "CUP_O_Ural_Open_RU"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["CUP_O_BMP2_RU", "CUP_O_BMP3_RU", "CUP_O_BTR90_RU"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars_transport", ["CUP_O_UAZ_Unarmed_RU", "CUP_O_UAZ_Open_RU"]] call DICT_fnc_setLocal;
[_dict, "cars_armed", ["CUP_O_UAZ_AGS30_RU", "CUP_O_UAZ_MG_RU", "CUP_O_BRDM2_RU", "CUP_O_HQ_RU"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["CUP_O_D30_RU"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["CUP_O_BM21_RU"]] call DICT_fnc_setLocal;

[_dict, "truck_ammo", "CUP_O_Ural_Reammo_RU"] call DICT_fnc_setLocal;
[_dict, "truck_repair", "CUP_O_Ural_Repair_RU"] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"CUP_O_Ural_Reammo_RU", "CUP_O_Ural_Refuel_RU", "CUP_O_Ural_Repair_RU"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["CUP_O_2S6M_RU"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "CUP_O_RU_Officer_VDV"] call DICT_fnc_setLocal;
[_dict, "traitor", "CUP_O_RU_Officer_VDV"] call DICT_fnc_setLocal;
[_dict, "gunner", "CUP_O_RU_Crew_VDV"] call DICT_fnc_setLocal;
[_dict, "crew", "CUP_O_RU_Crew_VDV"] call DICT_fnc_setLocal;
[_dict, "pilot", "CUP_O_RU_Pilot_VDV"] call DICT_fnc_setLocal;

[_dict, "static_aa", "CUP_O_ZU23_RU"] call DICT_fnc_setLocal;
[_dict, "static_at", "CUP_O_Meltis_RU"] call DICT_fnc_setLocal;
[_dict, "static_mg", "CUP_O_KORD_high_RU"] call DICT_fnc_setLocal;
[_dict, "static_mg_low", "CUP_O_KORD_RU"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "CUP_O_2b14_82mm_RU"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "CUP_O_RU" >> "Infantry"] call DICT_fnc_setLocal;
[_dict, "squads", ["CUP_O_RU_InfSquad_VDV"]] call DICT_fnc_setLocal;
[_dict, "teams", ["CUP_O_RU_InfSection_VDV"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["CUP_O_RU_InfSection_AA_VDV"]] call DICT_fnc_setLocal;
[_dict, "patrols", ["CUP_O_RU_InfSection_VDV"]] call DICT_fnc_setLocal;
[_dict, "recon_squad", "CUP_O_RU_ReconTeam"] call DICT_fnc_setLocal;
[_dict, "recon_team", "CUP_O_RU_ReconTeam"] call DICT_fnc_setLocal;

[_dict, "name", "CSAT"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_CSAT_F"] call DICT_fnc_setLocal;
[_dict, "box", "Box_East_WpsLaunch_F"] call DICT_fnc_setLocal;

_dict
