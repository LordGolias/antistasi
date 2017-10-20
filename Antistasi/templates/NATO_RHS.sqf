bluHeliTrans = 		["rhs_ka60_grey","RHS_Mi8AMTSh_FAB_vvs"];
bluHeliTS = 		["rhs_ka60_grey"];
bluHeliDis = 		["RHS_Mi8AMTSh_FAB_vvs"];
bluHeliRope = 		["rhs_ka60_grey"];
bluHeliArmed = 		["O_Heli_Light_02_dynamicLoadout_F"];
bluHeliGunship = 	["rhs_mi28n_vvs"];
bluCASFW = 			["RHS_Su25SM_vvs", "RHS_T50_vvs_generic"];

bluUAV = 			["rhs_pchela1t_vvs"];

planesNATO = bluHeliTrans + bluHeliArmed + bluHeliGunship + bluCASFW;
planesNATOTrans = bluHeliTrans;

bluMBT = 		["rhs_t80um","rhs_t80uk", "rhs_t90a_tv"];
bluAPC = 		["btr_70_vdv","rhs_btr80a_vdv"];
bluIFV = 		["rhs_bmp2k_vdv","rhs_bmd4m_vdv"];
bluIFVAA = 		["RHS_Ural_Zu23_VDV_01", "rhs_zsu234_aa"];
bluArty = 		["rhs_sprut_vdv"];
bluMLRS = 		["RHS_BM21_VDV_01"];
bluMRAP = 		["rhsgref_BRDM2_vdv","rhsgref_BRDM2UM_vdv","rhs_tigr_vdv"];
bluMRAPHMG = 	["rhsgref_BRDM2_HQ_vdv","rhs_tigr_sts_vdv"];
bluTruckTP = 	["rhs_kamaz5350_vdv"];
bluTruckMed = 	["rhs_gaz66_ap2_vdv"];
bluTruckFuel = 	["RHS_Ural_Fuel_VDV_01"];

vehNATO = bluMBT + bluAPC + bluIFV + bluIFVAA + bluArty + bluMLRS + bluMRAP + bluMRAPHMG + bluTruckTP + bluTruckMed + bluTruckFuel;


bluStatAA = 	["rhs_Igla_AA_pod_vdv"];
bluStatAT = 	["rhs_Metis_9k115_2_vdv"];
bluStatHMG = 	["RHS_NSV_TriPod_VDV"];
bluStatMortar = ["rhs_2b14_82mm_vdv"];


bluPilot = 	"rhs_pilot_combat_heli";
bluCrew = 	"rhs_vdv_combatcrew";
bluGunner = "rhs_vdv_rifleman";
bluMRAPHMGgroup = 	["rhs_vdv_flora_rifleman","rhs_vdv_flora_rifleman_lite","rhs_vdv_flora_machinegunner"];
bluMRAPgroup = 		["rhs_vdv_flora_rifleman","rhs_vdv_flora_rifleman_lite","rhs_vdv_flora_machinegunner"];
bluAirCav = 	["rhs_vdv_recon_sergeant","rhs_vdv_recon_marksman","rhs_vdv_recon_arifleman","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_marksman_vss"];

NATOConfigGroupInf = (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora");
bluSquad = 			["rhs_group_rus_vdv_infantry_flora_squad"];
bluSquadWeapons = 	["rhs_group_rus_vdv_infantry_flora_squad_2mg"];
bluTeam = 			["rhs_group_rus_vdv_infantry_flora_fireteam"];
bluATTeam = 		["rhs_group_rus_vdv_infantry_flora_section_AT"];

bluIR = 	"rhsusf_acc_perst1ik";

bluFlag = 	"rhs_Flag_VDV_F";

blu40mm = [
	"rhs_VOG25",
	// "1Rnd_HE_Grenade_shell",
	"SmokeShell",
	"SmokeShellGreen",
	"rhs_vg40tb"
];

bluAT = [
	"rhs_weap_rpg26",
	"rhs_weap_rpg7"
];

bluAA = [
	"rhs_weap_igla"
];

genATLaunchers = genATLaunchers + bluAT;
genAALaunchers = genAALaunchers + bluAA;
