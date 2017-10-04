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

// small UAV
opUAVsmall = "CUP_O_Pchela1T_RU";

// air force
opAir = opHeliTrans + [opHeliSD, opGunship] + opCASFW;

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
