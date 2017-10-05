private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

bluHeliTrans = ["RHS_MELB_MH6M","RHS_UH60M_d","RHS_CH_47F_light"];
bluHeliTS = ["RHS_MELB_MH6M"];
bluHeliDis = ["RHS_UH60M_d"];
bluHeliRope = ["RHS_CH_47F_light"];
bluHeliArmed = ["RHS_MELB_AH6M_H","RHS_MELB_AH6M_M"];
bluHeliGunship = ["RHS_AH64D_AA","RHS_AH64D_GS","RHS_AH64D"];
bluCASFW = ["RHS_A10"];

[_dict, "uavs_small", []] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

planesNATO = bluHeliTrans + bluHeliArmed + bluHeliGunship + bluCASFW;

[_dict, "mbts", ["rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["RHS_M2A3","RHS_M2A3_BUSKI"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars", ["rhsusf_m1025_d_s", "rhsusf_m998_d_s_4dr_halftop"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["RHS_M119_D"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["RHS_M119_D"]] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"rhsusf_m113d_usarmy_supply","rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy","rhsusf_M978A4_BKIT_usarmy_d"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["rhs_m2a3_BUSKIII", "rhs_m2a3_BUSKI", "rhs_m2a3"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "rhsusf_usmc_marpat_d_officer"] call DICT_fnc_setLocal;
[_dict, "traitor", "rhsusf_usmc_marpat_d_officer"] call DICT_fnc_setLocal;
[_dict, "gunner", "rhsusf_usmc_marpat_d_rifleman_light"] call DICT_fnc_setLocal;
[_dict, "crew", "rhsusf_usmc_marpat_d_crewman"] call DICT_fnc_setLocal;
[_dict, "pilot", "rhsusf_army_ocp_helipilot"] call DICT_fnc_setLocal;

[_dict, "static_aa", "RHS_Stinger_AA_pod_D"] call DICT_fnc_setLocal;
[_dict, "static_mg", "RHS_M2StaticMG_D"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "RHS_M252_D"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry")] call DICT_fnc_setLocal;
[_dict, "squad", "rhs_group_nato_usmc_d_infantry_squad"] call DICT_fnc_setLocal;
[_dict, "team", "rhs_group_nato_usmc_d_infantry_team"] call DICT_fnc_setLocal;
[_dict, "recon_squad", configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_recon_d_infantry" >> "rhs_group_nato_usmc_recon_d_infantry_team"] call DICT_fnc_setLocal;
[_dict, "recon_team", configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_recon_d_infantry" >> "rhs_group_nato_usmc_recon_d_infantry_team"] call DICT_fnc_setLocal;

[_dict, "name", "USMC"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_US_F"] call DICT_fnc_setLocal;
[_dict, "box", "Box_NATO_Equip_F"] call DICT_fnc_setLocal;
