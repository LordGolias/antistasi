bluHeliTrans = 		["B_Heli_Light_01_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_03_F"];
bluHeliTS = 		["B_Heli_Light_01_F"];
bluHeliDis = 		["B_Heli_Transport_01_camo_F"];
bluHeliRope = 		["B_Heli_Transport_03_F"];
bluHeliArmed = 		["B_Heli_Light_01_armed_F"];
bluHeliGunship = 	["B_Heli_Attack_01_F"];
bluCASFW = 			["B_Plane_CAS_01_F"];

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

// Soldiers
bluPilot = 	"B_Pilot_F";
bluCrew = 	"B_crew_F";
bluGunner = "B_support_MG_F";
bluAirCav = 	["B_recon_TL_F","B_recon_LAT_F","B_Recon_Sharpshooter_F","B_recon_medic_F","B_recon_F","B_recon_JTAC_F"];

// groups that are spawned
NATOConfigGroupInf = (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry");
bluSquad = 			["BUS_InfSquad"];
bluSquadWeapons = 	["BUS_InfSquad_Weapons"];
bluTeam = 			["BUS_InfTeam"];
bluATTeam = 		["BUS_InfTeam_AT"];

bluIR = 	"acc_pointer_IR";

bluFlag = 	"Flag_NATO_F";
AS_NATOname = "NATO";

bluAT = [
	"launch_B_Titan_short_F",
	"launch_NLAW_F"
];

bluAA = [
	"launch_B_Titan_F"
];
