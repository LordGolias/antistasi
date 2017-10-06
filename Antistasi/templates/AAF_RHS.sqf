/*
List of infantry classes. These will have individual equipment mapped to them.

Note: all classes marked as "extra" do not have a unique class in this template. They are, however, part of other templates and are therfore included in all templates.
*/
private _sol_A_AR = "rhs_vdv_machinegunner_assistant"; // Assistant autorifle
private _sol_A_AT = "rhs_vdv_strelok_rpg_assist"; // Assistant AT
private _sol_AA = "rhs_vdv_aa"; // AA
private _sol_AR = "rhs_vdv_machinegunner"; // Autorifle
private _sol_AT = "rhs_vdv_at"; // AT
private _sol_GL = "rhs_vdv_grenadier"; // Grenade launcher
private _sol_GL2 = "rhs_vdv_grenadier_rpg"; // Grenade launcher
private _sol_LAT = "rhs_vdv_LAT"; // Light AT
private _sol_LAT2 = "rhs_vdv_RShG2"; // Light AT
private _sol_MG = "rhs_vdv_arifleman"; // Machinegunner
private _sol_MK = "rhs_vdv_marksman"; // Marksman
private _sol_SL = "rhs_vdv_sergeant"; // Squad leader
private _sol_TL = "rhs_vdv_junior_sergeant"; // Team leader
private _sol_TL2 = "rhs_vdv_efreitor"; // Team leader
private _sol_EXP = "rhs_vdv_engineer"; // Explosives (extra)
private _sol_R_L = "rhs_vdv_rifleman_lite"; // Rifleman, light
private _sol_REP = "rhs_vdv_engineer"; // Repair (extra)
private _sol_RFL = "rhs_vdv_rifleman"; // Rifleman
private _sol_SN = "rhs_vdv_marksman_asval"; // Sniper
private _sol_SP = "rhs_vdv_rifleman_asval"; // Spotter
private _sol_MED = "rhs_vdv_medic"; // Medic
private _sol_ENG = "rhs_vdv_engineer"; // Engineer
private _sol_OFF = "rhs_vdv_officer"; // Officer
private _sol_OFF2 = "rhs_vdv_officer_armored"; // Officer

private _sol_CREW = "rhs_vdv_crew"; // Crew
private _sol_CREW2 = "rhs_vdv_armoredcrew"; // Crew
private _sol_CREW3 = "rhs_vdv_combatcrew"; // Crew
private _sol_CREW4 = "rhs_vdv_crew_commander"; // Crew
private _sol_DRV = "rhs_vdv_driver"; // Driver
private _sol_DRV2 = "rhs_vdv_driver_armored"; // Driver
private _sol_HPIL = "rhs_pilot_transport_heli"; // helicopter pilot
private _sol_HPIL2 = "rhs_pilot_combat_heli"; // helicopter pilot
private _sol_PIL = "rhs_pilot"; // Pilot

private _dict = [AS_entities, "AAF"] call DICT_fnc_get;

[_dict, "gunner", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "crew", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "pilot", _sol_HPIL] call DICT_fnc_setLocal;
[_dict, "medic", _sol_MED] call DICT_fnc_setLocal;
[_dict, "driver", _sol_CREW] call DICT_fnc_setLocal;

[_dict, "officers", [_sol_OFF, _sol_OFF2]] call DICT_fnc_setLocal;
[_dict, "snipers", [_sol_MK, _sol_SN, _sol_SP]] call DICT_fnc_setLocal;
[_dict, "ncos", [_sol_SL, _sol_TL, _sol_TL2]] call DICT_fnc_setLocal;
[_dict, "specials", [_sol_A_AT, _sol_AA, _sol_AT, _sol_EXP, _sol_REP, _sol_ENG, _sol_MED]] call DICT_fnc_setLocal;
[_dict, "mgs", [_sol_A_AR, _sol_AR, _sol_MG]] call DICT_fnc_setLocal;
[_dict, "regulars", [_sol_GL, _sol_GL2, _sol_LAT, _sol_LAT2, _sol_R_L, _sol_RFL]] call DICT_fnc_setLocal;
[_dict, "crews", [_sol_CREW, _sol_CREW2, _sol_CREW3, _sol_CREW4, _sol_DRV, _sol_DRV2]] call DICT_fnc_setLocal;
[_dict, "pilots", [_sol_HPIL, _sol_HPIL2, _sol_PIL]] call DICT_fnc_setLocal;

