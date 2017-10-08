private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str east] call DICT_fnc_setLocal;
[_dict, "roles", ["pro_anti_state", "state", "pro_state"]] call DICT_fnc_setLocal;

[_dict, "helis_transport", ["O_Heli_Transport_04_bench_F", "O_Heli_Light_02_unarmed_F"]] call DICT_fnc_setLocal;
[_dict, "helis_attack", ["O_Heli_Attack_02_F"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["O_Heli_Light_02_F"]] call DICT_fnc_setLocal;
[_dict, "planes", ["O_Plane_CAS_02_F"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", ["O_UAV_01_F"]] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["O_UAV_02_F"]] call DICT_fnc_setLocal;

[_dict, "tanks", ["O_MBT_02_cannon_F"]] call DICT_fnc_setLocal;
[_dict, "boats", ["O_Boat_Armed_01_hmg_F"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["O_Truck_03_covered_F", "O_Truck_03_transport_F"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["O_APC_Wheeled_02_rcws_F", "O_APC_tracked_02_cannon_F"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars_transport", ["O_MRAP_02_F"]] call DICT_fnc_setLocal;
[_dict, "cars_armed", ["O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["O_MBT_02_arty_F"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["O_MBT_02_arty_F"]] call DICT_fnc_setLocal;

[_dict, "truck_ammo", "O_Truck_03_ammo_F"] call DICT_fnc_setLocal;
[_dict, "truck_repair", "O_Truck_03_repair_F"] call DICT_fnc_setLocal;

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
[_dict, "static_at", "O_static_AT_F"] call DICT_fnc_setLocal;
[_dict, "static_mg", "O_HMG_01_high_F"] call DICT_fnc_setLocal;
[_dict, "static_mg_low", "O_HMG_01_F"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "O_Mortar_01_F"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", configfile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry"] call DICT_fnc_setLocal;
[_dict, "squads", ["OIA_InfSquad"]] call DICT_fnc_setLocal;
[_dict, "teams", ["OIA_InfTeam"]] call DICT_fnc_setLocal;
[_dict, "teamsAA", ["OIA_InfTeam_AA"]] call DICT_fnc_setLocal;
[_dict, "patrols", ["OIA_InfSentry"]] call DICT_fnc_setLocal;
[_dict, "recon_squad", "OIA_reconSquad"] call DICT_fnc_setLocal;
[_dict, "recon_team", "OI_reconTeam"] call DICT_fnc_setLocal;

[_dict, "name", "CSAT"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_CSAT_F"] call DICT_fnc_setLocal;
[_dict, "box", "Box_East_WpsLaunch_F"] call DICT_fnc_setLocal;

_dict
