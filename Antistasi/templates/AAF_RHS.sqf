/*
List of infantry classes. These will have individual equipment mapped to them.

Note: all classes marked as "extra" do not have a unique class in this template. They are, however, part of other templates and are therfore included in all templates.
*/
sol_A_AA = 	"rhsgref_cdf_reg_specialist_aa"; // Assistant AA (extra)
sol_A_AR = 	"rhsgref_cdf_reg_machinegunner"; // Assistant autorifle
sol_A_AT = 	"rhsgref_cdf_reg_grenadier_rpg"; // Assistant AT
sol_AA = 	"rhsgref_cdf_reg_specialist_aa"; // AA
sol_AR = 	"rhsgref_cdf_reg_machinegunner"; // Autorifle
sol_AT = 	"rhsgref_cdf_reg_grenadier_rpg"; // AT
sol_AMMO = 	"rhsgref_cdf_reg_rifleman_m70"; // Ammo bearer (extra)
sol_GL = 	"rhsgref_cdf_reg_grenadier"; // Grenade launcher
sol_GL2 = 	"rhsgref_cdf_reg_grenadier"; // Grenade launcher
sol_LAT = 	"rhsgref_cdf_reg_grenadier_rpg"; // Light AT
sol_LAT2 = 	"rhsgref_cdf_reg_grenadier_rpg"; // Light AT
sol_MG = 	"rhsgref_cdf_reg_machinegunner"; // Machinegunner
sol_MK = 	"rhsgref_cdf_reg_marksman"; // Marksman
sol_SL = 	"rhsgref_cdf_reg_squadleader"; // Squad leader
sol_TL = 	"rhsgref_cdf_reg_squadleader"; // Team leader
sol_TL2 = 	"rhsgref_cdf_reg_squadleader"; // Team leader
sol_EXP = 	"rhsgref_cdf_reg_grenadier"; // Explosives (extra)
sol_R_L = 	"rhsgref_cdf_reg_rifleman_lite"; // Rifleman, light
sol_REP = 	"rhsgref_cdf_reg_engineer"; // Repair (extra)
sol_UN = 	"rhsgref_cdf_reg_general"; // Unarmed (extra)
sol_RFL = 	"rhsgref_cdf_reg_rifleman"; // Rifleman
sol_SN = 	"rhsgref_cdf_reg_marksman"; // Sniper
sol_SP = 	"rhsgref_cdf_reg_marksman"; // Spotter
sol_MED = 	"rhsgref_cdf_reg_medic"; // Medic
sol_ENG = 	"rhsgref_cdf_reg_engineer"; // Engineer
sol_OFF = 	"rhsgref_cdf_reg_officer"; // Officer
sol_OFF2 = 	"rhsgref_cdf_reg_officer"; // Officer

sol_CREW = 	"rhsgref_cdf_reg_crew"; // Crew
sol_CREW2 = "rhsgref_cdf_reg_crew"; // Crew
sol_CREW3 = "rhsgref_cdf_reg_crew"; // Crew
sol_CREW4 = "rhsgref_cdf_reg_crew_commander"; // Crew
sol_DRV = 	"rhsgref_cdf_reg_rifleman"; // Driver
sol_DRV2 = 	"rhsgref_cdf_reg_rifleman"; // Driver
sol_HCREW = "rhsgref_cdf_air_pilot"; // Helicopter crew (extra)
sol_HPIL = 	"rhsgref_cdf_air_pilot"; // helicopter pilot
sol_HPIL2 = "rhsgref_cdf_air_pilot"; // helicopter pilot
sol_PIL = 	"rhsgref_cdf_air_pilot"; // Pilot
sol_UAV = 	"rhsgref_cdf_reg_rifleman_m70"; // UAV controller (extra)

sol_SUP_AMG = 	"rhsgref_cdf_reg_rifleman_m70"; // Assistant HMG gunner (extra)
sol_SUP_AMTR = 	"rhsgref_cdf_reg_rifleman_m70"; // Assistant mortar gunner (extra)
sol_SUP_GMG = 	"rhsgref_cdf_reg_rifleman_m70"; // GMG gunner (extra)
sol_SUP_MG = 	"rhsgref_cdf_reg_rifleman_m70"; // HMG gunner (extra)
sol_SUP_MTR = 	"rhsgref_cdf_reg_rifleman_m70"; // mortar gunner (extra)

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

