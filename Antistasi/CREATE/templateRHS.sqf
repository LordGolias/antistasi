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

// Vehicles
vehTrucks = 		["rhs_kamaz5350_open_vdv","rhs_kamaz5350_vdv","RHS_Ural_Open_VDV_01","RHS_Ural_VDV_01"]; // trucks that spawn at outposts, etc
vehPatrol =			["rhs_tigr_m_vdv","RHS_Mi8mt_vvsc"]; // vehicles used for road patrols;
vehAPC = 			["rhs_btr80_vdv"]; // APCs
vehIFV = 			["rhs_bmp2d_vdv","rhs_bmp1p_vdv","rhs_bmd2m","rhs_bmd2k"]; // IFVs
vehTank = 			["rhs_t72bb_tv","rhs_t72bd_tv","rhs_t90a_tv"]; // MBTs
vehSupply = 		["rhs_gaz66_ammo_vdv","RHS_Ural_Fuel_VDV_01","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv"]; // supply vehicles (ammo, fuel, med)
vehAmmo = 			"rhs_gaz66_ammo_vdv"; // ammo truck, for special missions
vehLead = 			["rhs_tigr_sts_3camo_vdv"]; // lead vehicle for convoys, preferably armed MRAP/car
standardMRAP = 		["rhs_tigr_vdv","rhs_uaz_vdv"]; // default transport MRAP/car
vehTruckBox = 		["rhs_gaz66_repair_vdv"]; // repair truck or at least a prop

vehTruckAA = 		"rhs_gaz66_zu23_msv";
vehFIA pushBackUnique vehTruckAA;

var_AAF_groundForces = vehTrucks + vehPatrol + vehAPC + vehIFV + vehTank + vehLead + standardMRAP;
var_AAF_groundForces = var_AAF_groundForces arrayIntersect var_AAF_groundForces;

// Airforce
heli_unarmed = 		["RHS_Mi8mt_Cargo_vvsc","RHS_Mi8MTV3_FAB_vvsc","RHS_Mi8AMTSh_FAB_vvsc","rhs_ka60_c"]; // (un-)armed transport helicopters
heli_armed = 		["RHS_Mi24V_FAB_vdv","RHS_Mi24V_UPK23_vdv"]; // // armed helicopters
heli_escort = 		"RHS_Mi8AMTSh_vvsc";
planes = 			["RHS_Su25SM_vvsc"]; // attack planes
heli_default = 		"RHS_Mi8mt_vvsc";
heli_transport = 	"RHS_Mi8mt_vvsc";
indUAV_large = 		"I_UAV_02_F"; // large UAV, unarmed

// Initial motorpool/airforce
enemyMotorpoolDef = "RHS_Ural_VDV_01"; // fallback vehicle in case of an empty motorpool -- NOT AN ARRAY!
enemyMotorpool = 	["RHS_Ural_VDV_01"]; // starting/current motorpool
indAirForce = 		["RHS_Mi8mt_vvsc"]; // starting/current airforce

