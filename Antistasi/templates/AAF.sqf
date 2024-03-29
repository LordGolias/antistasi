private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str east] call DICT_fnc_set;
[_dict, "roles", ["state"]] call DICT_fnc_set;
[_dict, "name", "AAF"] call DICT_fnc_set;
[_dict, "flag", "Flag_AAF_F"] call DICT_fnc_set;
[_dict, "box", "I_supplyCrate_F"] call DICT_fnc_set;

// special units used in special occasions
[_dict, "officer", "I_officer_F"] call DICT_fnc_set;
[_dict, "traitor", "I_G_officer_F"] call DICT_fnc_set;
[_dict, "gunner", "I_crew_F"] call DICT_fnc_set;
[_dict, "crew", "I_crew_F"] call DICT_fnc_set;
[_dict, "pilot", "I_helipilot_F"] call DICT_fnc_set;

// To modders: equipment in AAF boxes comes from the set of all equipment of all units on the groups of this cfg
[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry")] call DICT_fnc_set;

// These groups are used in different spawns (locations, patrols, missions)
[_dict, "patrols", ["HAF_InfSentry"]] call DICT_fnc_set;
[_dict, "teams", ["HAF_InfTeam"]] call DICT_fnc_set;
[_dict, "squads", ["HAF_InfSquad","HAF_InfSquad_Weapons"]] call DICT_fnc_set;
[_dict, "teamsAA", ["HAF_InfTeam_AA"]] call DICT_fnc_set;

// To modders: overwrite this in the template to change the vehicles AAF uses.
// Rules:
// 1. vehicle must exist.
// 2. each vehicle must belong to only one category.
[_dict, "planes", ["I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F"]] call DICT_fnc_set;
[_dict, "helis_armed", ["I_Heli_light_03_F"]] call DICT_fnc_set;
[_dict, "helis_transport", ["I_Heli_Transport_02_F"]] call DICT_fnc_set;
[_dict, "tanks", ["I_MBT_03_cannon_F"]] call DICT_fnc_set;
[_dict, "boats", ["I_Boat_Armed_01_minigun_F"]] call DICT_fnc_set;
[_dict, "cars_transport", ["I_MRAP_03_F"]] call DICT_fnc_set;
[_dict, "cars_armed", ["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"]] call DICT_fnc_set;
[_dict, "apcs", ["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"]] call DICT_fnc_set;
[_dict, "trucks", ["I_Truck_02_covered_F","I_Truck_02_transport_F"]] call DICT_fnc_set;

[_dict, "truck_ammo", "I_Truck_02_ammo_F"] call DICT_fnc_set;
[_dict, "truck_repair", "I_Truck_02_box_F"] call DICT_fnc_set;

// The UAV. Set to `[]` to AAF not use UAVs.
[_dict, "uavs_small", ["I_UAV_01_F"]] call DICT_fnc_set;
[_dict, "uavs_attack", ["I_UAV_02_F"]] call DICT_fnc_set;

[_dict, "static_aa", "I_static_AA_F"] call DICT_fnc_set;
[_dict, "static_at", "I_static_AT_F"] call DICT_fnc_set;
[_dict, "static_mg", "I_HMG_01_high_F"] call DICT_fnc_set;
[_dict, "static_mg_low", "I_HMG_01_F"] call DICT_fnc_set;
[_dict, "static_mortar", "I_Mortar_01_F"] call DICT_fnc_set;

// These have to be CfgVehicles mines that explode automatically (minefields)
[_dict, "ap_mines", ["APERSMine", "APERSTripMine", "APERSBoundingMine"]] call DICT_fnc_set;
[_dict, "at_mines", ["ATMine", "SLAMDirectionalMine"]] call DICT_fnc_set;
// These have to be CfgVehicles
[_dict, "explosives", ["SatchelCharge_F","DemoCharge_F","ClaymoreDirectional_F"]] call DICT_fnc_set;

if hasTFAR then {
    [_dict, "tfar_lr_radio", "tf_mr3000"] call DICT_fnc_set;
    [_dict, "tfar_radio", "tf_fadak"] call DICT_fnc_set;
};

_dict