// AAF Vehicles
if (isServer) then {
	["planes", "valid", ["rhs_l159_CDF_CAS","rhsgref_cdf_su25"]] call AS_AAFarsenal_fnc_set;
	["armedHelis", "valid", ["rhsgref_cdf_Mi24D","rhsgref_cdf_reg_Mi17Sh_UPK"]] call AS_AAFarsenal_fnc_set;
	["transportHelis", "valid", ["rhsgref_cdf_reg_Mi8amt"]] call AS_AAFarsenal_fnc_set;
	["tanks", "valid", ["rhsgref_cdf_t72ba_tv","rhsgref_cdf_t80b_tv","rhsgref_cdf_t80bv_tv"]] call AS_AAFarsenal_fnc_set;
	["boats", "valid", ["rhsusf_mkvsoc"]] call AS_AAFarsenal_fnc_set;
	["apcs", "valid", ["rhsgref_cdf_btr60","rhsgref_cdf_bmp1","rhsgref_cdf_bmp2k","rhsusf_m113_usarmy_m240","rhsusf_m1117_w"]] call AS_AAFarsenal_fnc_set;
	["trucks", "valid", ["rhsgref_cdf_ural","rhsgref_cdf_ural_open","rhsgref_cdf_gaz66","rhsgref_cdf_gaz66o"]] call AS_AAFarsenal_fnc_set;
	["supplies", "valid", ["rhsgref_cdf_gaz66_ammo","rhsgref_cdf_Ural_Fuel","rhsgref_cdf_gaz66_repair","rhsgref_cdf_gaz66_ap2"]] call AS_AAFarsenal_fnc_set;
};

AS_AAFarsenal_uav = "";

vehPatrol = ["rhsgref_cdf_reg_uaz_dshkm","rhsgref_cdf_reg_Mi17Sh_UPK","rhsgref_BRDM2","rhsusf_m1025_w_m2"];
vehAmmo = "rhsgref_cdf_gaz66_ammo";
vehLead = ["rhsusf_m1025_w_m2"];
vehTruckBox = ["rhsgref_cdf_gaz66_repair"];
vehBoat = "rhsusf_mkvsoc";

// FIA Vehicles
vehTruckAA = "rhsgref_cdf_b_gaz66_zu23";




// Standard group arrays, used for spawning groups -- can use full config paths, config group names, arrays of individual soldiers
AAFConfigGroupInf = (missionConfigFile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_cdf_ground" >> "rhsgref_group_cdf_reg_infantry");
infPatrol = 		["Fake_AAF_Patrol", "Fake_AAF_Sniper_Patrol"]; // 2-3 guys, incl sniper teams
infGarrisonSmall = 	["Fake_AAF_Town_Patrol"]; // 2-3 guys, to guard towns
infTeamATAA =		["Fake_AAF_AT_team","Fake_AAF_AA_team"]; // missile teams, 4+ guys, for roadblocks and watchposts
infTeam = 		["Fake_AAF_MG_team","Fake_AAF_Marksman_team","Fake_AAF_AT_team","Fake_AAF_AA_team","Fake_AAF_MG_team","Fake_AAF_Marksman_team"]; // teams, 4+ guys
infSquad = 			["rhsgref_group_cdf_reg_infantry_squad","rhsgref_group_cdf_reg_infantry_squad_weap"]; // squads, 8+ guys, for outposts, etc
infAA =				["Fake_AAF_AA_section"];
infAT =				["Fake_AAF_AT_section"];

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

// Unlocked equipment can only be set in the server or the clients will not be
// synced with the server.
if (isServer) then {
	// Equipment unlocked by default
	unlockedWeapons = [
		"rhs_weap_makarov_pm",
		"rhs_weap_aks74u",
		"rhs_weap_m38_rail",
		"rhs_weap_m38"
	];

	unlockedMagazines = [
		"rhs_mag_9x18_8_57N181S",
		"rhs_30Rnd_545x39_AK",
		"rhs_mag_rdg2_white",
		"rhsgref_5Rnd_762x54_m38"
	];

	unlockedItems = unlockedItems + [
		"rhs_vest_pistol_holster",
		"rhs_scarf"
	];

	unlockedBackpacks = [
		"rhs_assault_umbts",
		"rhs_sidor",
		"rgs_rpg_empty"
	];
};

// Default launchers
genAALaunchers = ["rhs_weap_igla"];
genATLaunchers = ["rhs_weap_rpg26","rhs_weap_rpg7"];

// NVG, flashlight, laser, mine types
indNVG = 		"rhs_1PN138";
indRF = 		"rhs_pdu4";
indFL = 		"rhs_acc_2dpZenit";
indLaser = 		"rhs_acc_perst1ik";

// The flag
cFlag = "flag_AltisColonial_F";

// Long-range radio
lrRadio = "tf_mr3000_rhs";

// Define the ammo crate to be spawned at camps
campCrate = "Box_NATO_Equip_F";

// A3_STR_INDEP = localize "STR_genIdent_AFRF";

A3_STR_INDEP = "AAF";
