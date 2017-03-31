bluHeliTrans = 		["B_Heli_Light_01_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_03_F"];
bluHeliTS = 		["B_Heli_Light_01_F"];
bluHeliDis = 		["B_Heli_Transport_01_camo_F"];
bluHeliRope = 		["B_Heli_Transport_03_F"];
bluHeliArmed = 		["B_Heli_Light_01_armed_F"];
bluHeliGunship = 	["B_Heli_Attack_01_F"];
bluCASFW = 			["B_Plane_CAS_01_F"];

bluAS = 			[""];
bluC130 = 			[""];

bluUAV = 			["B_UAV_02_F"];

planesNATO = bluHeliTrans + bluHeliArmed + bluHeliGunship + bluCASFW;
planesNATOTrans = bluHeliTrans;


bluMBT = 		["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"];
bluAPC = 		["B_APC_Wheeled_01_cannon_F"];
bluIFV = 		["B_APC_Tracked_01_rcws_F"];
bluIFVAA = 		["B_APC_Tracked_01_AA_F"];
bluArty = 		["B_MBT_01_arty_F"];
bluMLRS = 		["B_MBT_01_mlrs_F"];
bluMRAP =		["B_MRAP_01_F"];
bluMRAPHMG =	["B_MRAP_01_hmg_F"];
bluTruckTP = 	["B_Truck_01_covered_F"];
bluTruckMed = 	["B_Truck_01_medical_F"];
bluTruckFuel = 	["B_Truck_01_fuel_F"];

vehNATO = bluMBT + bluAPC + bluIFV + bluIFVAA + bluArty + bluMLRS + bluMRAP + bluMRAPHMG + bluTruckTP + bluTruckMed + bluTruckFuel;


bluStatAA = 	["B_static_AA_F"];
bluStatAT = 	["B_static_AT_F"];
bluStatHMG = 	["B_HMG_01_high_F"];
bluStatMortar = ["B_G_Mortar_01_F"];


bluPilot = 	"B_Pilot_F";
bluCrew = 	"B_crew_F";
bluGunner = "B_support_MG_F";

bluMRAPHMGgroup = 	["B_recon_LAT_F","B_Recon_Sharpshooter_F"];
bluMRAPgroup = 		["B_recon_medic_F","B_recon_F","B_recon_JTAC_F"];

bluAirCav = 	["B_recon_TL_F","B_recon_LAT_F","B_Recon_Sharpshooter_F","B_recon_medic_F","B_recon_F","B_recon_JTAC_F"];


bluSquad = 			["BUS_InfSquad"];
bluSquadWeapons = 	["BUS_InfSquad_Weapons"];
bluTeam = 			["BUS_InfTeam"];
bluATTeam = 		["BUS_InfTeam_AT"];

bluIR = 	"acc_pointer_IR";

bluFlag = 	"Flag_NATO_F";

bluCfgInf = (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry");


bluRifle = [
	"arifle_MXC_F",
    "arifle_MX_F"
];

bluGL = [
	"arifle_MX_GL_F"
];

bluSNPR = [
	"srifle_LRR_F",
	"srifle_DMR_02_F",
	"srifle_EBR_F",
	"srifle_DMR_03_F"
];

bluLMG = [
	"MMG_02_sand_F",
	"arifle_MX_SW_F"
];

bluSmallWpn = [
	"SMG_02_F",
	"hgun_ACPC2_F"
];

// first needs to be the dammage one.
blu40mm = [
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell"
];

bluGrenades = [
	"HandGrenade",
    "MiniGrenade"
];

bluAT = [
	"launch_B_Titan_short_F",
	"launch_NLAW_F"
];

bluAA = [
	"launch_B_Titan_F"
];

bluVest = [
    "V_PlateCarrier1_rgr",
    "V_PlateCarrier2_rgr",
	"V_PlateCarrierGL_rgr",
    "V_PlateCarrierSpec_rgr"
];

bluHelmets = [
    "H_HelmetB",
    "H_HelmetB_light",
    "H_HelmetSpecB"
];

bluScopes = AS_allOptics;

bluAttachments = [
	"muzzle_snds_338_sand",
	"bipod_01_F_snd",
	"muzzle_snds_H_khk_F",
	"muzzle_snds_B_snd_F"
];

genGL = genGL + bluGL;
