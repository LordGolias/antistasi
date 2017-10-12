private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str west] call DICT_fnc_set;
[_dict, "roles", ["state", "foreign"]] call DICT_fnc_set;
[_dict, "name", "USMC (CUP)"] call DICT_fnc_set;
[_dict, "flag", "Flag_US_F"] call DICT_fnc_set;

[_dict, "helis_transport", ["CUP_B_UH1Y_UNA_USMC", "CUP_B_CH53E_USMC"]] call DICT_fnc_set;
[_dict, "helis_attack", ["CUP_B_AH1Z_Dynamic_USMC"]] call DICT_fnc_set;
[_dict, "helis_armed", ["CUP_B_UH1Y_Gunship_Dynamic_USMC", "CUP_B_MH60L_DAP_2x_AT_USN", "CUP_B_MH60L_DAP_2x_Escort_USN", "CUP_B_MH60L_DAP_2x_Multi_USN"]] call DICT_fnc_set;
[_dict, "planes", ["CUP_B_F35B_CAS_USMC"]] call DICT_fnc_set;

[_dict, "uavs_small", []] call DICT_fnc_set;
[_dict, "uavs_attack", ["CUP_B_USMC_MQ9"]] call DICT_fnc_set;

[_dict, "tanks", ["CUP_B_M1A1_DES_USMC", "CUP_B_M1A2_TUSK_MG_DES_USMC"]] call DICT_fnc_set;
[_dict, "boats", ["CUP_B_RHIB2Turret_USMC"]] call DICT_fnc_set;

// used in roadblock mission
[_dict, "trucks", ["CUP_B_MTVR_USMC"]] call DICT_fnc_set;
[_dict, "apcs", ["CUP_B_LAV25M240_desert_USMC", "CUP_B_LAV25_desert_USMC"]] call DICT_fnc_set;

// used in traitor mission
[_dict, "cars_transport", ["CUP_B_HMMWV_Unarmed_USMC"]] call DICT_fnc_set;
[_dict, "cars_armed", ["CUP_B_HMMWV_MK19_USMC", "CUP_B_HMMWV_M2_USMC", "CUP_B_HMMWV_M1114_USMC", "CUP_B_RG31_M2_OD_USMC", "CUP_B_RG31_Mk19_OD_USMC"]] call DICT_fnc_set;

// used in artillery mission
[_dict, "artillery1", ["CUP_B_M270_HE_USMC"]] call DICT_fnc_set;
[_dict, "artillery2", ["UP_B_M270_DPICM_USMC"]] call DICT_fnc_set;

[_dict, "truck_ammo", "CUP_B_MTVR_Ammo_USMC"] call DICT_fnc_set;
[_dict, "truck_repair", "CUP_B_MTVR_Repair_USMC"] call DICT_fnc_set;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"CUP_B_MTVR_Ammo_USMC","CUP_B_MTVR_Refuel_USMC", "CUP_B_HMMWV_Ambulance_USMC", "CUP_B_MTVR_Repair_USMC"
]] call DICT_fnc_set;

[_dict, "self_aa", ["CUP_B_HMMWV_Avenger_USMC"]] call DICT_fnc_set;

// special units used in special occasions
[_dict, "officer", "CUP_B_USMC_Officer"] call DICT_fnc_set;
[_dict, "traitor", "CUP_B_USMC_Officer"] call DICT_fnc_set;
[_dict, "gunner", "CUP_B_USMC_Crew"] call DICT_fnc_set;
[_dict, "crew", "CUP_B_USMC_Crew"] call DICT_fnc_set;
[_dict, "pilot", "CUP_B_USMC_Pilot"] call DICT_fnc_set;

[_dict, "static_aa", ""] call DICT_fnc_set;
[_dict, "static_at", "CUP_B_TOW_TriPod_USMC"] call DICT_fnc_set;
[_dict, "static_mg", "CUP_B_M2StaticMG_USMC"] call DICT_fnc_set;
[_dict, "static_mg_low", "CUP_B_M2StaticMG_MiniTripod_USMC"] call DICT_fnc_set;
[_dict, "static_mortar", "CUP_B_M252_USMC"] call DICT_fnc_set;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "CUP_B_USMC" >> "Infantry")] call DICT_fnc_set;
[_dict, "squads", ["CUP_B_USMC_InfSquad"]] call DICT_fnc_set;
[_dict, "teams", ["CUP_B_USMC_FireTeam"]] call DICT_fnc_set;
[_dict, "teamsAA", ["CUP_B_USMC_FireTeam"]] call DICT_fnc_set; // USMC has no AA team
[_dict, "recon_squad", "CUP_B_USMC_FRTeam"] call DICT_fnc_set;
[_dict, "recon_team", "CUP_B_USMC_FRTeam"] call DICT_fnc_set;

[_dict, "box", "Box_NATO_Equip_F"] call DICT_fnc_set;

_dict
