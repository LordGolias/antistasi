/*
List of infantry classes. These will have individual equipment mapped to them.

Note: all classes marked as "extra" do not have a unique class in this template. They are, however, part of other templates and are therfore included in all templates.
*/
sol_A_AA = 	"rhs_vdv_rifleman"; // Assistant AA (extra)
sol_A_AR = 	"rhs_vdv_machinegunner_assistant"; // Assistant autorifle
sol_A_AT = 	"rhs_vdv_strelok_rpg_assist"; // Assistant AT
sol_AA = 	"rhs_vdv_aa"; // AA
sol_AR = 	"rhs_vdv_machinegunner"; // Autorifle
sol_AT = 	"rhs_vdv_at"; // AT
sol_AMMO = 	"rhs_vdv_rifleman"; // Ammo bearer (extra)
sol_GL = 	"rhs_vdv_grenadier"; // Grenade launcher
sol_GL2 = 	"rhs_vdv_grenadier_rpg"; // Grenade launcher
sol_LAT = 	"rhs_vdv_LAT"; // Light AT
sol_LAT2 = 	"rhs_vdv_RShG2"; // Light AT
sol_MG = 	"rhs_vdv_arifleman"; // Machinegunner
sol_MK = 	"rhs_vdv_marksman"; // Marksman
sol_SL = 	"rhs_vdv_sergeant"; // Squad leader
sol_TL = 	"rhs_vdv_junior_sergeant"; // Team leader
sol_TL2 = 	"rhs_vdv_efreitor"; // Team leader
sol_EXP = 	"rhs_vdv_engineer"; // Explosives (extra)
sol_R_L = 	"rhs_vdv_rifleman_lite"; // Rifleman, light
sol_REP = 	"rhs_vdv_engineer"; // Repair (extra)
sol_UN = 	"rhs_vdv_crew"; // Unarmed (extra)
sol_RFL = 	"rhs_vdv_rifleman"; // Rifleman
sol_SN = 	"rhs_vdv_marksman_asval"; // Sniper
sol_SP = 	"rhs_vdv_rifleman_asval"; // Spotter
sol_MED = 	"rhs_vdv_medic"; // Medic
sol_ENG = 	"rhs_vdv_engineer"; // Engineer
sol_OFF = 	"rhs_vdv_officer"; // Officer
sol_OFF2 = 	"rhs_vdv_officer_armored"; // Officer

sol_CREW = 	"rhs_vdv_crew"; // Crew
sol_CREW2 = "rhs_vdv_armoredcrew"; // Crew
sol_CREW3 = "rhs_vdv_combatcrew"; // Crew
sol_CREW4 = "rhs_vdv_crew_commander"; // Crew
sol_DRV = 	"rhs_vdv_driver"; // Driver
sol_DRV2 = 	"rhs_vdv_driver_armored"; // Driver
sol_HCREW = "rhs_vdv_crew"; // Helicopter crew (extra)
sol_HPIL = 	"rhs_pilot_transport_heli"; // helicopter pilot
sol_HPIL2 = "rhs_pilot_combat_heli"; // helicopter pilot
sol_PIL = 	"rhs_pilot"; // Pilot
sol_UAV = 	"rhs_vdv_crew"; // UAV controller (extra)

sol_SUP_AMG = 	"rhs_vdv_rifleman"; // Assistant HMG gunner (extra)
sol_SUP_AMTR = 	"rhs_vdv_rifleman"; // Assistant mortar gunner (extra)
sol_SUP_GMG = 	"rhs_vdv_rifleman"; // GMG gunner (extra)
sol_SUP_MG = 	"rhs_vdv_rifleman"; // HMG gunner (extra)
sol_SUP_MTR = 	"rhs_vdv_rifleman"; // mortar gunner (extra)

// Standard roles
infGunner = sol_CREW;
infCrew = sol_CREW;
infPilot = sol_HPIL;
infMedic = sol_MED;
infDriver = sol_DRV;

