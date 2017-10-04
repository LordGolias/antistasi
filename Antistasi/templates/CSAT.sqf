private _dict = [AS_entities, "CSAT"] call DICT_fnc_get;

// (un-)armed transport helicopters
opHeliTrans = 		["O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_bench_F"];

// helicopter that dismounts troops
opHeliDismount = 	"O_Heli_Transport_04_bench_F"; // Mi-290 Taru (Bench)

// helicopter that fastropes troops in
opHeliFR = 			"O_Heli_Light_02_unarmed_F"; // PO-30 Orca (Unarmed)

// small armed helicopter
opHeliSD = 			"O_Heli_Light_02_F"; // PO-30 Orca (Armed)

// gunship
opGunship = 		"O_Heli_Attack_02_F"; // Mi-48 Kajman

// CAS, fixed-wing
opCASFW = 			["O_Plane_CAS_02_F"]; // To-199 Neophron (CAS)

// small UAV (Darter, etc)
opUAVsmall = 		"O_UAV_01_F"; // Tayran AR-2

// air force
opAir = 			["O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_bench_F","O_Heli_Attack_02_F","O_Plane_CAS_02_F","O_Heli_Light_02_F"];

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
