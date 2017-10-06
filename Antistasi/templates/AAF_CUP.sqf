/*
List of infantry classes. These will have individual equipment mapped to them.
*/

private _sol_MED = "CUP_O_INS_Medic"; // Medic
private _sol_ENG = "CUP_O_INS_Soldier_Engineer"; // Engineer
private _sol_OFF = "CUP_O_INS_Officer"; // Officer
private _sol_LAT2 = "CUP_O_INS_Soldier_AT"; // Light AT (extra)
private _sol_MK = "CUP_O_INS_Sniper"; // Marksman
private _sol_CREW = "CUP_O_INS_Crew";
private _sol_HPIL = "CUP_O_INS_Pilot";

private _dict = [AS_entities, "AAF"] call DICT_fnc_get;

[_dict, "gunner", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "crew", _sol_CREW] call DICT_fnc_setLocal;
[_dict, "pilot", _sol_HPIL] call DICT_fnc_setLocal;
[_dict, "medic", _sol_MED] call DICT_fnc_setLocal;
[_dict, "driver", _sol_CREW] call DICT_fnc_setLocal;

[_dict, "officers", [_sol_OFF]] call DICT_fnc_setLocal;
[_dict, "snipers", [_sol_MK]] call DICT_fnc_setLocal;
[_dict, "ncos", ["CUP_O_INS_Commander"]] call DICT_fnc_setLocal;
[_dict, "specials", ["CUP_O_INS_Soldier_AA", _sol_LAT2, _sol_MED, _sol_ENG]] call DICT_fnc_setLocal;
[_dict, "mgs", ["CUP_O_INS_Soldier_AR", "CUP_O_INS_Soldier_MG"]] call DICT_fnc_setLocal;
[_dict, "regulars", ["CUP_O_INS_Soldier", "CUP_O_INS_Soldier_Ammo", "CUP_O_INS_Soldier_GL", "CUP_O_INS_Soldier_AK74"]] call DICT_fnc_setLocal;
[_dict, "crews", [_sol_CREW]] call DICT_fnc_setLocal;
[_dict, "pilots", [_sol_HPIL]] call DICT_fnc_setLocal;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "East" >> "CUP_O_ChDKZ" >> "Infantry")] call DICT_fnc_setLocal;

[_dict, "patrols", ["CUP_O_ChDKZ_InfSquad_Weapons"]] call DICT_fnc_setLocal;
[_dict, "garrisons", ["CUP_O_ChDKZ_InfSquad_Weapons"]] call DICT_fnc_setLocal;
[_dict, "teamsATAA", ["CUP_O_ChDKZ_InfSection_AT","CUP_O_ChDKZ_InfSection_AA"]] call DICT_fnc_setLocal;
[_dict, "teams", ["CUP_O_ChDKZ_InfSquad_Weapons", "CUP_O_ChDKZ_InfSquad"]] call DICT_fnc_setLocal;
[_dict, "squads", ["CUP_O_ChDKZ_InfSquad_Weapons", "CUP_O_ChDKZ_InfSquad"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["CUP_O_ChDKZ_InfSection_AA"]] call DICT_fnc_setLocal;
[_dict, "teamsAT", ["CUP_O_ChDKZ_InfSection_AT"]] call DICT_fnc_setLocal;

[_dict, "planes", ["CUP_O_Su25_RU_1"]] call DICT_fnc_setLocal;
[_dict, "armedHelis", ["CUP_O_Mi24_P_RU", "CUP_O_Ka60_Grey_RU"]] call DICT_fnc_setLocal;
[_dict, "transportHelis", ["CUP_O_Mi8_CHDKZ", "CUP_O_Mi8_medevac_CHDKZ", "CUP_O_Mi8_VIV_CHDKZ"]] call DICT_fnc_setLocal;
[_dict, "tanks", ["CUP_O_T72_CHDKZ"]] call DICT_fnc_setLocal;
[_dict, "boats", ["I_Boat_Armed_01_minigun_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["CUP_O_BRDM2_CHDKZ", "CUP_O_BRDM2_ATGM_CHDKZ", "CUP_O_HQ_CHDKZ", "CUP_O_BMP2_CHDKZ", "CUP_O_BMP2_HQ_CHDKZ"]] call DICT_fnc_setLocal;
[_dict, "trucks", ["CUP_O_Ural_CHDKZ", "CUP_O_Ural_Open_CHDKZ"]] call DICT_fnc_setLocal;
[_dict, "supplies", ["CUP_O_Ural_Reammo_CHDKZ", "CUP_O_Ural_Refuel_CHDKZ", "CUP_O_Ural_Repair_CHDKZ"]] call DICT_fnc_setLocal;

[_dict, "patrolVehicles", ["CUP_O_BRDM2_CHDKZ","CUP_O_BRDM2_ATGM_CHDKZ","CUP_O_BMP2_CHDKZ","CUP_O_Ka60_Grey_RU"]] call DICT_fnc_setLocal;
[_dict, "ammoVehicles", ["CUP_O_Ural_Reammo_CHDKZ"]] call DICT_fnc_setLocal;
[_dict, "leadVehicles", ["CUP_O_BMP2_CHDKZ","CUP_O_BRDM2_CHDKZ"]] call DICT_fnc_setLocal;
[_dict, "repairVehicles", ["CUP_O_Ural_Repair_CHDKZ"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", []] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

// Statics to be used
statMG = "CUP_O_KORD_high_CHDKZ";
statAT = "CUP_O_Meltis_CHDKZ";
statAA = "CUP_O_ZU23_CHDKZ";
statAA2 = "CUP_O_ZU23_CHDKZ";
statMortar = "CUP_O_2b14_82mm_CHDKZ";

statMGlow = "CUP_O_KORD_CHDKZ";
statMGtower = "CUP_O_KORD_high_CHDKZ";

// Lists of statics to determine the defensive capabilities at locations
allStatMGs = allStatMGs + [statMG];
allStatATs = allStatATs + [statAT];
allStatAAs = allStatAAs + [statAA];
allStatMortars = allStatMortars + [statMortar];

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
