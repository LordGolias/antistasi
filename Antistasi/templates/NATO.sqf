private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

[_dict, "helis_transport", ["B_Heli_Light_01_F", "B_Heli_Transport_01_camo_F", "B_Heli_Transport_03_F"]] call DICT_fnc_setLocal;
[_dict, "helis_attack", ["B_Heli_Attack_01_F"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["B_Heli_Light_01_armed_F"]] call DICT_fnc_setLocal;
[_dict, "planes", ["B_Plane_CAS_01_F"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["B_UAV_01_F"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["B_UAV_02_F"]] call DICT_fnc_setLocal;

[_dict, "tanks", ["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"]] call DICT_fnc_setLocal;
[_dict, "boats", ["B_Boat_Armed_01_minigun_F"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["B_Truck_01_covered_F", "B_Truck_01_transport_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["B_APC_Wheeled_01_cannon_F"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars_transport", ["B_MRAP_01_F"]] call DICT_fnc_setLocal;
[_dict, "cars_armed", ["B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["B_MBT_01_arty_F"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["B_MBT_01_mlrs_F"]] call DICT_fnc_setLocal;

[_dict, "truck_ammo", "B_Truck_01_ammo_F"] call DICT_fnc_setLocal;
[_dict, "truck_repair", "B_Truck_01_repair_F"] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"B_Truck_01_ammo_F", "B_Truck_01_fuel_F", "B_Truck_01_medical_F", "B_Truck_01_repair_F"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["B_APC_Tracked_01_AA_F"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "B_officer_F"] call DICT_fnc_setLocal;
[_dict, "traitor", "B_G_officer_F"] call DICT_fnc_setLocal;
[_dict, "gunner", "B_crew_F"] call DICT_fnc_setLocal;
[_dict, "crew", "B_crew_F"] call DICT_fnc_setLocal;
[_dict, "pilot", "B_Pilot_F"] call DICT_fnc_setLocal;

[_dict, "static_aa", "B_static_AA_F"] call DICT_fnc_setLocal;
[_dict, "static_at", "B_static_AT_F"] call DICT_fnc_setLocal;
[_dict, "static_mg", "B_HMG_01_high_F"] call DICT_fnc_setLocal;
[_dict, "static_mg_low", "B_HMG_01_F"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "B_Mortar_01_F"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry")] call DICT_fnc_setLocal;
[_dict, "squads", ["BUS_InfSquad"]] call DICT_fnc_setLocal;
[_dict, "teams", ["BUS_InfTeam"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["BUS_InfTeam_AA"]] call DICT_fnc_setLocal;
[_dict, "patrols", ["BUS_InfTeam"]] call DICT_fnc_setLocal;
[_dict, "recon_squad", "BUS_ReconSquad"] call DICT_fnc_setLocal;
[_dict, "recon_team", "BUS_ReconPatrol"] call DICT_fnc_setLocal;

[_dict, "name", "NATO"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_NATO_F"] call DICT_fnc_setLocal;
[_dict, "box", "Box_NATO_Equip_F"] call DICT_fnc_setLocal;
