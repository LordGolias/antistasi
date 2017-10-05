private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["B_Heli_Light_01_F"]] call DICT_fnc_setLocal;
[_dict, "helis_land", ["B_Heli_Transport_01_camo_F"]] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", ["B_Heli_Transport_03_F"]] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["B_Heli_Attack_01_F"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["B_Heli_Light_01_armed_F"]] call DICT_fnc_setLocal;
[_dict, "planes", ["B_Plane_CAS_01_F"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["B_UAV_01_F"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["B_UAV_02_F"]] call DICT_fnc_setLocal;

// used in NATO armor mission
[_dict, "mbts", ["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"]] call DICT_fnc_setLocal;

// used in NATO roadblock mission
[_dict, "trucks", ["B_Truck_01_covered_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["B_APC_Wheeled_01_cannon_F"]] call DICT_fnc_setLocal;

// used in NATO artillery mission
[_dict, "artillery1", ["B_MBT_01_arty_F"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["B_MBT_01_mlrs_F"]] call DICT_fnc_setLocal;

// used in NATO spawns (base and airfield)
[_dict, "other_vehicles", [
"B_Truck_01_medical_F", "B_Truck_01_fuel_F"
]] call DICT_fnc_setLocal;

bluStatAA = ["B_static_AA_F"];
bluStatAT = ["B_static_AT_F"];
bluStatHMG = ["B_HMG_01_high_F"];
bluStatMortar = ["B_G_Mortar_01_F"];

// special units used in special occasions
[_dict, "gunner", "B_crew_F"] call DICT_fnc_setLocal;
[_dict, "crew", "B_crew_F"] call DICT_fnc_setLocal;
[_dict, "pilot", "B_Pilot_F"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry")] call DICT_fnc_setLocal;

bluAirCav = ["B_recon_TL_F","B_recon_LAT_F","B_Recon_Sharpshooter_F","B_recon_medic_F","B_recon_F","B_recon_JTAC_F"];

// groups that are spawned
bluSquad = ["BUS_InfSquad"];
bluSquadWeapons = ["BUS_InfSquad_Weapons"];
bluTeam = ["BUS_InfTeam"];
bluATTeam = ["BUS_InfTeam_AT"];

bluIR = "acc_pointer_IR";

bluFlag = "Flag_NATO_F";
AS_NATOname = "NATO";

bluAT = [
"launch_B_Titan_short_F",
"launch_NLAW_F"
];

bluAA = [
"launch_B_Titan_F"
];
