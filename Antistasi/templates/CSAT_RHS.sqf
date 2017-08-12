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

// small UAV (Darter, etc)
opUAVsmall = 		"rhs_pchela1t_vvs"; // Tayran AR-2

// air force
opAir = 			["rhs_ka60_grey","RHS_Mi8AMTSh_FAB_vvs","rhs_mi28n_vvs","RHS_Su25SM_vvs","RHS_Mi24P_vvs"];

// self-propelled anti air
opSPAA = 			"rhs_zsu234_aa";

opTruck = 			"rhs_kamaz5350_vdv";

opMRAPu = 			"rhs_tigr_vmf";

// infantry classes, to allow for class-specific pricing
opI_OFF = 	"rhs_vmf_recon_officer"; // officer/official
opI_PIL = 	"rhs_pilot_combat_heli"; // pilot
opI_OFF2 = 	"rhs_vmf_recon_officer_armored"; // officer/traitor
opI_CREW = 	"rhs_vmf_recon_rifleman"; // crew
opI_RFL1 = 	"rhs_vmf_recon_rifleman_l";
opI_SL = 	"rhs_vmf_recon_sergeant";

// config path for infantry groups
CSATConfigGroupInf = (configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry");
opGroup_SpecOps = ["rhs_group_rus_vdv_infantry_section_marksman"];
opGroup_Squad = ["rhs_group_rus_vdv_infantry_squad_sniper", "rhs_group_rus_vdv_infantry_squad_mg_sniper",
                 "rhs_group_rus_vdv_infantry_squad", "rhs_group_rus_vdv_infantry_squad_2mg"];
opGroup_Recon_Team = ["rhs_group_rus_vdv_infantry_fireteam"];

// the affiliation
opFlag = "Flag_CSAT_F";

opIR = "rhs_acc_perst1ik";

opCrate = "Box_East_WpsLaunch_F";
