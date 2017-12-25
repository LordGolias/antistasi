private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str west] call DICT_fnc_set;
[_dict, "roles", ["state", "foreign"]] call DICT_fnc_set;
[_dict, "name", "USMC (RHS)"] call DICT_fnc_set;
[_dict, "flag", "Flag_US_F"] call DICT_fnc_set;
[_dict, "flag_marker", "rhs_flag_USA"] call DICT_fnc_set;

[_dict, "helis_transport", ["RHS_MELB_MH6M", "RHS_UH60M_d", "RHS_CH_47F_light"]] call DICT_fnc_set;
[_dict, "helis_attack", ["RHS_AH64D_AA","RHS_AH64D_GS","RHS_AH64D"]] call DICT_fnc_set;
[_dict, "helis_armed", ["RHS_MELB_AH6M_H","RHS_MELB_AH6M_M"]] call DICT_fnc_set;
[_dict, "planes", ["RHS_A10"]] call DICT_fnc_set;

[_dict, "uavs_small", []] call DICT_fnc_set;
[_dict, "uavs_attack", []] call DICT_fnc_set;

[_dict, "tanks", ["rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy"]] call DICT_fnc_set;
[_dict, "boats", ["B_Boat_Armed_01_minigun_F"]] call DICT_fnc_set;

// used in roadblock mission
[_dict, "trucks", ["rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy"]] call DICT_fnc_set;
[_dict, "apcs", ["RHS_M2A3","RHS_M2A3_BUSKI"]] call DICT_fnc_set;

// used in traitor mission
[_dict, "cars_transport", ["rhsusf_m1025_d_s", "rhsusf_m998_d_s_4dr_halftop"]] call DICT_fnc_set;
[_dict, "cars_armed", ["rhsusf_m1025_d_s_m2", "rhsusf_m1025_d_s_Mk19"]] call DICT_fnc_set;

// used in artillery mission
[_dict, "artillery1", ["RHS_M119_D"]] call DICT_fnc_set;
[_dict, "artillery2", ["RHS_M119_D"]] call DICT_fnc_set;

[_dict, "truck_ammo", "rhsusf_m113d_usarmy_supply"] call DICT_fnc_set;
[_dict, "truck_repair", "rhsusf_M978A4_REPAIR_usarmy_d"] call DICT_fnc_set;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"rhsusf_m113d_usarmy_supply","rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy","rhsusf_M978A4_REPAIR_usarmy_d"
]] call DICT_fnc_set;

[_dict, "self_aa", ["rhs_m2a3_BUSKIII", "rhs_m2a3_BUSKI", "rhs_m2a3"]] call DICT_fnc_set;

// special units used in special occasions
[_dict, "officer", "rhsusf_usmc_marpat_d_officer"] call DICT_fnc_set;
[_dict, "traitor", "rhsusf_usmc_marpat_d_officer"] call DICT_fnc_set;
[_dict, "gunner", "rhsusf_usmc_marpat_d_rifleman_light"] call DICT_fnc_set;
[_dict, "crew", "rhsusf_usmc_marpat_d_crewman"] call DICT_fnc_set;
[_dict, "pilot", "rhsusf_army_ocp_helipilot"] call DICT_fnc_set;

[_dict, "static_aa", "RHS_Stinger_AA_pod_D"] call DICT_fnc_set;
[_dict, "static_at", "RHS_TOW_TriPod_D"] call DICT_fnc_set;
[_dict, "static_mg", "RHS_M2StaticMG_D"] call DICT_fnc_set;
[_dict, "static_mg_low", "RHS_M2StaticMG_MiniTripod_D"] call DICT_fnc_set;
[_dict, "static_mortar", "RHS_M252_D"] call DICT_fnc_set;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry")] call DICT_fnc_set;
[_dict, "squads", ["rhs_group_nato_usmc_d_infantry_squad"]] call DICT_fnc_set;
[_dict, "teams", ["rhs_group_nato_usmc_d_infantry_team"]] call DICT_fnc_set;
[_dict, "teamsAA", ["rhs_group_nato_usmc_d_infantry_team_AA"]] call DICT_fnc_set;
[_dict, "patrols", ["rhs_group_nato_usmc_d_infantry_team"]] call DICT_fnc_set;
[_dict, "recon_squad", configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_recon_d_infantry" >> "rhs_group_nato_usmc_recon_d_infantry_team"] call DICT_fnc_set;
[_dict, "recon_team", configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_recon_d_infantry" >> "rhs_group_nato_usmc_recon_d_infantry_team"] call DICT_fnc_set;

// These have to be CfgVehicles mines that explode automatically (minefields)
[_dict, "ap_mines", ["rhs_mine_pmn2"]] call DICT_fnc_set;
[_dict, "at_mines", ["rhs_mine_tm62m"]] call DICT_fnc_set;
// These have to be CfgVehicles
[_dict, "explosives", ["SatchelCharge_F","DemoCharge_F","ClaymoreDirectional_F"]] call DICT_fnc_set;

[_dict, "box", "Box_NATO_Equip_F"] call DICT_fnc_set;

if hasTFAR then {
    [_dict, "tfar_lr_radio", "tf_rt1523g_rhs"] call DICT_fnc_set;
    [_dict, "tfar_radio", "tf_anprc152"] call DICT_fnc_set;
};

_dict