[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry"] call DICT_fnc_setLocal;

[_dict, "patrols", ["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER"]] call DICT_fnc_setLocal;
[_dict, "garrisons", ["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER","rhs_group_rus_vdv_infantry_MANEUVER"]] call DICT_fnc_setLocal;
[_dict, "teamsATAA", ["rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AA"]] call DICT_fnc_setLocal;
[_dict, "teams", ["rhs_group_rus_vdv_infantry_section_mg",
    "rhs_group_rus_vdv_infantry_section_marksman",
    "rhs_group_rus_vdv_infantry_section_AT",
    "rhs_group_rus_vdv_infantry_section_AA",
    "rhs_group_rus_vdv_infantry_section_mg",
    "rhs_group_rus_vdv_infantry_section_marksman"]
] call DICT_fnc_setLocal;
[_dict, "squads", ["rhs_group_rus_vdv_infantry_squad","rhs_group_rus_vdv_infantry_squad_2mg","rhs_group_rus_vdv_infantry_squad_sniper","rhs_group_rus_vdv_infantry_squad_mg_sniper"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["rhs_group_rus_vdv_infantry_section_AA"]] call DICT_fnc_setLocal;
[_dict, "teamsAT", ["rhs_group_rus_vdv_infantry_section_AT"]] call DICT_fnc_setLocal;

[_dict, "planes", ["rhs_Su25SM_vvsc"]] call DICT_fnc_setLocal;
[_dict, "armedHelis", ["rhs_Mi24V_FAB_vdv","rhs_Mi24V_UPK23_vdv"]] call DICT_fnc_setLocal;
[_dict, "transportHelis", ["rhs_Mi8mt_Cargo_vvsc","rhs_Mi8MTV3_FAB_vvsc","rhs_Mi8AMTSh_FAB_vvsc","rhs_ka60_c"]] call DICT_fnc_setLocal;
[_dict, "tanks", ["rhs_t72bb_tv","rhs_t72bd_tv","rhs_t90a_tv"]] call DICT_fnc_setLocal;
[_dict, "boats", ["I_Boat_Armed_01_minigun_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["rhs_btr80_vdv", "rhs_bmp2d_vdv","rhs_bmp1p_vdv","rhs_bmd2m","rhs_bmd2k"]] call DICT_fnc_setLocal;
[_dict, "trucks", ["rhs_kamaz5350_open_vdv","rhs_kamaz5350_vdv","rhs_Ural_Open_VDV_01","rhs_Ural_VDV_01"]] call DICT_fnc_setLocal;
[_dict, "supplies", ["rhs_gaz66_ammo_vdv","rhs_Ural_Fuel_VDV_01","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv"]] call DICT_fnc_setLocal;

[_dict, "patrolVehicles", ["rhs_tigr_m_vdv","RHS_Mi8mt_vvsc"]] call DICT_fnc_setLocal;
[_dict, "ammoVehicles", ["rhsgref_ins_gaz66_ammo"]] call DICT_fnc_setLocal;
[_dict, "leadVehicles", ["rhs_tigr_sts_3camo_vdv"]] call DICT_fnc_setLocal;
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
indRF = "rhs_pdu4";
indFL = "rhs_acc_2dpZenit";
indLaser = "rhs_acc_perst1ik";

// Long-range radio
lrRadio = "tf_mr3000_rhs";
