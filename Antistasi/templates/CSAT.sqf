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

[_dict, "uavs_small", ["O_UAV_01_F"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["O_UAV_02_F"]] call DICT_fnc_setLocal;

[_dict, "mbts", ["O_MBT_02_cannon_F"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["O_Truck_03_covered_F", "O_Truck_03_transport_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["O_APC_Wheeled_02_rcws_F", "O_APC_tracked_02_cannon_F"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars", ["O_MRAP_02_F"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["O_MBT_02_arty_F"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["O_MBT_02_arty_F"]] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"O_Truck_03_ammo_F", "O_Truck_03_fuel_F", "O_Truck_03_medical_F", "O_Truck_03_repair_F"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["O_APC_Tracked_02_AA_F"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "O_officer_F"] call DICT_fnc_setLocal;
[_dict, "traitor", "O_G_officer_F"] call DICT_fnc_setLocal;
[_dict, "gunner", "O_crew_F"] call DICT_fnc_setLocal;
[_dict, "crew", "O_crew_F"] call DICT_fnc_setLocal;
[_dict, "pilot", "O_helipilot_F"] call DICT_fnc_setLocal;

[_dict, "static_aa", "O_static_AA_F"] call DICT_fnc_setLocal;
[_dict, "static_mg", "O_HMG_01_high_F"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "O_Mortar_01_F"] call DICT_fnc_setLocal;

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

opCrate = "Box_East_WpsLaunch_F";
