private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

// (un-)armed transport helicopters
opHeliTrans = 		["rhs_ka60_grey","RHS_Mi8AMTSh_FAB_vvs"];

// helicopter that dismounts troops
opHeliDismount = 	"RHS_Mi8AMTSh_FAB_vvs"; // Mi-290 Taru (Bench)

// helicopter that fastropes troops in
opHeliFR = 			"rhs_ka60_grey"; // PO-30 Orca (Unarmed)

// small armed helicopter
opHeliSD = 			"RHS_Mi8AMTSh_vvs"; // PO-30 Orca (Armed)

// gunship
opGunship = 		"rhs_mi28n_vvs"; // Mi-48 Kajman

// CAS, fixed-wing
opCASFW = 			["RHS_Su25SM_vvs", "RHS_T50_vvs_generic"]; // To-199 Neophron (CAS)

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

[_dict, "static_aa", "rhs_Igla_AA_pod_vdv"] call DICT_fnc_setLocal;
[_dict, "static_at", "rhs_Metis_9k115_2_vdv"] call DICT_fnc_setLocal;
[_dict, "static_mg", "rhs_KORD_high_vdv"] call DICT_fnc_setLocal;
[_dict, "static_mg_low", "rhs_KORD_vdv"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "rhs_2b14_82mm_vdv"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry"] call DICT_fnc_setLocal;
[_dict, "squad", "rhs_group_rus_vdv_infantry_squad"] call DICT_fnc_setLocal;
[_dict, "team", "rhs_group_rus_vdv_infantry_fireteam"] call DICT_fnc_setLocal;
[_dict, "recon_squad", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv">> "rhs_group_rus_vdv_infantry_recon" >> "rhs_group_rus_vdv_infantry_recon_squad"] call DICT_fnc_setLocal;
[_dict, "recon_team", configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv">> "rhs_group_rus_vdv_infantry_recon" >>"rhs_group_rus_vdv_infantry_recon_fireteam"] call DICT_fnc_setLocal;

[_dict, "name", "VMF"] call DICT_fnc_setLocal;
[_dict, "flag", "rhs_Flag_vmf_F"] call DICT_fnc_setLocal;
[_dict, "box", "Box_East_WpsLaunch_F"] call DICT_fnc_setLocal;
