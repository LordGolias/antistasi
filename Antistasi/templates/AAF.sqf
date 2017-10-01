/*
List of infantry classes. These will have individual equipment mapped to them.
*/
sol_A_AA = 	"I_Soldier_AAA_F"; // Assistant AA
sol_A_AR = 	"I_Soldier_AAR_F"; // Assistant autorifle
sol_A_AT = 	"I_Soldier_AAT_F"; // Assistant AT
sol_AA = 	"I_Soldier_AA_F"; // AA
sol_AR = 	"I_Soldier_AR_F"; // Autorifle
sol_AT = 	"I_Soldier_AT_F"; // AT
sol_AMMO = 	"I_Soldier_A_F"; // Ammo bearer
sol_GL = 	"I_Soldier_GL_F"; // Grenade launcher
sol_GL2 = 	"I_Soldier_GL_F"; // Grenade launcher (extra)
sol_LAT = 	"I_Soldier_LAT_F"; // Light AT
sol_LAT2 = 	"I_Soldier_LAT_F"; // Light AT (extra)
sol_MG = 	"I_Soldier_AR_F"; // Machinegunner (extra)
sol_MK = 	"I_Soldier_M_F"; // Marksman
sol_SL = 	"I_Soldier_SL_F"; // Squad leader
sol_TL = 	"I_Soldier_TL_F"; // Team leader
sol_TL2 = 	"I_Soldier_TL_F"; // Team leader (extra)
sol_EXP = 	"I_Soldier_exp_F"; // Explosives
sol_R_L = 	"I_Soldier_lite_F"; // Rifleman, light
sol_REP = 	"I_Soldier_repair_F"; // Repair
sol_UN = 	"I_Soldier_unarmed_F"; // Unarmed
sol_RFL = 	"I_soldier_F"; // Rifleman
sol_SN = 	"I_Sniper_F"; // Sniper
sol_SP = 	"I_Spotter_F"; // Spotter
sol_MED = 	"I_medic_F"; // Medic
sol_ENG = 	"I_engineer_F"; // Engineer
sol_OFF = 	"I_officer_F"; // Officer
sol_OFF2 = 	"I_officer_F"; // Officer (extra)

sol_CREW = 	"I_crew_F"; // Crew
sol_CREW2 = "I_crew_F"; // Crew (extra)
sol_CREW3 = "I_crew_F"; // Crew (extra)
sol_CREW4 = "I_crew_F"; // Crew (extra)
sol_DRV = 	"I_crew_F"; // Driver (extra)
sol_DRV2 = 	"I_crew_F"; // Driver (extra)
sol_HCREW = "I_helicrew_F"; // Helicopter crew
sol_HPIL = 	"I_helipilot_F"; // Helicopter pilot
sol_HPIL2 = "I_helipilot_F"; // Helicopter pilot (extra)
sol_PIL = 	"I_pilot_F"; // Pilot
sol_UAV = 	"I_soldier_UAV_F"; // UAV controller

sol_SUP_AMG = 	"I_support_AMG_F"; // Assistant HMG gunner
sol_SUP_AMTR = 	"I_support_AMort_F"; // Assistant mortar gunner
sol_SUP_GMG = 	"I_support_GMG_F"; // GMG gunner
sol_SUP_MG = 	"I_support_MG_F"; // HMG gunner
sol_SUP_MTR = 	"I_support_Mort_F"; // mortar gunner

// Standard roles for static gunner, crew, and unarmed helicopter pilot
infGunner =	sol_SUP_MG;
infCrew = 	sol_CREW;
infPilot = 	sol_HPIL;

// All classes sorted by role.
// 	To modders: The union of these lists define all equipment of AAF.
// 	I.e. AAF crates will only contain equipment that units in these lists carry.
infList_officers = 	[sol_OFF, sol_OFF2];
infList_sniper = 	[sol_MK, sol_SN, sol_SP];
infList_NCO = 		[sol_SL, sol_TL, sol_TL2];
infList_special = 	[sol_A_AA, sol_A_AT, sol_AA, sol_AT, sol_EXP, sol_REP, sol_ENG, sol_MED];
infList_auto = 		[sol_AR, sol_MG];
infList_regular = 	[sol_A_AR, sol_AMMO, sol_GL, sol_GL2, sol_LAT, sol_LAT2, sol_R_L, sol_RFL];
infList_crew = 		[sol_UN, sol_CREW, sol_CREW2, sol_CREW3, sol_CREW4, sol_DRV, sol_DRV2, sol_HCREW, sol_UAV, sol_SUP_AMG, sol_SUP_AMTR, sol_SUP_GMG, sol_SUP_MG, sol_SUP_MTR];
infList_pilots = 	[sol_HPIL, sol_HPIL2, sol_PIL];

// Grups used for spawning groups.
// 	To modders: equipment of units in these groups is also part of the AAF equipment.
AAFConfigGroupInf = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry");
infPatrol = 		["HAF_InfSentry","HAF_InfSentry","HAF_InfSentry","HAF_SniperTeam"];
infGarrisonSmall = 	["HAF_InfSentry"];
infTeamATAA =		["HAF_InfTeam_AA","HAF_InfTeam_AT"];
infTeam = 			["HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_InfTeam","HAF_InfTeam","HAF_InfTeam"];
infSquad = 			["HAF_InfSquad","HAF_InfSquad_Weapons"];
infAA =				["HAF_InfTeam_AA"];
infAT =				["HAF_InfTeam_AT"];

