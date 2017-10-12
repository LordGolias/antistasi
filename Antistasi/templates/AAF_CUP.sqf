private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str east] call DICT_fnc_set;
[_dict, "roles", ["state"]] call DICT_fnc_set;
[_dict, "name", "ChDKZ (CUP)"] call DICT_fnc_set;
[_dict, "flag", "Flag_Red_F"] call DICT_fnc_set;

// special units used in special occasions
[_dict, "officer", "CUP_O_INS_Officer"] call DICT_fnc_set;
[_dict, "traitor", "CUP_O_INS_Story_Bardak"] call DICT_fnc_set;
[_dict, "gunner", "CUP_O_INS_Crew"] call DICT_fnc_set;
[_dict, "crew", "CUP_O_INS_Crew"] call DICT_fnc_set;
[_dict, "pilot", "CUP_O_INS_Pilot"] call DICT_fnc_set;

// To modders: equipment in AAF boxes comes from the set of all equipment of all units on the groups of this cfg
[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "East" >> "CUP_O_ChDKZ" >> "Infantry")] call DICT_fnc_set;

// These groups are used in different spawns (locations, patrols, missions)
[_dict, "patrols", ["CUP_O_ChDKZ_InfSquad_Weapons"]] call DICT_fnc_set;
[_dict, "teams", ["CUP_O_ChDKZ_InfSquad_Weapons", "CUP_O_ChDKZ_InfSquad"]] call DICT_fnc_set;
[_dict, "squads", ["CUP_O_ChDKZ_InfSquad_Weapons", "CUP_O_ChDKZ_InfSquad"]] call DICT_fnc_set;
[_dict, "teamsAA", ["CUP_O_ChDKZ_InfSection_AA"]] call DICT_fnc_set;

// To modders: overwrite this in the template to change the vehicles AAF uses.
// Rules:
// 1. vehicle must exist.
// 2. each vehicle must belong to only one category.
[_dict, "planes", ["CUP_O_Su25_RU_1"]] call DICT_fnc_set;
[_dict, "helis_armed", ["CUP_O_Mi24_P_RU", "CUP_O_Ka60_Grey_RU"]] call DICT_fnc_set;
[_dict, "helis_transport", ["CUP_O_Mi8_CHDKZ", "CUP_O_Mi8_medevac_CHDKZ", "CUP_O_Mi8_VIV_CHDKZ"]] call DICT_fnc_set;
[_dict, "tanks", ["CUP_O_T72_CHDKZ"]] call DICT_fnc_set;
[_dict, "boats", ["I_Boat_Armed_01_minigun_F"]] call DICT_fnc_set;
[_dict, "cars_transport", ["CUP_O_UAZ_Unarmed_CHDKZ", "CUP_O_UAZ_Open_CHDKZ"]] call DICT_fnc_set;
[_dict, "cars_armed", ["CUP_O_UAZ_AGS30_CHDKZ", "CUP_O_UAZ_MG_CHDKZ", "CUP_O_BRDM2_CHDKZ", "CUP_O_HQ_CHDKZ"]] call DICT_fnc_set;
[_dict, "apcs", ["CUP_O_BMP2_CHDKZ", "CUP_O_BMP2_HQ_CHDKZ"]] call DICT_fnc_set;
[_dict, "trucks", ["CUP_O_Ural_CHDKZ", "CUP_O_Ural_Open_CHDKZ"]] call DICT_fnc_set;

[_dict, "truck_ammo", "CUP_O_Ural_Reammo_CHDKZ"] call DICT_fnc_set;
[_dict, "truck_repair", "CUP_O_Ural_Repair_CHDKZ"] call DICT_fnc_set;

[_dict, "uavs_small", []] call DICT_fnc_set;
[_dict, "uavs_attack", []] call DICT_fnc_set;

[_dict, "static_aa", "CUP_O_ZU23_CHDKZ"] call DICT_fnc_set;
[_dict, "static_at", "CUP_O_Meltis_CHDKZ"] call DICT_fnc_set;
[_dict, "static_mg", "CUP_O_KORD_high_CHDKZ"] call DICT_fnc_set;
[_dict, "static_mg_low", "CUP_O_KORD_CHDKZ"] call DICT_fnc_set;
[_dict, "static_mortar", "CUP_O_2b14_82mm_CHDKZ"] call DICT_fnc_set;

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

// Long range radio
lrRadio = "tf_rt1523g_green";

_dict
