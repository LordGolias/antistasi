bluHeliTrans = 		["RHS_MELB_MH6M","RHS_UH60M_d","RHS_CH_47F_light"];
bluHeliTS = 		["RHS_MELB_MH6M"];
bluHeliDis = 		["RHS_UH60M_d"];
bluHeliRope = 		["RHS_CH_47F_light"];
bluHeliArmed = 		["RHS_MELB_AH6M_H","RHS_MELB_AH6M_M"];
bluHeliGunship = 	["RHS_AH64D_AA","RHS_AH64D_GS","RHS_AH64D"];
bluCASFW = 			["RHS_A10"];

bluAS = 			["rhsusf_f22"];
bluC130 = 			["RHS_C130J"];

bluUAV = 			["B_UAV_02_F"];

planesNATO = bluHeliTrans + bluHeliArmed + bluHeliGunship + bluCASFW;
planesNATOTrans = bluHeliTrans;


bluMBT = 		["rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy"];
bluAPC = 		["RHS_M2A3","RHS_M2A3_BUSKI"];
bluIFV = 		["rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_supply"];
bluIFVAA = 		["RHS_M6"];
bluArty = 		["RHS_M119_D"];
bluMLRS = 		["B_MBT_01_mlrs_F"];
bluMRAP = 		["rhsusf_m1025_d","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop"];
bluMRAPHMG = 	["rhsusf_m1025_d_m2","rhsusf_rg33_m2_d"];
bluTruckTP = 	["rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy"];
bluTruckMed = 	["rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy"];
bluTruckFuel = 	["rhsusf_M978A4_BKIT_usarmy_d"];

vehNATO = bluMBT + bluAPC + bluIFV + bluIFVAA + bluArty + bluMLRS + bluMRAP + bluMRAPHMG + bluTruckTP + bluTruckMed + bluTruckFuel;


bluStatAA = 	["RHS_Stinger_AA_pod_D"];
bluStatAT = 	["RHS_TOW_TriPod_D"];
bluStatHMG = 	["RHS_M2StaticMG_D"];
bluStatMortar = ["RHS_M252_D"];


bluPilot = 	"rhsusf_army_ocp_helipilot";
bluCrew = 	"rhsusf_usmc_marpat_d_crewman";
bluGunner = "rhsusf_usmc_marpat_d_rifleman_light";

bluMRAPHMGgroup = 	["rhsusf_usmc_recon_marpat_d_rifleman_at_lite","rhsusf_usmc_recon_marpat_d_rifleman_lite","rhsusf_usmc_recon_marpat_d_machinegunner_m249_lite"];
bluMRAPgroup = 		["rhsusf_usmc_recon_marpat_d_teamleader_lite","rhsusf_usmc_recon_marpat_d_marksman_lite","rhsusf_usmc_recon_marpat_d_autorifleman_lite"];

bluAirCav = 	["rhsusf_usmc_recon_marpat_d_teamleader_fast","rhsusf_usmc_recon_marpat_d_marksman_fast","rhsusf_usmc_recon_marpat_d_autorifleman_fast","rhsusf_usmc_recon_marpat_d_rifleman_at_fast","rhsusf_usmc_recon_marpat_d_rifleman_fast","rhsusf_usmc_recon_marpat_d_machinegunner_m249_fast"];

bluSquad = 			["rhs_group_nato_usmc_d_infantry_squad"]; // 12
bluSquadWeapons = 	["rhs_group_nato_usmc_d_infantry_weaponsquad"]; // 7
bluTeam = 			["rhs_group_nato_usmc_d_infantry_team"]; // 4
bluATTeam = 		["rhs_group_nato_usmc_d_infantry_team_heavy_AT"]; // 4

bluIR = 	"rhsusf_acc_anpeq15";

bluFlag = 	"Flag_NATO_F";

bluCfgInf = (configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry");


bluRifle = 	[
	"rhs_weap_m16a4_carryhandle",
	"rhs_weap_m4a1_carryhandle",
	"rhs_weap_m4a1_d"
];

bluGL = [
	"rhs_weap_m16a4_carryhandle_M203",
	"rhs_weap_m4a1_carryhandle_m203S",
	"rhs_weap_m4a1_m203s_d"
];

bluSNPR = 	[
	"rhs_weap_M107_d",
	"rhs_weap_m40_d_usmc",
	"rhs_weap_sr25"
];

bluLMG = 	[
	"rhs_weap_m240G",
	"rhs_weap_m249_pip_L_para",
	"rhs_weap_m249_pip_S_vfg"
];

bluSmallWpn = 	[
	"rhs_weap_M590_5RD",
	"rhsusf_weap_m1911a1"
];

blu40mm = [
	"rhs_mag_M433_HEDP",
	"1Rnd_HE_Grenade_shell",
	"SmokeShell",
	"SmokeShellGreen",
	"rhs_mag_m576"
];

bluGrenades = [
	"HandGrenade",
	"MiniGrenade"
];

bluAT = [
	"rhs_weap_smaw_optic",
	"rhs_weap_M136_hedp"
];

bluAA = [
	"rhs_weap_fim92"
];

bluVest = [
	"rhsusf_spc_rifleman",
	"rhsusf_spc_crewman"
];

// todo: add helmets.
bluHelmets = [];

bluScopes = [
	"rhsusf_acc_LEUPOLDMK4",
	"rhsusf_acc_ACOG3_USMC",
	"rhsusf_acc_compm4"
];

bluAttachments = [
	"rhsusf_acc_harris_bipod",
	"muzzle_snds_B",
	"rhsusf_acc_anpeq15A",
	"rhsusf_acc_nt4_black"
];

genGL = genGL + bluGL;
genATLaunchers = genATLaunchers + bluAT;
genAALaunchers = genAALaunchers + bluAA;