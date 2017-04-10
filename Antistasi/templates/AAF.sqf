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

// All classes sorted by role, used for pricing, etc
infList_officers = 	[sol_OFF, sol_OFF2];
infList_sniper = 	[sol_MK, sol_SN, sol_SP];
infList_NCO = 		[sol_SL, sol_TL, sol_TL2];
infList_special = 	[sol_A_AA, sol_A_AT, sol_AA, sol_AT, sol_EXP, sol_REP, sol_ENG, sol_MED];
infList_auto = 		[sol_A_AR, sol_MG];
infList_regular = 	[sol_AMMO, sol_GL, sol_GL2, sol_LAT, sol_LAT2, sol_R_L, sol_RFL];
infList_crew = 		[sol_UN, sol_CREW, sol_CREW2, sol_CREW3, sol_CREW4, sol_DRV, sol_DRV2, sol_HCREW, sol_UAV, sol_SUP_AMG, sol_SUP_AMTR, sol_SUP_GMG, sol_SUP_MG, sol_SUP_MTR];
infList_pilots = 	[sol_HPIL, sol_HPIL2, sol_PIL];

// 	To modders: overwrite this in the template to change the AAF arsenal.
// 	Rules:
// 		1. vehicle must exist.
// 		2. each vehicle must belong to only one category.
AS_AAFarsenal setVariable ["valid_planes", ["I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F"], true];
AS_AAFarsenal setVariable ["valid_armedHelis", ["I_Heli_light_03_F"], true];
AS_AAFarsenal setVariable ["valid_transportHelis", ["I_Heli_Transport_02_F"], true];
AS_AAFarsenal setVariable ["valid_tanks", ["I_MBT_03_cannon_F"], true];
AS_AAFarsenal setVariable ["valid_apcs", [
	"I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F",
	"I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"], true];
AS_AAFarsenal setVariable ["valid_trucks", ["I_Truck_02_covered_F","I_Truck_02_transport_F"], true];
AS_AAFarsenal setVariable ["valid_supplies", ["I_Truck_02_fuel_F","I_Truck_02_medical_F","I_Truck_02_ammo_F"], true];

// Initial setup: AAF starts without vehicles.
// 	To modders: change these in the template to set an initial arsenal.
{
	AS_AAFarsenal setVariable [_x, [], true];
} forEach AS_AAFarsenal_categories;

// 	To modders (optional): use a "cost_" to set cost for the AAF
// 	to buy vehicles of CATEGORY. E.g.
// 		AS_AAFarsenal setVariable ["cost_planes, 20000, true];

// 	To modders (optional): use a "value_" to set value the FIA gets to sell AAF vehicles of CATEGORY.
// 		AS_AAFarsenal setVariable ["value_planes, 10000, true];

// List of special vehicles used in custom events
//	moders: all vehicles defined in these lists must also belong to the AAFarsenal.
vehPatrol = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Heli_light_03_unarmed_F"];
vehAmmo = "I_Truck_02_ammo_F";
vehLead = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];  // lead of convoy
vehTruckBox = ["I_Truck_02_box_F"];

AS_AAFarsenal_uav = "I_UAV_02_F";  // Set to `""` to FIA not use UAVs.

