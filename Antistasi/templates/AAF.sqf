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

private _dict = [AS_entities, "AAF"] call DICT_fnc_get;

// special units used in special occasions
[_dict, "gunner", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "crew", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "pilot", _sol_HPIL] call DICT_fnc_setLocal;
[_dict, "medic", _sol_MED] call DICT_fnc_setLocal;
[_dict, "driver", _sol_CREW] call DICT_fnc_setLocal;

// Special unit types for special occasions
[_dict, "officers", [_sol_OFF]] call DICT_fnc_setLocal;
[_dict, "snipers", [_sol_MK, _sol_SN, _sol_SP]] call DICT_fnc_setLocal;
[_dict, "ncos", [_sol_SL, _sol_TL]] call DICT_fnc_setLocal;
[_dict, "specials", [_sol_A_AA, _sol_A_AT, _sol_AA, _sol_AT, _sol_EXP, _sol_REP, _sol_ENG, _sol_MED]] call DICT_fnc_setLocal;
[_dict, "mgs", [_sol_AR, _sol_MG]] call DICT_fnc_setLocal;
[_dict, "regulars", [_sol_A_AR, _sol_AMMO, _sol_GL, _sol_LAT, _sol_R_L, _sol_RFL]] call DICT_fnc_setLocal;
[_dict, "crews", [_sol_CREW, _sol_HCREW, _sol_UAV, _sol_SUP_AMG, _sol_SUP_AMTR, _sol_SUP_GMG, _sol_SUP_MG, _sol_SUP_MTR]] call DICT_fnc_setLocal;
[_dict, "pilots", [_sol_HPIL, _sol_PIL]] call DICT_fnc_setLocal;

// To modders: equipment in AAF boxes comes from the set of all equipment of all units on the groups of this cfg
[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry")] call DICT_fnc_setLocal;

// These squads are spawned in different spawns (locations, patrols, missions)
[_dict, "patrols", ["HAF_InfSentry","HAF_InfSentry","HAF_InfSentry","HAF_SniperTeam"]] call DICT_fnc_setLocal;
[_dict, "garrisons", ["HAF_InfSentry"]] call DICT_fnc_setLocal;
[_dict, "teamsATAA", ["HAF_InfTeam_AA","HAF_InfTeam_AT"]] call DICT_fnc_setLocal;
[_dict, "teams", ["HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_InfTeam","HAF_InfTeam","HAF_InfTeam"]] call DICT_fnc_setLocal;
[_dict, "squads", ["HAF_InfSquad","HAF_InfSquad_Weapons"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["HAF_InfTeam_AA"]] call DICT_fnc_setLocal;
[_dict, "teamsAT", ["HAF_InfTeam_AT"]] call DICT_fnc_setLocal;

// To modders: overwrite this in the template to change the vehicles AAF uses.
// Rules:
// 1. vehicle must exist.
// 2. each vehicle must belong to only one category.
[_dict, "planes", ["I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F"]] call DICT_fnc_setLocal;
[_dict, "armedHelis", ["I_Heli_light_03_F"]] call DICT_fnc_setLocal;
[_dict, "transportHelis", ["I_Heli_Transport_02_F"]] call DICT_fnc_setLocal;
[_dict, "tanks", ["I_MBT_03_cannon_F"]] call DICT_fnc_setLocal;
[_dict, "boats", ["I_Boat_Armed_01_minigun_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MRAP_03_F","I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"]] call DICT_fnc_setLocal;
[_dict, "trucks", ["I_Truck_02_covered_F","I_Truck_02_transport_F"]] call DICT_fnc_setLocal;
[_dict, "supplies", ["I_Truck_02_fuel_F","I_Truck_02_medical_F","I_Truck_02_ammo_F"]] call DICT_fnc_setLocal;

// vehicles used in road patrols
[_dict, "patrolVehicles", ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Heli_light_03_F","I_Boat_Armed_01_minigun_F"]] call DICT_fnc_setLocal;
// vehicles used to store and transport weapons
[_dict, "ammoVehicles", ["I_Truck_02_ammo_F"]] call DICT_fnc_setLocal;
// vehicles used to lead convoys
[_dict, "leadVehicles", ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]] call DICT_fnc_setLocal;
// vehicles used to repair stuff
[_dict, "repairVehicles", ["I_Truck_02_box_F"]] call DICT_fnc_setLocal;

// The UAV. Set to `""` to AAF not use UAVs.
[_dict, "uav", "I_UAV_02_F"] call DICT_fnc_setLocal;

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
