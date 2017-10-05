private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["CUP_O_Mi8_medevac_RU"]] call DICT_fnc_setLocal;
[_dict, "helis_land", []] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", ["CUP_O_Mi8_medevac_RU"]] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["CUP_O_Ka52_RU"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["CUP_O_Mi8_RU"]] call DICT_fnc_setLocal;
[_dict, "planes", ["CUP_O_SU34_AGM_RU"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["CUP_O_Pchela1T_RU"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", []] call DICT_fnc_setLocal;

// self-propelled anti air
opSPAA = "CUP_O_2S6M_RU";

opTruck = "CUP_O_Ural_Open_RU";

opMRAPu = "CUP_O_BMP2_RU";

[_dict, "officer", "CUP_O_RU_Officer_VDV"] call DICT_fnc_setLocal;
[_dict, "traitor", "CUP_O_RU_Officer_VDV"] call DICT_fnc_setLocal;
[_dict, "gunner", "CUP_O_RU_Crew_VDV"] call DICT_fnc_setLocal;
[_dict, "crew", "CUP_O_RU_Crew_VDV"] call DICT_fnc_setLocal;
[_dict, "pilot", "CUP_O_RU_Pilot_VDV"] call DICT_fnc_setLocal;

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