// Config paths for pre-defined groups -- required if group names are used
cfgInf = 				(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry");

// Standard group arrays, used for spawning groups -- can use full config paths, config group names, arrays of individual soldiers
infPatrol = 		["HAF_InfSentry","HAF_InfSentry","HAF_InfSentry","HAF_SniperTeam"];
infGarrisonSmall = 	["HAF_InfSentry"];
infTeamATAA =		["HAF_InfTeam_AA","HAF_InfTeam_AT"];
infTeam = 			["HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_InfTeam","HAF_InfTeam","HAF_InfTeam"];
infSquad = 			["HAF_InfSquad","HAF_InfSquad_Weapons"];
infAA =				["HAF_InfTeam_AA"];
infAT =				["HAF_InfTeam_AT"];

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

/*
================ Gear ================
Weapons, ammo, launchers, missiles, mines, items and optics will spawn in ammo crates, the rest will not. These lists, together with the corresponding lists in the NATO/USAF template, determine what can be unlocked. Weapons of all kinds and ammo are the exception: they can all be unlocked.
*/
AAFWeapons = [
	"arifle_TRG21_F",
	"arifle_TRG21_GL_F",
    "LMG_Mk200_F",
	"srifle_GM6_F",
	"srifle_DMR_06_olive_F",
	"srifle_EBR_F"
];

private _getWeaponMags = {
    params ["_weapon"];
    private _index = AS_allWeapons find _weapon;
    if (_index == -1) exitWith {[]};

    // all magazines of this weapon.
    (AS_allWeaponsAttrs select _index) select 2
};

AAFMagazines = [];
{
    AAFMagazines append ([_x] call _getWeaponMags);
} forEach AAFWeapons;

AAFGrenades = [
	"HandGrenade",
    "MiniGrenade",
	"SmokeShell",
    "SmokeShellGreen"
];

AAFLaunchers = [
	"launch_I_Titan_F",
	"launch_I_Titan_short_F",
    "launch_NLAW_F"
];

// Default launchers
genAALaunchers = ["launch_I_Titan_F"];
genATLaunchers = ["launch_I_Titan_short_F","launch_NLAW_F"];

AAFMines = [
	"SLAMDirectionalMine_Wire_Mag",
	"SatchelCharge_Remote_Mag",
	"ClaymoreDirectionalMine_Remote_Mag",
	"ATMine_Range_Mag",
	"APERSTripMine_Wire_Mag",
	"APERSMine_Range_Mag",
	"APERSBoundingMine_Range_Mag"
];

AAFItems = [
	"Binocular",
	"MineDetector",
	"NVGoggles",
	"ToolKit",
	"muzzle_snds_H",
	"muzzle_snds_L",
	"muzzle_snds_M",
	"muzzle_snds_B",
	"muzzle_snds_H_MG",
	"muzzle_snds_acp",
	"bipod_03_F_oli",
	"muzzle_snds_338_green",
	"muzzle_snds_93mmg_tan",
	"acc_flashlight",
	"Rangefinder",
	"Laserdesignator",
	"ItemGPS",
	"ItemRadio",
	"acc_pointer_IR"
];

AAFOptics = AS_allOptics;

genBackpacks = [
	"B_AssaultPack_khk",
	"B_AssaultPack_dgtl",
	"B_AssaultPack_rgr",
	"B_AssaultPack_sgg",
	"B_AssaultPack_blk",
	"B_AssaultPack_cbr",
	"B_AssaultPack_mcamo",
	"B_Kitbag_mcamo",
	"B_Kitbag_sgg",
	"B_Kitbag_cbr",
	"B_Bergen_sgg",
	"B_Bergen_mcamo",
	"B_Bergen_rgr",
	"B_Bergen_blk",
	"B_FieldPack_oli",
	"B_FieldPack_blk",
	"B_FieldPack_ocamo",
	"B_FieldPack_oucamo",
	"B_FieldPack_cbr",
	"B_Carryall_ocamo",
	"B_Carryall_mcamo",
	"B_Carryall_oli",
	"B_Carryall_khk",
	"B_Carryall_cbr",
	"B_OutdoorPack_blk",
	"B_OutdoorPack_tan",
	"B_OutdoorPack_blu",
	"B_HuntingBackpack",
	"B_Static_Designator_01_weapon_F",
	"B_UAV_01_backpack_F",
	"I_AA_01_weapon_F",
	"B_AA_01_weapon_F",
	"B_AT_01_weapon_F",
	"I_HMG_01_high_weapon_F",
	"I_Mortar_01_support_F",
	"B_Mortar_01_support_F",
	"I_HMG_01_support_high_F",
	"B_HMG_01_support_high_F",
	"I_Mortar_01_weapon_F",
	"B_Mortar_01_weapon_F",
	"B_HMG_01_support_F",
	"I_HMG_01_support_F",
	"tf_rt1523g_green"
];

genVests = [
	"V_HarnessO_brn",
	"V_HarnessO_gry",
	"V_HarnessOGL_brn",
	"V_HarnessOGL_gry",
	"V_HarnessOSpec_brn",
	"V_HarnessOSpec_gry",
	"V_PlateCarrier1_blk",
	"V_PlateCarrier1_rgr",
	"V_PlateCarrier2_rgr",
	"V_PlateCarrier3_rgr",
	"V_PlateCarrier3_rgr",
	"V_PlateCarrierIA1_dgtl",
	"V_TacVest_brn",
	"V_PlateCarrierIA2_dgtl",
	"V_PlateCarrierIAGL_dgtl",
	"V_PlateCarrierSpec_rgr",
	"V_TacVest_blk",
	"V_TacVest_camo",
	"V_TacVest_khk",
	"V_TacVest_oli",
	"V_TacVestCamo_khk",
	"V_TacVestIR_blk",
	"V_RebreatherIA",
	"G_I_Diving",
	"V_PlateCarrierIAGL_oli",
	"V_Chestrig_oli"
];

genHelmets = [
	"H_HelmetB",
	"H_HelmetB_camo",
	"H_HelmetB_paint",
	"H_HelmetB_light",
	"H_HelmetB_plain_mcamo",
	"H_HelmetB_plain_blk",
	"H_HelmetSpecB",
	"H_HelmetSpecB_paint1",
	"H_HelmetSpecB_paint2",
	"H_HelmetSpecB_blk",
	"H_HelmetIA",
	"H_HelmetIA_net",
	"H_HelmetIA_camo",
	"H_HelmetB_grass",
	"H_HelmetB_snakeskin",
	"H_HelmetB_desert",
	"H_HelmetB_black",
	"H_HelmetB_sand",
	"H_HelmetB_sand",
	"H_HelmetCrew_O",
	"H_HelmetCrew_I",
	"H_PilotHelmetFighter_B",
	"H_PilotHelmetFighter_O",
	"H_PilotHelmetFighter_I",
	"H_PilotHelmetHeli_B",
	"H_PilotHelmetHeli_O",
	"H_PilotHelmetHeli_I",
	"H_CrewHelmetHeli_B",
	"H_CrewHelmetHeli_O",
	"H_CrewHelmetHeli_I",
	"H_HelmetO_ocamo",
	"H_HelmetLeaderO_ocamo",
	"H_HelmetB_light_grass",
	"H_HelmetB_light_snakeskin",
	"H_HelmetB_light_desert",
	"H_HelmetB_light_black",
	"H_HelmetB_light_sand",
	"H_HelmetO_oucamo",
	"H_HelmetLeaderO_oucamo",
	"H_HelmetSpecO_ocamo",
	"H_HelmetSpecO_blk",
	"H_HelmetSpecO_blk"
];

// Equipment unlocked by default
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

// Default rifle types, required to unlock specific unit types. Unfortunatly, not all mods classify their weapons the same way, so automatic detection doesn't work reliably enough.
genGL = ["arifle_Katiba_GL_F","arifle_MX_GL_F","arifle_Mk20_GL_F","arifle_TRG21_GL_F"];

// NVG, flashlight, laser, mine types
indNVG = 		"NVGoggles_INDEP";
indRF = 		"Rangefinder";
indFL = 		"acc_flashlight";
indLaser = 		"acc_pointer_IR";
atMine = 		"ATMine_Range_Mag";
apMine = 		"APERSMine_Range_Mag";

// The flag
cFlag = "Flag_AAF_F";

// Affiliation
side_green = independent;

// Long range radio
lrRadio = "tf_rt1523g_green";

/*
These are the vehicles and statics that you can buy at HQ. Currently, the array requires a strict(!) order.
0-2: civilian vehicles
3-10: military vehicles and statics
*/
vehFIA = [
	"C_Offroad_01_F",
	"C_Van_01_transport_F",
	"C_Heli_Light_01_civil_F",
	"B_G_Quadbike_01_F",
	"B_G_Offroad_01_F",
	"B_G_Van_01_transport_F",
	"B_G_Offroad_01_armed_F",
	"B_HMG_01_high_F",
	"B_G_Mortar_01_F",
	"B_static_AT_F",
	"B_static_AA_F"
];

// Define the civilian helicopter that allows you to go undercover
civHeli = "C_Heli_Light_01_civil_F";

// Define the ammo crate to be spawned at camps
campCrate = 		"Box_NATO_Equip_F";

A3_STR_INDEP = localize "STR_genIdent_AFRF";
