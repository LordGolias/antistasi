private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str east] call DICT_fnc_set;
[_dict, "roles", ["state", "foreign"]] call DICT_fnc_set;
[_dict, "name", "RU (CUP)"] call DICT_fnc_set;
[_dict, "flag", "Flag_CSAT_F"] call DICT_fnc_set;
[_dict, "flag_marker", "flag_CSAT"] call DICT_fnc_set;

[_dict, "helis_transport", ["CUP_O_Mi8_medevac_RU"]] call DICT_fnc_set;
[_dict, "helis_attack", ["CUP_O_Ka52_RU"]] call DICT_fnc_set;
[_dict, "helis_armed", ["CUP_O_Mi8_RU"]] call DICT_fnc_set;
[_dict, "planes", ["CUP_O_SU34_AGM_RU"]] call DICT_fnc_set;

[_dict, "uavs_small", ["CUP_O_Pchela1T_RU"]] call DICT_fnc_set;
[_dict, "uavs_attack", []] call DICT_fnc_set;

[_dict, "tanks", ["CUP_O_T72_RU", "CUP_O_T90_RU"]] call DICT_fnc_set;
[_dict, "boats", ["O_Boat_Armed_01_hmg_F"]] call DICT_fnc_set;

// used in roadblock mission
[_dict, "trucks", ["CUP_O_Ural_RU", "CUP_O_Ural_Open_RU"]] call DICT_fnc_set;
[_dict, "apcs", ["CUP_O_BMP2_RU", "CUP_O_BMP3_RU", "CUP_O_BTR90_RU"]] call DICT_fnc_set;

// used in traitor mission
[_dict, "cars_transport", ["CUP_O_UAZ_Unarmed_RU", "CUP_O_UAZ_Open_RU"]] call DICT_fnc_set;
[_dict, "cars_armed", ["CUP_O_UAZ_AGS30_RU", "CUP_O_UAZ_MG_RU", "CUP_O_BRDM2_RU", "CUP_O_HQ_RU"]] call DICT_fnc_set;

// used in artillery mission
[_dict, "artillery1", ["CUP_O_D30_RU"]] call DICT_fnc_set;
[_dict, "artillery2", ["CUP_O_BM21_RU"]] call DICT_fnc_set;

[_dict, "truck_ammo", "CUP_O_Ural_Reammo_RU"] call DICT_fnc_set;
[_dict, "truck_repair", "CUP_O_Ural_Repair_RU"] call DICT_fnc_set;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"CUP_O_Ural_Reammo_RU", "CUP_O_Ural_Refuel_RU", "CUP_O_Ural_Repair_RU"
]] call DICT_fnc_set;

[_dict, "self_aa", "CUP_O_2S6M_RU"] call DICT_fnc_set;
[_dict, "track_aa", "CUP_O_2S6M_RU"] call DICT_fnc_set;

// special units used in special occasions
[_dict, "officer", "CUP_O_RU_Officer_VDV"] call DICT_fnc_set;
[_dict, "traitor", "CUP_O_RU_Officer_VDV"] call DICT_fnc_set;
[_dict, "gunner", "CUP_O_RU_Crew_VDV"] call DICT_fnc_set;
[_dict, "crew", "CUP_O_RU_Crew_VDV"] call DICT_fnc_set;
[_dict, "pilot", "CUP_O_RU_Pilot_VDV"] call DICT_fnc_set;

[_dict, "static_aa", "CUP_O_ZU23_RU"] call DICT_fnc_set;
[_dict, "static_at", "CUP_O_Meltis_RU"] call DICT_fnc_set;
[_dict, "static_mg", "CUP_O_KORD_high_RU"] call DICT_fnc_set;
[_dict, "static_mg_low", "CUP_O_KORD_RU"] call DICT_fnc_set;
[_dict, "static_mortar", "CUP_O_2b14_82mm_RU"] call DICT_fnc_set;

[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "CUP_O_RU" >> "Infantry"] call DICT_fnc_set;
[_dict, "squads", ["CUP_O_RU_InfSquad_VDV"]] call DICT_fnc_set;
[_dict, "teams", ["CUP_O_RU_InfSection_VDV"]] call DICT_fnc_set;
[_dict, "teamsAA", ["CUP_O_RU_InfSection_AA_VDV"]] call DICT_fnc_set;
[_dict, "patrols", ["CUP_O_RU_InfSection_VDV"]] call DICT_fnc_set;
[_dict, "recon_squad", "CUP_O_RU_ReconTeam"] call DICT_fnc_set;
[_dict, "recon_team", "CUP_O_RU_ReconTeam"] call DICT_fnc_set;

// These have to be CfgVehicles mines that explode automatically (minefields)
[_dict, "ap_mines", ["CUP_MineE"]] call DICT_fnc_set;
[_dict, "at_mines", ["CUP_Mine"]] call DICT_fnc_set;
// These have to be CfgVehicles
[_dict, "explosives", ["SatchelCharge_F","DemoCharge_F","ClaymoreDirectional_F"]] call DICT_fnc_set;

[_dict, "box", "Box_East_WpsLaunch_F"] call DICT_fnc_set;

if hasTFAR then {
    [_dict, "tfar_lr_radio", "tf_mr3000"] call DICT_fnc_set;
    [_dict, "tfar_radio", "tf_fadak"] call DICT_fnc_set;
};

_dict
