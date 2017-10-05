private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["rhs_Mi8AMTSh_FAB_vvs"]] call DICT_fnc_setLocal;
[_dict, "helis_land", []] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", ["rhs_ka60_grey"]] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["rhs_mi28n_vvs"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["RHS_Mi8AMTSh_vvs"]] call DICT_fnc_setLocal;
[_dict, "planes", ["RHS_Su25SM_vvs", "RHS_T50_vvs_generic"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["rhs_pchela1t_vvs"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

// self-propelled anti air
opSPAA = 			"rhs_zsu234_aa";

opTruck = 			"rhs_kamaz5350_vdv";

opMRAPu = 			"rhs_tigr_vmf";

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
