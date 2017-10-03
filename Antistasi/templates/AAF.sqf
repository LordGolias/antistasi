/*
List of infantry classes. These will have individual equipment mapped to them.
*/
private _sol_A_AA = "I_Soldier_AAA_F"; // Assistant AA
private _sol_A_AR = "I_Soldier_AAR_F"; // Assistant autorifle
private _sol_A_AT = "I_Soldier_AAT_F"; // Assistant AT
private _sol_AA = "I_Soldier_AA_F"; // AA
private _sol_AR = "I_Soldier_AR_F"; // Autorifle
private _sol_AT = "I_Soldier_AT_F"; // AT
private _sol_AMMO = "I_Soldier_A_F"; // Ammo bearer
private _sol_GL = "I_Soldier_GL_F"; // Grenade launcher
private _sol_LAT = "I_Soldier_LAT_F"; // Light AT
private _sol_MG = "I_Soldier_AR_F"; // Machinegunner (extra)
private _sol_MK = "I_Soldier_M_F"; // Marksman
private _sol_SL = "I_Soldier_SL_F"; // Squad leader
private _sol_TL = "I_Soldier_TL_F"; // Team leader
private _sol_EXP = "I_Soldier_exp_F"; // Explosives
private _sol_R_L = "I_Soldier_lite_F"; // Rifleman, light
private _sol_REP = "I_Soldier_repair_F"; // Repair
private _sol_RFL = "I_soldier_F"; // Rifleman
private _sol_SN = "I_Sniper_F"; // Sniper
private _sol_SP = "I_Spotter_F"; // Spotter
private _sol_MED = "I_medic_F"; // Medic
private _sol_ENG = "I_engineer_F"; // Engineer
private _sol_OFF = "I_officer_F"; // Officer

private _sol_CREW = "I_crew_F"; // Crew
private _sol_HCREW = "I_helicrew_F"; // Helicopter crew
private _sol_HPIL = "I_helipilot_F"; // Helicopter pilot
private _sol_PIL = "I_pilot_F"; // Pilot
private _sol_UAV = "I_soldier_UAV_F"; // UAV controller

private _sol_SUP_AMG = "I_support_AMG_F"; // Assistant HMG gunner
private _sol_SUP_AMTR = "I_support_AMort_F"; // Assistant mortar gunner
private _sol_SUP_GMG = "I_support_GMG_F"; // GMG gunner
private _sol_SUP_MG = "I_support_MG_F"; // HMG gunner
private _sol_SUP_MTR = "I_support_Mort_F"; // mortar gunner

// units when AAF is EAST
private _dict = [AS_units, "AAF", "EAST"] call DICT_fnc_get;
[_dict, "gunner", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "crew", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "pilot", _sol_HPIL] call DICT_fnc_setLocal;
[_dict, "medic", _sol_MED] call DICT_fnc_setLocal;
[_dict, "driver", _sol_CREW] call DICT_fnc_setLocal;

[_dict, "officers", [_sol_OFF]] call DICT_fnc_setLocal;
[_dict, "snipers", [_sol_MK, _sol_SN, _sol_SP]] call DICT_fnc_setLocal;
[_dict, "ncos", [_sol_SL, _sol_TL]] call DICT_fnc_setLocal;
[_dict, "specials", [_sol_A_AA, _sol_A_AT, _sol_AA, _sol_AT, _sol_EXP, _sol_REP, _sol_ENG, _sol_MED]] call DICT_fnc_setLocal;
[_dict, "mgs", [_sol_AR, _sol_MG]] call DICT_fnc_setLocal;
[_dict, "regulars", [_sol_A_AR, _sol_AMMO, _sol_GL, _sol_LAT, _sol_R_L, _sol_RFL]] call DICT_fnc_setLocal;
[_dict, "crews", [_sol_CREW, _sol_HCREW, _sol_UAV, _sol_SUP_AMG, _sol_SUP_AMTR, _sol_SUP_GMG, _sol_SUP_MG, _sol_SUP_MTR]] call DICT_fnc_setLocal;
[_dict, "pilots", [_sol_HPIL, _sol_PIL]] call DICT_fnc_setLocal;

// Grups used for spawning groups.
// To modders: equipment of units in these groups is also part of the AAF equipment.
AAFConfigGroupInf = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry");
infPatrol = ["HAF_InfSentry","HAF_InfSentry","HAF_InfSentry","HAF_SniperTeam"];
infGarrisonSmall = ["HAF_InfSentry"];
infTeamATAA =["HAF_InfTeam_AA","HAF_InfTeam_AT"];
infTeam = ["HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_InfTeam","HAF_InfTeam","HAF_InfTeam"];
infSquad = ["HAF_InfSquad","HAF_InfSquad_Weapons"];
infAA =["HAF_InfTeam_AA"];
infAT =["HAF_InfTeam_AT"];

// To modders: overwrite this in the template to change the AAF arsenal.
// Rules:
// 1. vehicle must exist.
// 2. each vehicle must belong to only one category.
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

// To modders (optional): use "cost" to set cost for the AAF
// to buy vehicles of CATEGORY. E.g.
//      ["planes", "cost", 20000] call AS_AAFarsenal_fnc_set;

// To modders (optional): use "value" to set value the FIA gets to sell AAF vehicles of CATEGORY.
// ["planes", "value", 10000] call AS_AAFarsenal_fnc_set;

// List of special vehicles used in custom events
//moders: all vehicles defined in these lists must also belong to the AAFarsenal.
vehPatrol = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Heli_light_03_F"];
vehAmmo = "I_Truck_02_ammo_F";
vehLead = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];  // lead of convoy
vehTruckBox = ["I_Truck_02_box_F"];
vehBoat = "I_Boat_Armed_01_minigun_F";

AS_AAFarsenal_uav = "I_UAV_02_F";  // Set to `""` to AAF not use UAVs.

// Statics to be used
statMG = "I_HMG_01_high_F";
statAT = "I_static_AT_F";
statAA = "I_static_AA_F";
statAA2 = "I_static_AA_F";
statMortar = "I_Mortar_01_F";

statMGlow = "I_HMG_01_F";
statMGtower = "I_HMG_01_high_F";

// Lists of statics to determine the defensive capabilities at locations
allStatMGs = allStatMGs + [statMG];
allStatATs = allStatATs + [statAT];
allStatAAs = allStatAAs + [statAA];
allStatMortars = allStatMortars + [statMortar];

// Backpacks of dismantled statics -- 0: weapon, 1: tripod/support
statMGBackpacks = ["I_HMG_01_high_weapon_F","I_HMG_01_support_high_F"];
statATBackpacks = ["I_AT_01_weapon_F","I_HMG_01_support_F"];
statAABackpacks = ["I_AA_01_weapon_F","I_HMG_01_support_F"];
statMortarBackpacks = ["I_Mortar_01_weapon_F","I_Mortar_01_support_F"];
statMGlowBackpacks = ["I_HMG_01_F","I_HMG_01_support_F"];
statMGtowerBackpacks = ["I_HMG_01_high_weapon_F","I_HMG_01_support_high_F"];

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

// NVG, flashlight, laser, mine types
indNVG = "NVGoggles_INDEP";
indRF = "Rangefinder";
indFL = "acc_flashlight";
indLaser = "acc_pointer_IR";

// The flag
cFlag = "Flag_AAF_F";
AS_AAFname = "AAF";

// Long range radio
lrRadio = "tf_rt1523g_green";

// Define the ammo crate to be spawned at camps
campCrate = "Box_NATO_Equip_F";
