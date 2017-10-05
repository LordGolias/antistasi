private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

// (un-)armed transport helicopters
opHeliTrans = ["CUP_O_Mi8_medevac_RU"];
// helicopter that dismounts troops
opHeliDismount = "CUP_O_Mi8_medevac_RU";
// helicopter that fastropes troops in
opHeliFR = "CUP_O_Mi8_medevac_RU";
// small armed helicopter
opHeliSD = "CUP_O_Mi8_RU";
// gunship
opGunship = "CUP_O_Ka52_RU";

// CAS, fixed-wing
opCASFW = ["CUP_O_SU34_AGM_RU"];

[_dict, "uavs_small", ["CUP_O_Pchela1T_RU"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

[_dict, "mbts", ["CUP_O_T72_RU", "CUP_O_T90_RU"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["CUP_O_Ural_RU", "CUP_O_Ural_Open_RU"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["CUP_O_BMP2_RU", "CUP_O_BMP3_RU", "CUP_O_BTR90_RU"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars", ["CUP_O_UAZ_Unarmed_RU", "CUP_O_UAZ_Open_RU"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["CUP_O_D30_RU"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["CUP_O_BM21_RU"]] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"CUP_O_Ural_Reammo_RU", "CUP_O_Ural_Refuel_RU", "CUP_O_Ural_Repair_RU"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["CUP_O_2S6M_RU"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "CUP_O_RU_Officer_VDV"] call DICT_fnc_setLocal;
[_dict, "traitor", "CUP_O_RU_Officer_VDV"] call DICT_fnc_setLocal;
[_dict, "gunner", "CUP_O_RU_Crew_VDV"] call DICT_fnc_setLocal;
[_dict, "crew", "CUP_O_RU_Crew_VDV"] call DICT_fnc_setLocal;
[_dict, "pilot", "CUP_O_RU_Pilot_VDV"] call DICT_fnc_setLocal;

[_dict, "static_aa", "CU_O_ZU23_RU"] call DICT_fnc_setLocal;
[_dict, "static_mg", "CUP_O_KORD_high_RU"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "CUP_O_2b14_82mm_RU"] call DICT_fnc_setLocal;

// infantry classes used in missions
opI_SL = 	"CUP_O_RU_Soldier_SL_VDV"; // squad leader, urban camo
opI_RFL1 = 	"CUP_O_RU_Soldier_VDV"; // rifleman, urban camo

// standard group arrays, used for spawning groups
[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "CUP_O_RU" >> "Infantry"] call DICT_fnc_setLocal;
opGroup_SpecOps = ["CUP_O_RU_ReconTeam"]; // spec opcs
opGroup_Squad = ["CUP_O_RU_InfSquad"]; // squad
opGroup_Recon_Team = ["CUP_O_RU_InfSection"];

// the affiliation
opFlag = "Flag_CSAT_F";
// Its acronym
AS_CSATname = "CSAT";

opIR = "acc_pointer_IR";

opCrate = "Box_East_WpsLaunch_F";