// Config paths for pre-defined groups -- required if group names are used
cfgInf = (configfile >> "CfgGroups" >> "east" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry");

// Standard group arrays, used for spawning groups -- can use full config paths, config group names, arrays of individual soldiers
infPatrol = 		["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER"]; // 2-3 guys, incl sniper teams
infGarrisonSmall = 	["rhs_group_rus_vdv_infantry_fireteam","rhs_group_rus_vdv_infantry_MANEUVER","rhs_group_rus_vdv_infantry_MANEUVER"]; // 2-3 guys, to guard towns
infTeamATAA =		["rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AA"]; // missile teams, 4+ guys, for roadblocks and watchposts
infTeam = 			["rhs_group_rus_vdv_infantry_section_mg","rhs_group_rus_vdv_infantry_section_marksman","rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AA",
					"rhs_group_rus_vdv_infantry_section_mg","rhs_group_rus_vdv_infantry_section_marksman"]; // teams, 4+ guys
infSquad = 			["rhs_group_rus_vdv_infantry_squad","rhs_group_rus_vdv_infantry_squad_2mg","rhs_group_rus_vdv_infantry_squad_sniper","rhs_group_rus_vdv_infantry_squad_mg_sniper"]; // squads, 8+ guys, for outposts, etc
infAA =				["rhs_group_rus_vdv_infantry_section_AA"];
infAT =				["rhs_group_rus_vdv_infantry_section_AT"];

// Statics to be used
statMG = 			"rhs_DSHKM_ins";
statAT = 			"rhs_Kornet_9M133_2_vdv"; // alternatives: rhs_Kornet_9M133_2_vdv, rhs_SPG9M_VDV, rhs_Metis_9k115_2_vdv
statAA = 			"RHS_ZU23_VDV"; // alternatively: "rhs_Igla_AA_pod_vdv"
statAA2 = 			"rhs_Igla_AA_pod_vdv";
statMortar = 		"rhs_2b14_82mm_vdv";

statMGlow = 		"RHS_NSV_TriPod_VDV";
statMGtower = 		"rhs_KORD_high_VDV";

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
genWeapons = [
	"rhs_weap_ak74m",
	"rhs_weap_ak74m_gp25",
	"rhs_weap_asval_grip",
	"rhs_weap_vss",
	"rhs_weap_svds",
	"rhs_weap_svdp_wd",
	"rhs_weap_akm",
	"rhs_weap_pkm",
	"rhs_weap_pkp",
	"rhs_weap_ak74mr"
];

genAmmo = [
	"rhs_30Rnd_545x39_AK",
	"rhs_45Rnd_545x39_AK",
	"rhs_VOG25",
	"rhs_30Rnd_762x39mm",
	"rhs_10Rnd_762x54mmR_7N1",
	"rhs_100Rnd_762x54mmR_green",
	"rhs_20rnd_9x39mm_SP5",
	"rhs_mag_rdg2_white",
	"rhs_mag_fakels",
	"rhs_GDM40",
	"rhs_10rnd_9x39mm_SP5",
	"rhs_20rnd_9x39mm_SP5",
	"rhs_20rnd_9x39mm_SP6"
];

genLaunchers = [
	"rhs_weap_rpg26",
	"rhs_weap_rshg2",
	"rhs_weap_rpg7",
	"rhs_weap_igla"
];

genMissiles = [
	"rhs_rpg7_PG7VL_mag",
	"rhs_rpg7_OG7V_mag",
	"rhs_rpg7_TBG7V_mag",
	"rhs_rpg7_PG7V_mag",
	"rhs_rpg26_mag",
	"rhs_rshg2_mag",
	"rhs_mag_9k38_rocket"
];

genMines = [
	"rhs_mine_tm62m_mag",
	"rhs_mine_pmn2_mag"
];

genItems = [
	"FirstAidKit",
	"MineDetector",
	"rhs_acc_pgs64",
	"rhs_acc_dtk",
	"rhs_acc_dtk4short",
	"rhs_acc_2dpZenit",
	"rhs_acc_perst1ik",
	"rhs_acc_pbs1",
	"rhs_acc_pbs4",
	"rhs_acc_tgpa",
	"rhs_1PN138",
	"ItemGPS",
	"rhs_scarf",
	"rhs_pdu4"
];

genOptics = [
	"rhs_acc_ekp1",
	"rhs_acc_pso1m2",
	"rhs_acc_1p29",
	"rhs_acc_pkas",
	"rhs_acc_npz",
	"rhs_acc_pgo7v"
];

genBackpacks = [
	"rhs_assault_umbts",
	"rhs_assault_umbts_engineer",
	"rhs_assault_umbts_engineer_empty",
	"rhs_assault_umbts_medic",
	"rhs_rpg",
	"rhs_rpg_empty",
	"rhs_sidor",
	"rhs_sidorMG",
	"RHS_NSV_Gun_Bag",
	"RHS_NSV_Tripod_Bag",
	"RHS_DShkM_Gun_Bag",
	"RHS_DShkM_TripodHigh_Bag",
	"RHS_DShkM_TripodLow_Bag",
	"RHS_Kord_Gun_Bag",
	"RHS_Kord_Tripod_Bag",
	"RHS_Metis_Gun_Bag",
	"RHS_Metis_Tripod_Bag",
	"RHS_Kornet_Gun_Bag",
	"RHS_Kornet_Tripod_Bag",
	"RHS_AGS30_Gun_Bag",
	"RHS_AGS30_Tripod_Bag",
	"RHS_SPG9_Gun_Bag",
	"RHS_SPG9_Tripod_Bag",
	"RHS_Podnos_Gun_Bag",
	"RHS_Podnos_Bipod_Bag",
	"tf_mr3000_rhs",
	"B_Carryall_oli"
];

genVests = [
	"rhs_6b13",
	"rhs_6b13_flora",
	"rhs_6b13_emr",
	"rhs_6b13_6sh92",

	"rhs_6b23",
	"rhs_6b23_crew",
	"rhs_6b23_crewofficer",
	"rhs_vest_commander",
	"rhs_6b23_engineer",
	"rhs_6b23_medic",
	"rhs_6b23_rifleman",
	"rhs_6b23_sniper",
	"rhs_6b23_6sh92",
	"rhs_6b23_6sh92_vog",
	"rhs_6b23_6sh92_vog_headset",
	"rhs_6b23_6sh92_headset",
	"rhs_6b23_6sh92_headset_mapcase",
	"rhs_6b23_6sh92_radio",

	"rhs_6b23_digi",
	"rhs_6b23_digi_crew",
	"rhs_6b23_digi_crewofficer",
	"rhs_6b23_digi_engineer",
	"rhs_6b23_digi_medic",
	"rhs_6b23_digi_rifleman",
	"rhs_6b23_digi_sniper",
	"rhs_6b23_digi_6sh92",
	"rhs_6b23_digi_6sh92_vog",
	"rhs_6b23_digi_6sh92_vog_headset",
	"rhs_6b23_digi_6sh92_headset",
	"rhs_6b23_digi_6sh92_headset_mapcase",
	"rhs_6b23_digi_6sh92_radio",

	"rhs_6b23_ML",
	"rhs_6b23_ML_crew",
	"rhs_6b23_ML_crewofficer",
	"rhs_6b23_ML_engineer",
	"rhs_6b23_ML_medic",
	"rhs_6b23_ML_rifleman",
	"rhs_6b23_ML_sniper",
	"rhs_6b23_ML_6sh92",
	"rhs_6b23_ML_6sh92_vog",
	"rhs_6b23_ML_6sh92_vog_headset",
	"rhs_6b23_ML_6sh92_headset",
	"rhs_6b23_ML_6sh92_headset_mapcase",
	"rhs_6b23_ML_6sh92_radio",

	"rhs_6sh92",
	"rhs_6sh92_vog",
	"rhs_6sh92_vog_headset",
	"rhs_6sh92_headset",
	"rhs_6sh92_radio",
	"rhs_6sh92_digi",
	"rhs_6sh92_digi_vog",
	"rhs_6sh92_digi_vog_headset",
	"rhs_6sh92_digi_headset",
	"rhs_6sh92_digi_radio"
];

genHelmets = [
	"rhs_6b26",
	"rhs_6b26_ess",
	"rhs_6b26_bala",
	"rhs_6b26_ess_bala",
	"rhs_6b26_green",
	"rhs_6b26_ess_green",
	"rhs_6b26_bala_green",
	"rhs_6b26_ess_bala_green",
	"rhs_6b27m",
	"rhs_6b27m_ess",
	"rhs_6b27m_bala",
	"rhs_6b27m_ess_bala",
	"rhs_6b27m_digi",
	"rhs_6b27m_digi_ess",
	"rhs_6b27m_digi_bala",
	"rhs_6b27m_digi_ess_bala",
	"rhs_6b27m_ml",
	"rhs_6b27m_ml_ess",
	"rhs_6b27m_ml_bala",
	"rhs_6b27m_ml_ess_bala",
	"rhs_6b27m_green",
	"rhs_6b27m_green_ess",
	"rhs_6b27m_green_bala",
	"rhs_6b27m_green_ess_bala",
	"rhs_6b28",
	"rhs_6b28_ess",
	"rhs_6b28_bala",
	"rhs_6b28_ess_bala",
	"rhs_6b28_flora",
	"rhs_6b28_flora_ess",
	"rhs_6b28_flora_ess_bala",
	"rhs_6b28_flora_bala",
	"rhs_6b28_green",
	"rhs_6b28_green_ess",
	"rhs_6b28_green_bala",
	"rhs_6b28_green_ess_bala",
	"rhs_beret_vdv1"
];

// Equipment unlocked by default
unlockedWeapons = [
	"rhs_weap_makarov_pm",
	"rhs_weap_aks74u"
];

// Standard rifles for AI are picked from this array. Add only rifles.
unlockedRifles = [
	"rhs_weap_aks74u"
];

unlockedMagazines = [
	"rhs_mag_9x18_8_57N181S",
	"rhs_30Rnd_545x39_AK",
	"rhs_mag_rdg2_white"
];

unlockedItems = unlockedItems + [
	"rhs_acc_pgs64_74u", // << AKS-74UN muzzle attachment
	"rhs_acc_dtk", // << default AK74 muzzle attachment
	"rhs_vest_pistol_holster",
	"rhs_scarf"
];

unlockedBackpacks = [
	"rhs_assault_umbts"
];

unlockedOptics = [];

// Default rifle types, required to unlock specific unit types. Unfortunatly, not all mods classify their weapons the same way, so automatic detection doesn't work reliably enough.
mguns = mguns + ["rhs_weap_pkp","rhs_weap_pkm"];
mguns = mguns arrayIntersect mguns;
srifles = srifles + ["rhs_weap_vss","rhs_weap_svds","rhs_weap_svdp_wd","srifle_GM6_F","rhs_weap_svdp"];
srifles = srifles arrayIntersect srifles;
genGL = ["rhs_weap_akm_gp25","rhs_weap_akms_gp25","rhs_weap_ak103_gp25","rhs_weap_ak74m_gp25"];

// Standard rifles for your troops to be equipped with
baseRifles =+ unlockedRifles;

// Default launchers
genAALaunchers = ["rhs_weap_igla"];
genATLaunchers = ["rhs_weap_rpg26","rhs_weap_rpg7"];

AAmissile = 	"rhs_mag_9k38_rocket";

// NVG, flashlight, laser, mine types
indNVG = 		"rhs_1PN138";
indRF = 		"rhs_pdu4";
indFL = 		"rhs_acc_2dpZenit";
indLaser = 		"rhs_acc_perst1ik";
atMine = 		"rhs_mine_tm62m_mag";
apMine = 		"rhs_mine_pmn2_mag";

// The flag
cFlag = "rhs_Flag_vdv_F";

// Affiliation
side_green = 	independent;

// Long-range radio
lrRadio = "tf_mr3000_rhs";

/*
These are the vehicles and statics that you can buy at HQ. Currently, the array requires a strict(!) order.
0-2: civilian vehicles
3-12: military vehicles and statics
*/
vfs = [
	"C_Offroad_01_F",
	"C_Van_01_transport_F",
	"RHS_Mi8amt_civilian",
	"B_G_Quadbike_01_F",
	"rhs_uaz_open_MSV_01",
	"rhs_gaz66o_msv",
	"B_G_Offroad_01_armed_F",
	"rhs_DSHKM_ins",
	"rhs_2b14_82mm_msv",
	"rhs_Metis_9k115_2_vdv",
	"RHS_ZU23_VDV",
	"rhs_bmd1_chdkz",
	"rhs_gaz66_r142_vdv"
];

// Define the civilian helicopter that allows you to go undercover
civHeli = "RHS_Mi8amt_civilian";

// Define the ammo crate to be spawned at camps
campCrate = "Box_NATO_Equip_F";

A3_STR_INDEP = localize "STR_genIdent_AFRF";