private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["rhs_Mi8AMTSh_FAB_vvs"]] call DICT_fnc_setLocal;
[_dict, "helis_land", []] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", ["rhs_ka60_grey"]] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["rhs_mi28n_vvs"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["RHS_Mi8AMTSh_vvs"]] call DICT_fnc_setLocal;
[_dict, "planes", ["RHS_Su25SM_vvs", "RHS_T50_vvs_generic"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["rhs_pchela1t_vvs"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

[_dict, "mbts", ["rhs_t72bd_tv", "rhs_t80um", "rhs_t90a_tv"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["rhs_kamaz5350_open_vmf", "rhs_kamaz5350_vmf"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["rhs_btr80_vmf", "rhs_btr80a_vmf", "rhs_btr70_vmf"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars", ["rhs_tigr_vmf", "rhs_tigr_m_vmf"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["rhs_D30_vdv"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["rhs_2s3_tv"]] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"rhs_gaz66_ammo_vmf", "rhs_ural_fuel_vmf_01", "rhs_gaz66_ap2_vmf", "rhs_ural_repair_vmf_01"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["rhs_zsu234_aa"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "rhs_vmf_recon_officer"] call DICT_fnc_setLocal;
[_dict, "traitor", "rhs_vmf_recon_officer_armored"] call DICT_fnc_setLocal;
[_dict, "gunner", "rhs_vmf_recon_rifleman_l"] call DICT_fnc_setLocal;
[_dict, "crew", "rhs_vmf_recon_rifleman_l"] call DICT_fnc_setLocal;
[_dict, "pilot", "rhs_pilot_combat_heli"] call DICT_fnc_setLocal;

// infantry classes, to allow for class-specific pricing
opI_RFL1 = 	"rhs_vmf_recon_rifleman_l";
opI_SL = 	"rhs_vmf_recon_sergeant";

// config path for infantry groups
[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry"] call DICT_fnc_setLocal;
opGroup_SpecOps = ["rhs_group_rus_vdv_infantry_section_marksman"];
opGroup_Squad = ["rhs_group_rus_vdv_infantry_squad_sniper", "rhs_group_rus_vdv_infantry_squad_mg_sniper",
                 "rhs_group_rus_vdv_infantry_squad", "rhs_group_rus_vdv_infantry_squad_2mg"];
opGroup_Recon_Team = ["rhs_group_rus_vdv_infantry_fireteam"];

// the affiliation
opFlag = "rhs_Flag_vmf_F";
// Its acronym
AS_CSATname = "VMF";

opIR = "rhs_acc_perst1ik";

opCrate = "Box_East_WpsLaunch_F";