// 	To modders: overwrite this in the template to change the AAF arsenal.
// 	Rules:
// 		1. vehicle must exist.
// 		2. each vehicle must belong to only one category.
if (isServer) then {
	["planes", "valid", ["I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F"]] call AS_AAFarsenal_fnc_set;
	["armedHelis", "valid", ["I_Heli_light_03_F"]] call AS_AAFarsenal_fnc_set;
	["transportHelis", "valid", ["I_Heli_Transport_02_F"]] call AS_AAFarsenal_fnc_set;
	["tanks", "valid", ["I_MBT_03_cannon_F"]] call AS_AAFarsenal_fnc_set;
	["boats", "valid", ["I_Boat_Armed_01_minigun_F"]] call AS_AAFarsenal_fnc_set;
	["apcs", "valid", ["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MRAP_03_F","I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"]] call AS_AAFarsenal_fnc_set;
	["trucks", "valid", ["I_Truck_02_covered_F","I_Truck_02_transport_F"]] call AS_AAFarsenal_fnc_set;
	["supplies", "valid", ["I_Truck_02_fuel_F","I_Truck_02_medical_F","I_Truck_02_ammo_F"]] call AS_AAFarsenal_fnc_set;
};

// 	To modders (optional): use "cost" to set cost for the AAF
// 	to buy vehicles of CATEGORY. E.g.
//      ["planes", "cost", 20000] call AS_AAFarsenal_fnc_set;

// 	To modders (optional): use "value" to set value the FIA gets to sell AAF vehicles of CATEGORY.
// 		["planes", "value", 10000] call AS_AAFarsenal_fnc_set;

// List of special vehicles used in custom events
//	moders: all vehicles defined in these lists must also belong to the AAFarsenal.
vehPatrol = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Heli_light_03_F"];
vehAmmo = "I_Truck_02_ammo_F";
vehLead = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];  // lead of convoy
vehTruckBox = ["I_Truck_02_box_F"];
vehBoat = "I_Boat_Armed_01_minigun_F";

AS_AAFarsenal_uav = "I_UAV_02_F";  // Set to `""` to AAF not use UAVs.

// Statics to be used
statMG = 			"I_HMG_01_high_F";
statAT = 			"I_static_AT_F";
statAA = 			"I_static_AA_F";
statAA2 = 			"I_static_AA_F";
statMortar = 		"I_Mortar_01_F";

statMGlow = 		"I_HMG_01_F";
statMGtower = 		"I_HMG_01_high_F";

// Lists of statics to determine the defensive capabilities at locations
allStatMGs = 		allStatMGs + [statMG];
allStatATs = 		allStatATs + [statAT];
allStatAAs = 		allStatAAs + [statAA];
allStatMortars = 	allStatMortars + [statMortar];

// Backpacks of dismantled statics -- 0: weapon, 1: tripod/support
statMGBackpacks = 		["I_HMG_01_high_weapon_F","I_HMG_01_support_high_F"];
statATBackpacks = 		["I_AT_01_weapon_F","I_HMG_01_support_F"];
statAABackpacks = 		["I_AA_01_weapon_F","I_HMG_01_support_F"];
statMortarBackpacks = 	["I_Mortar_01_weapon_F","I_Mortar_01_support_F"];
statMGlowBackpacks = 	["I_HMG_01_F","I_HMG_01_support_F"];
statMGtowerBackpacks = 	["I_HMG_01_high_weapon_F","I_HMG_01_support_high_F"];

// Default launchers
genAALaunchers = ["launch_I_Titan_F"];
genATLaunchers = ["launch_I_Titan_short_F","launch_NLAW_F"];

// These have to be CfgVehicles
AAFExponsives = [
	"SatchelCharge_F",
	"DemoCharge_F",
	"ClaymoreDirectional_F"
];

// These have to be CfgVehicles mines that explode automatically (minefields)
AAFMines = [
	"SLAMDirectionalMine",
	"ATMine",
	"APERSMine",
	"APERSTripMine",
	"APERSBoundingMine"
];

atMine = "ATMine";
apMine = "APERSMine";

// Equipment unlocked by default
if (isServer) then {
	unlockedWeapons = [
		"hgun_PDW2000_F",
		"hgun_ACPC2_F"
	];

	unlockedMagazines = [
		"9Rnd_45ACP_Mag",
		"30Rnd_9x21_Mag"
	];

	unlockedBackpacks = [
		"B_TacticalPack_blk"
	];
};

// NVG, flashlight, laser, mine types
indNVG = 		"NVGoggles_INDEP";
indRF = 		"Rangefinder";
indFL = 		"acc_flashlight";
indLaser = 		"acc_pointer_IR";

// The flag
cFlag = "Flag_AAF_F";
AS_AAFname = "AAF";

// Long range radio
lrRadio = "tf_rt1523g_green";

// Define the ammo crate to be spawned at camps
campCrate = "Box_NATO_Equip_F";
