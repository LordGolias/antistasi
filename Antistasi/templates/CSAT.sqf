private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["O_Heli_Light_02_unarmed_F"]] call DICT_fnc_setLocal;
[_dict, "helis_land", ["O_Heli_Transport_04_bench_F"]] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", []] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["O_Heli_Attack_02_F"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["O_Heli_Light_02_F"]] call DICT_fnc_setLocal;
[_dict, "planes", ["O_Plane_CAS_02_F"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["O_UAV_01_F"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["O_UAV_02_F"]] call DICT_fnc_setLocal;

// self-propelled anti air
opSPAA = 			"O_APC_Tracked_02_AA_F";

opTruck = 			"O_Truck_02_transport_F";

opMRAPu = 			"O_MRAP_02_F";

// special units used in special occasions
[_dict, "officer", "O_officer_F"] call DICT_fnc_setLocal;
[_dict, "traitor", "O_G_officer_F"] call DICT_fnc_setLocal;
[_dict, "gunner", "O_crew_F"] call DICT_fnc_setLocal;
[_dict, "crew", "O_crew_F"] call DICT_fnc_setLocal;
[_dict, "pilot", "O_helipilot_F"] call DICT_fnc_setLocal;

// infantry classes used in missions
opI_SL = 	"O_SoldierU_SL_F"; // squad leader, urban camo
opI_RFL1 = 	"O_soldierU_F"; // rifleman, urban camo

// standard group arrays, used for spawning groups
[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry"] call DICT_fnc_setLocal;
opGroup_SpecOps = ["OI_reconTeam"]; // spec opcs
opGroup_Squad = ["OIA_InfSquad"]; // squad
opGroup_Recon_Team = ["OI_reconPatrol"];

// the affiliation
opFlag = "Flag_CSAT_F";
// Its acronym
AS_CSATname = "CSAT";

opIR = "acc_pointer_IR";

opCrate = "Box_East_WpsLaunch_F";
