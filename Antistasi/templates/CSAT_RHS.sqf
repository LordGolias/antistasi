private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str east] call DICT_fnc_set;
[_dict, "roles", ["state", "foreign"]] call DICT_fnc_set;
[_dict, "name", "VMF (RHS)"] call DICT_fnc_set;
[_dict, "flag", "rhs_Flag_vmf_F"] call DICT_fnc_set;
[_dict, "flag_marker", "rhs_flag_Russia"] call DICT_fnc_set;

[_dict, "helis_transport", ["rhs_Mi8AMTSh_FAB_vvs", "rhs_ka60_grey"]] call DICT_fnc_set;
[_dict, "helis_attack", ["rhs_mi28n_vvs"]] call DICT_fnc_set;
[_dict, "helis_armed", ["RHS_Mi8AMTSh_vvs"]] call DICT_fnc_set;
[_dict, "planes", ["RHS_Su25SM_vvs", "RHS_T50_vvs_generic"]] call DICT_fnc_set;

[_dict, "uavs_small", ["rhs_pchela1t_vvs"]] call DICT_fnc_set;
[_dict, "uavs_attack", []] call DICT_fnc_set;

[_dict, "tanks", ["rhs_t72bd_tv", "rhs_t80um", "rhs_t90a_tv"]] call DICT_fnc_set;
[_dict, "boats", ["O_Boat_Armed_01_hmg_F"]] call DICT_fnc_set;

// used in roadblock mission
[_dict, "trucks", ["rhs_kamaz5350_open_vmf", "rhs_kamaz5350_vmf"]] call DICT_fnc_set;
[_dict, "apcs", ["rhs_btr80_vmf", "rhs_btr80a_vmf", "rhs_btr70_vmf"]] call DICT_fnc_set;

// used in traitor mission
[_dict, "cars_transport", ["rhs_tigr_vmf", "rhs_tigr_3cammo_vmf", "rhs_tigr_m_vmf", "rhs_tigr_m_vmf", "rhs_tigr_m_3cammo_vmf", "rhsgref_BRDM2UM_vmf"]] call DICT_fnc_set;
[_dict, "cars_armed", ["rhs_tigr_sts_vmf", "rhs_tigr_sts_3cammo_vmf", "rhsgref_BRDM2_vmf", "rhsgref_BRDM2_HQ_vmf"]] call DICT_fnc_set;

// used in artillery mission
[_dict, "artillery1", ["rhs_D30_vdv"]] call DICT_fnc_set;
[_dict, "artillery2", ["rhs_2s3_tv"]] call DICT_fnc_set;

[_dict, "truck_ammo", "rhs_gaz66_ammo_vmf"] call DICT_fnc_set;
[_dict, "truck_repair", "rhs_ural_repair_vmf_01"] call DICT_fnc_set;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"rhs_gaz66_ammo_vmf", "rhs_ural_fuel_vmf_01", "rhs_gaz66_ap2_vmf", "rhs_ural_repair_vmf_01"
]] call DICT_fnc_set;

[_dict, "self_aa", ["rhs_zsu234_aa"]] call DICT_fnc_set;

// special units used in special occasions
[_dict, "officer", "rhs_vmf_recon_officer"] call DICT_fnc_set;
[_dict, "traitor", "rhs_vmf_recon_officer_armored"] call DICT_fnc_set;
[_dict, "gunner", "rhs_vmf_recon_rifleman_l"] call DICT_fnc_set;
[_dict, "crew", "rhs_vmf_recon_rifleman_l"] call DICT_fnc_set;
[_dict, "pilot", "rhs_pilot_combat_heli"] call DICT_fnc_set;

[_dict, "static_aa", "rhs_Igla_AA_pod_vdv"] call DICT_fnc_set;
[_dict, "static_at", "rhs_Metis_9k115_2_vdv"] call DICT_fnc_set;
[_dict, "static_mg", "rhs_KORD_high_vdv"] call DICT_fnc_set;
[_dict, "static_mg_low", "rhs_KORD_vdv"] call DICT_fnc_set;
[_dict, "static_mortar", "rhs_2b14_82mm_vdv"] call DICT_fnc_set;

[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry"] call DICT_fnc_set;
[_dict, "squads", ["rhs_group_rus_vdv_infantry_squad"]] call DICT_fnc_set;
[_dict, "teams", ["rhs_group_rus_vdv_infantry_fireteam"]] call DICT_fnc_set;
[_dict, "teamsAA", ["rhs_group_rus_vdv_infantry_section_AA"]] call DICT_fnc_set;
[_dict, "patrols", ["rhs_group_rus_vdv_infantry_MANEUVER"]] call DICT_fnc_set;
[_dict, "recon_squad", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv">> "rhs_group_rus_vdv_infantry_recon" >> "rhs_group_rus_vdv_infantry_recon_squad"] call DICT_fnc_set;
[_dict, "recon_team", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv">> "rhs_group_rus_vdv_infantry_recon" >>"rhs_group_rus_vdv_infantry_recon_fireteam"] call DICT_fnc_set;

// These have to be CfgVehicles mines that explode automatically (minefields)
[_dict, "ap_mines", ["rhs_mine_pmn2"]] call DICT_fnc_set;
[_dict, "at_mines", ["rhs_mine_tm62m"]] call DICT_fnc_set;
// These have to be CfgVehicles
[_dict, "explosives", ["SatchelCharge_F","DemoCharge_F","ClaymoreDirectional_F"]] call DICT_fnc_set;

[_dict, "box", "Box_East_WpsLaunch_F"] call DICT_fnc_set;

if hasTFAR then {
    [_dict, "tfar_lr_radio", "tf_mr3000_rhs"] call DICT_fnc_set;
    [_dict, "tfar_radio", "tf_fadak"] call DICT_fnc_set;
};

_dict
