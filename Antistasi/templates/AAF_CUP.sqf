/*
List of infantry classes. These will have individual equipment mapped to them.
*/

sol_MED = "CUP_O_INS_Medic"; // Medic
sol_ENG = "CUP_O_INS_Soldier_Engineer"; // Engineer
sol_OFF = "CUP_O_INS_Officer"; // Officer
sol_LAT2 = "CUP_O_INS_Soldier_AT"; // Light AT (extra)
sol_MK = "CUP_O_INS_Sniper"; // Marksman
sol_CREW = "CUP_O_INS_Crew";
sol_DRV = sol_CREW; // Driver (extra)

// Standard roles
infGunner = sol_CREW;
infCrew = sol_CREW;
infPilot = "CUP_O_INS_Pilot";
infMedic = sol_MED;
infDriver = sol_DRV;

// All classes sorted by role.
// 	To modders: The union of these lists define all equipment of AAF.
// 	I.e. AAF crates will only contain equipment that units in these lists carry.
infList_officers = 	[sol_OFF];
infList_sniper = 	[sol_MK];
infList_NCO = 		["CUP_O_INS_Commander"];
infList_special = 	["CUP_O_INS_Soldier_AA", sol_LAT2, sol_MED, sol_ENG];
infList_auto = 		["CUP_O_INS_Soldier_AR", "CUP_O_INS_Soldier_MG"];
infList_regular = 	["CUP_O_INS_Soldier", "CUP_O_INS_Soldier_Ammo", "CUP_O_INS_Soldier_GL", "CUP_O_INS_Soldier_AK74"];
infList_crew = 		[sol_CREW];
infList_pilots = 	[infPilot];

// Grups used for spawning groups.
// 	To modders: equipment of units in these groups is also part of the AAF equipment.
AAFConfigGroupInf = (configfile >> "CfgGroups" >> "East" >> "CUP_O_ChDKZ" >> "Infantry");
infPatrol = 		["CUP_O_ChDKZ_InfSquad_Weapons"];
infGarrisonSmall = 	["CUP_O_ChDKZ_InfSquad_Weapons"];
infTeamATAA =		["CUP_O_ChDKZ_InfSection_AT","CUP_O_ChDKZ_InfSection_AA"];
infTeam = 			["CUP_O_ChDKZ_InfSquad_Weapons", "CUP_O_ChDKZ_InfSquad"];
infSquad = 			["CUP_O_ChDKZ_InfSquad_Weapons", "CUP_O_ChDKZ_InfSquad"];
infAA =				["CUP_O_ChDKZ_InfSection_AA"];
infAT =				["CUP_O_ChDKZ_InfSection_AT"];

// 	To modders: overwrite this in the template to change the AAF arsenal.
// 	Rules:
// 		1. vehicle must exist.
// 		2. each vehicle must belong to only one category.
if (isServer) then {
	["planes", "valid", ["CUP_O_Su25_RU_1"]] call AS_AAFarsenal_fnc_set;
	["armedHelis", "valid", ["CUP_O_Mi24_P_RU", "CUP_O_Ka60_Grey_RU"]] call AS_AAFarsenal_fnc_set;
	["transportHelis", "valid", ["CUP_O_Mi8_CHDKZ", "CUP_O_Mi8_medevac_CHDKZ", "CUP_O_Mi8_VIV_CHDKZ"]] call AS_AAFarsenal_fnc_set;
	["tanks", "valid", ["CUP_O_T72_CHDKZ"]] call AS_AAFarsenal_fnc_set;
	["boats", "valid", ["I_Boat_Armed_01_minigun_F"]] call AS_AAFarsenal_fnc_set;
	["apcs", "valid", ["CUP_O_BRDM2_CHDKZ", "CUP_O_BRDM2_ATGM_CHDKZ", "CUP_O_HQ_CHDKZ", "CUP_O_BMP2_CHDKZ", "CUP_O_BMP2_HQ_CHDKZ"]] call AS_AAFarsenal_fnc_set;
	["trucks", "valid", ["CUP_O_Ural_CHDKZ", "CUP_O_Ural_Open_CHDKZ"]] call AS_AAFarsenal_fnc_set;
	["supplies", "valid", ["CUP_O_Ural_Reammo_CHDKZ", "CUP_O_Ural_Refuel_CHDKZ", "CUP_O_Ural_Repair_CHDKZ"]] call AS_AAFarsenal_fnc_set;
};

// List of special vehicles used in custom events
vehPatrol = ["CUP_O_BRDM2_CHDKZ","CUP_O_BRDM2_ATGM_CHDKZ","CUP_O_BMP2_CHDKZ","CUP_O_Ka60_Grey_RU"];
vehAmmo = "CUP_O_Ural_Reammo_CHDKZ";
vehLead = ["CUP_O_BMP2_CHDKZ","CUP_O_BRDM2_CHDKZ"];  // lead of convoy
vehTruckBox = ["CUP_O_Ural_Repair_CHDKZ"];
vehBoat = "I_Boat_Armed_01_minigun_F";

AS_AAFarsenal_uav = "";  // Set to `""` to AAF not use UAVs.

// Statics to be used
statMG = 			"CUP_O_KORD_high_CHDKZ";
statAT = 			"CUP_O_Meltis_CHDKZ";
statAA = 			"CUP_O_ZU23_CHDKZ";
statAA2 = 			"CUP_O_ZU23_CHDKZ";
statMortar = 		"CUP_O_2b14_82mm_CHDKZ";

statMGlow = 		"CUP_O_KORD_CHDKZ";
statMGtower = 		"CUP_O_KORD_high_CHDKZ";

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
genAALaunchers = ["CUP_launch_9K32Strela"];
genATLaunchers = ["CUP_launch_RPG7V", "CUP_launch_RPG18"];

// These have to be CfgVehicles
AAFExponsives = [
	"SatchelCharge_F"
];

// These have to be CfgVehicles mines that explode automatically (minefields)
AAFMines = ["CUP_MineE", "CUP_Mine"];

atMine = "CUP_Mine";
apMine = "CUP_MineE";

// NVG, flashlight, laser, mine types
indNVG = "CUP_NVG_PVS7";
indFL = "CUP_acc_flashlight";
indLaser = "CUP_acc_ANPEQ_2_camo";

// The flag
cFlag = "Flag_Red_F";
AS_AAFname = "ChDKZ";

// Long range radio
lrRadio = "tf_rt1523g_green";

// Define the ammo crate to be spawned at camps
campCrate = "Box_NATO_Equip_F";