// All classes sorted by role, used for pricing, etc
infList_officers = 	[sol_OFF, sol_OFF2];
infList_sniper = 	[sol_MK, sol_SN, sol_SP];
infList_NCO = 		[sol_SL, sol_TL, sol_TL2];
infList_special = 	[sol_A_AA, sol_A_AT, sol_AA, sol_AT, sol_EXP, sol_REP, sol_ENG, sol_MED];
infList_auto = 		[sol_A_AR, sol_MG];
infList_regular = 	[sol_AMMO, sol_GL, sol_GL2, sol_LAT, sol_LAT2, sol_R_L, sol_RFL];
infList_crew = 		[sol_UN, sol_CREW, sol_CREW2, sol_CREW3, sol_CREW4, sol_DRV, sol_DRV2, sol_HCREW, sol_UAV, sol_SUP_AMG, sol_SUP_AMTR, sol_SUP_GMG, sol_SUP_MG, sol_SUP_MTR];
infList_pilots = 	[sol_HPIL, sol_HPIL2, sol_PIL];

// AAF Vehicles
if (isServer) then {
	["planes", "valid", ["rhs_Su25SM_vvsc"]] call AS_AAFarsenal_fnc_set;
	["armedHelis", "valid", ["rhs_Mi24V_FAB_vdv","rhs_Mi24V_UPK23_vdv"]] call AS_AAFarsenal_fnc_set;
	["transportHelis", "valid", ["rhs_Mi8mt_Cargo_vvsc","rhs_Mi8MTV3_FAB_vvsc","rhs_Mi8AMTSh_FAB_vvsc","rhs_ka60_c"]] call AS_AAFarsenal_fnc_set;
	["tanks", "valid", ["rhs_t72bb_tv","rhs_t72bd_tv","rhs_t90a_tv"]] call AS_AAFarsenal_fnc_set;
	["boats", "valid", ["I_Boat_Armed_01_minigun_F"]] call AS_AAFarsenal_fnc_set;
	["apcs", "valid", ["rhs_btr80_vdv", "rhs_bmp2d_vdv","rhs_bmp1p_vdv","rhs_bmd2m","rhs_bmd2k"]] call AS_AAFarsenal_fnc_set;
	["trucks", "valid", ["rhs_kamaz5350_open_vdv","rhs_kamaz5350_vdv","rhs_Ural_Open_VDV_01","rhs_Ural_VDV_01"]] call AS_AAFarsenal_fnc_set;
	["supplies", "valid", ["rhs_gaz66_ammo_vdv","rhs_Ural_Fuel_VDV_01","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv"]] call AS_AAFarsenal_fnc_set;
};

AS_AAFarsenal_uav = "";

vehPatrol = ["rhs_tigr_m_vdv","RHS_Mi8mt_vvsc"];
vehAmmo = "rhsgref_ins_gaz66_ammo";
vehLead = ["rhs_tigr_sts_3camo_vdv"];
vehTruckBox = ["rhs_gaz66_repair_vdv"];
vehBoat = "I_Boat_Armed_01_minigun_F";

// FIA Vehicles
vehTruckAA = "rhsgref_cdf_b_gaz66_zu23";


