private _dict = [AS_entities, "AAF"] call DICT_fnc_get;

// special units used in special occasions
[_dict, "officer", "rhs_vdv_officer"] call DICT_fnc_setLocal;
[_dict, "traitor", "rhs_vdv_recon_officer"] call DICT_fnc_setLocal;
[_dict, "gunner", "rhs_vdv_crew"] call DICT_fnc_setLocal;
[_dict, "crew", "rhs_vdv_crew"] call DICT_fnc_setLocal;
[_dict, "pilot", "rhs_pilot_transport_heli"] call DICT_fnc_setLocal;

// To modders: equipment in AAF boxes comes from the set of all equipment of all units on the groups of this cfg
[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry"] call DICT_fnc_setLocal;

// These groups are used in different spawns (locations, patrols, missions)
[_dict, "patrols", ["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER"]] call DICT_fnc_setLocal;
[_dict, "teams", ["rhs_group_rus_vdv_infantry_section_mg", "rhs_group_rus_vdv_infantry_section_marksman"]] call DICT_fnc_setLocal;
[_dict, "squads", ["rhs_group_rus_vdv_infantry_squad","rhs_group_rus_vdv_infantry_squad_2mg","rhs_group_rus_vdv_infantry_squad_sniper","rhs_group_rus_vdv_infantry_squad_mg_sniper"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["rhs_group_rus_vdv_infantry_section_AA"]] call DICT_fnc_setLocal;

// To modders: overwrite this in the template to change the vehicles AAF uses.
// Rules:
// 1. vehicle must exist.
// 2. each vehicle must belong to only one category.
[_dict, "planes", ["rhs_Su25SM_vvsc"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["rhs_Mi24V_FAB_vdv","rhs_Mi24V_UPK23_vdv"]] call DICT_fnc_setLocal;
[_dict, "helis_transport", ["rhs_Mi8mt_Cargo_vvsc","rhs_Mi8MTV3_FAB_vvsc","rhs_Mi8AMTSh_FAB_vvsc","rhs_ka60_c"]] call DICT_fnc_setLocal;
[_dict, "tanks", ["rhs_t72bb_tv","rhs_t72bd_tv","rhs_t90a_tv"]] call DICT_fnc_setLocal;
[_dict, "boats", ["I_Boat_Armed_01_minigun_F"]] call DICT_fnc_setLocal;
[_dict, "cars_transport", ["rhs_tigr_vdv", "rhs_tigr_3cammo_vdv", "rhs_tigr_m_vdv", "rhs_tigr_m_vdv", "rhs_tigr_m_3cammo_vdv", "rhsgref_BRDM2UM_vdv"]] call DICT_fnc_setLocal;
[_dict, "cars_armed", ["rhs_tigr_sts_vdv", "rhs_tigr_sts_3cammo_vdv", "rhsgref_BRDM2_vdv", "rhsgref_BRDM2_HQ_vdv"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["rhs_btr80_vdv", "rhs_bmp2d_vdv","rhs_bmp1p_vdv","rhs_bmd2m","rhs_bmd2k"]] call DICT_fnc_setLocal;
[_dict, "trucks", ["rhs_kamaz5350_open_vdv","rhs_kamaz5350_vdv","rhs_Ural_Open_VDV_01","rhs_Ural_VDV_01"]] call DICT_fnc_setLocal;

[_dict, "ammoVehicles", ["rhsgref_ins_gaz66_ammo"]] call DICT_fnc_setLocal;
[_dict, "repairVehicles", ["rhs_gaz66_repair_vdv"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", []] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

[_dict, "static_aa", "rhsgref_cdf_b_ZU23"] call DICT_fnc_setLocal;
[_dict, "static_at", "rhsgref_ins_g_SPG9M"] call DICT_fnc_setLocal;
[_dict, "static_mg", "rhsgref_cdf_b_DSHKM"] call DICT_fnc_setLocal;
[_dict, "static_mg_low", "rhsgref_cdf_b_DSHKM_Mini_TriPod"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "rhsgref_cdf_b_reg_M252"] call DICT_fnc_setLocal;

[_dict, "name", "VV"] call DICT_fnc_setLocal;
[_dict, "flag", "rhs_Flag_vdv_F"] call DICT_fnc_setLocal;

// FIA Vehicles
vehTruckAA = "rhsgref_cdf_b_gaz66_zu23";

/*
================ Gear ================
Weapons, ammo, launchers, missiles, mines, items and optics will spawn in ammo crates, the rest will not. These lists, together with the corresponding lists in the NATO/USAF template, determine what can be unlocked. Weapons of all kinds and ammo are the exception: they can all be unlocked.
*/

AAFExponsives = [
    "SatchelCharge_F",
    "DemoCharge_F",
    "ClaymoreDirectional_F"
];

AAFMines = [
    "rhs_mine_tm62m",
    "rhs_mine_pmn2"
];

atMine = "rhs_mine_tm62m";
apMine = "rhs_mine_pmn2";

// NVG, flashlight, laser, mine types
indNVG = "rhs_1PN138";
indFL = "rhs_acc_2dpZenit";
indLaser = "rhs_acc_perst1ik";

// Long-range radio
lrRadio = "tf_mr3000_rhs";
