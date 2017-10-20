// (un-)armed transport helicopters
opHeliTrans = 		["RHS_MELB_MH6M","RHS_UH60M_d","RHS_CH_47F_light"];

// helicopter that dismounts troops
opHeliDismount = 	"RHS_UH60M_d"; // Mi-290 Taru (Bench)

// helicopter that fastropes troops in
opHeliFR = 			"RHS_UH60M_d"; // PO-30 Orca (Unarmed)

// small armed helicopter
opHeliSD = 			["RHS_MELB_AH6M_H","RHS_MELB_AH6M_M"]; // PO-30 Orca (Armed)

// gunship
opGunship = 		"RHS_AH64D_GS"; // Mi-48 Kajman

// CAS, fixed-wing
opCASFW = 			["RHS_A10"]; // To-199 Neophron (CAS)

// small UAV (Darter, etc)
opUAVsmall = 		"B_UAV_01_F"; // Tayran AR-2

// air force
opAir = 			["RHS_AH64D_GS","RHS_MELB_MH6M","RHS_A10","rhsusf_f22"];

// self-propelled anti air
opSPAA = 			"B_APC_Tracked_01_AA_F";

opTruck = 			"rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy";

opMRAPu = 			"rhsusf_rg33_m2_usmc_wd";

// infantry classes, to allow for class-specific pricing
opI_OFF = 	"rhsusf_usmc_marpat_wd_officer"; // officer/official
opI_PIL = 	"rhsusf_army_ocp_helipilot"; // pilot
opI_OFF2 = 	"rhsusf_usmc_recon_marpat_wd_officer"; // officer/traitor
opI_CREW = 	"rhsusf_usmc_marpat_d_crewman"; // crew
opI_RFL1 = 	"rhsusf_usmc_recon_marpat_wd_rifleman_lite";
opI_SL = 	"rhsusf_usmc_recon_marpat_wd_teamleader_lite";

// config path for infantry groups
CSATConfigGroupInf = (configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry");
opGroup_SpecOps = ["rhs_group_nato_usmc_wd_infantry_team"];
opGroup_Squad = ["rhs_group_nato_usmc_wd_infantry_squad_sniper", "rhs_group_nato_usmc_wd_infantry_weaponsquad",
                 "rhs_group_nato_usmc_wd_infantry_squad"];
opGroup_Recon_Team = ["rhs_group_nato_usmc_wd_infantry_team"];

// the affiliation
opFlag = "Flag_US_F";

opIR = "rhsusf_acc_anpeq15";

opCrate = "Box_FIA_Wps_F";