// Standard group arrays, used for spawning groups -- can use full config paths, config group names, arrays of individual soldiers
AAFConfigGroupInf = (configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry");
infPatrol = 		["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER"]; // 2-3 guys, incl sniper teams
infGarrisonSmall = 	["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER","rhs_group_rus_vdv_infantry_MANEUVER"]; // 2-3 guys, to guard towns
infTeamATAA =		["rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AA"]; // missile teams, 4+ guys, for roadblocks and watchposts
infTeam = 			["rhs_group_rus_vdv_infantry_section_mg","rhs_group_rus_vdv_infantry_section_marksman","rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AA",
					 "rhs_group_rus_vdv_infantry_section_mg","rhs_group_rus_vdv_infantry_section_marksman"]; // teams, 4+ guys
infSquad = 			["rhs_group_rus_vdv_infantry_squad","rhs_group_rus_vdv_infantry_squad_2mg","rhs_group_rus_vdv_infantry_squad_sniper","rhs_group_rus_vdv_infantry_squad_mg_sniper"]; // squads, 8+ guys, for outposts, etc
infAA =				["rhs_group_rus_vdv_infantry_section_AA"];
infAT =				["rhs_group_rus_vdv_infantry_section_AT"];

// Statics to be used
statMG = 			"rhsgref_cdf_b_DSHKM";
statAT = 			"rhsgref_ins_g_SPG9M"; // alternatives: rhs_Kornet_9M133_2_vdv, rhs_SPG9M_VDV, rhs_Metis_9k115_2_vdv
statAA = 			"rhsgref_cdf_b_ZU23"; // alternatively: "rhs_Igla_AA_pod_vdv"
statAA2 = 			"rhs_Igla_AA_pod_vdv";
statMortar = 		"rhsgref_cdf_b_reg_M252";

statMGlow = 		"rhsgref_cdf_b_DSHKM_Mini_TriPod";
statMGtower = 		"rhsgref_cdf_b_DSHKM";

// Lists of statics to determine the defensive capabilities at locations
allStatMGs = 		allStatMGs + [statMG];
allStatATs = 		allStatATs + [statAT];
allStatAAs = 		allStatAAs + [statAA];
allStatMortars = 	allStatMortars + [statMortar];

// Backpacks of dismantled statics -- 0: weapon, 1: tripod/support
statMGBackpacks = 		["RHS_DShkM_Gun_Bag","RHS_DShkM_TripodHigh_Bag"];
statATBackpacks = 		["RHS_Kornet_Gun_Bag","RHS_Kornet_Tripod_Bag"]; // alt: ["RHS_Kornet_Gun_Bag","RHS_Kornet_Tripod_Bag"], ["RHS_Metis_Gun_Bag","RHS_Metis_Tripod_Bag"], ["RHS_SPG9_Gun_Bag","RHS_SPG9_Tripod_Bag"]
statAABackpacks = 		[]; // Neither Igla nor ZSU can be dismantled. Any alternatives?
statMortarBackpacks = 	["RHS_Podnos_Gun_Bag","RHS_Podnos_Bipod_Bag"];
statMGlowBackpacks = 	["RHS_NSV_Gun_Bag","RHS_NSV_Tripod_Bag"];
statMGtowerBackpacks = 	["RHS_Kord_Gun_Bag","RHS_Kord_Tripod_Bag"];

/*
================ Gear ================
Weapons, ammo, launchers, missiles, mines, items and optics will spawn in ammo crates, the rest will not. These lists, together with the corresponding lists in the NATO/USAF template, determine what can be unlocked. Weapons of all kinds and ammo are the exception: they can all be unlocked.
*/

AAFExponsives = [
	"SatchelCharge_F",
	"DemoCharge_F",
	"ClaymoreDirectional_F"
];

AAFMines = [
	"rhs_mine_tm62m",
	"rhs_mine_pmn2"
];

atMine = "rhs_mine_tm62m";
apMine = "rhs_mine_pmn2";

// Default launchers
genAALaunchers = ["rhs_weap_igla"];
genATLaunchers = ["rhs_weap_rpg26","rhs_weap_rpg7"];

// NVG, flashlight, laser, mine types
indNVG = 		"rhs_1PN138";
indRF = 		"rhs_pdu4";
indFL = 		"rhs_acc_2dpZenit";
indLaser = 		"rhs_acc_perst1ik";

// The flag
cFlag = "rhs_Flag_vdv_F";
AS_AAFname = "VV";

// Long-range radio
lrRadio = "tf_mr3000_rhs";

// Define the ammo crate to be spawned at camps
campCrate = "Box_NATO_Equip_F";
