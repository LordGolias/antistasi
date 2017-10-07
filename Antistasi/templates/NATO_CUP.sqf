private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

[_dict, "helis_transport", ["CUP_B_UH1Y_UNA_USMC", "CUP_B_CH53E_USMC"]] call DICT_fnc_setLocal;
[_dict, "helis_attack", ["CUP_B_AH1Z_Dynamic_USMC"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["CUP_B_UH1Y_Gunship_Dynamic_USMC", "CUP_B_MH60L_DAP_2x_AT_USN", "CUP_B_MH60L_DAP_2x_Escort_USN", "CUP_B_MH60L_DAP_2x_Multi_USN"]] call DICT_fnc_setLocal;
[_dict, "planes", ["CUP_B_F35B_CAS_USMC"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", []] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["CUP_B_USMC_MQ9"]] call DICT_fnc_setLocal;

[_dict, "tanks", ["CUP_B_M1A1_DES_USMC", "CUP_B_M1A2_TUSK_MG_DES_USMC"]] call DICT_fnc_setLocal;

// used in roadblock mission
[_dict, "trucks", ["CUP_B_MTVR_USMC"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["CUP_B_LAV25M240_desert_USMC", "CUP_B_LAV25_desert_USMC"]] call DICT_fnc_setLocal;

// used in traitor mission
[_dict, "cars", ["CUP_B_HMMWV_Unarmed_USMC"]] call DICT_fnc_setLocal;

// used in artillery mission
[_dict, "artillery1", ["CUP_B_M270_HE_USMC"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["UP_B_M270_DPICM_USMC"]] call DICT_fnc_setLocal;

// used in spawns (base and airfield)
[_dict, "other_vehicles", [
"CUP_B_MTVR_Ammo_USMC","CUP_B_MTVR_Refuel_USMC", "CUP_B_HMMWV_Ambulance_USMC", "CUP_B_MTVR_Repair_USMC"
]] call DICT_fnc_setLocal;

[_dict, "self_aa", ["CUP_B_HMMWV_Avenger_USMC"]] call DICT_fnc_setLocal;

// special units used in special occasions
[_dict, "officer", "CUP_B_USMC_Officer"] call DICT_fnc_setLocal;
[_dict, "traitor", "CUP_B_USMC_Officer"] call DICT_fnc_setLocal;
[_dict, "gunner", "CUP_B_USMC_Crew"] call DICT_fnc_setLocal;
[_dict, "crew", "CUP_B_USMC_Crew"] call DICT_fnc_setLocal;
[_dict, "pilot", "CUP_B_USMC_Pilot"] call DICT_fnc_setLocal;

[_dict, "static_aa", ""] call DICT_fnc_setLocal;
[_dict, "static_at", "CUP_B_TOW_TriPod_USMC"] call DICT_fnc_setLocal;
[_dict, "static_mg", "CUP_B_M2StaticMG_USMC"] call DICT_fnc_setLocal;
[_dict, "static_mg_low", "CUP_B_M2StaticMG_MiniTripod_USMC"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "CUP_B_M252_USMC"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "CUP_B_USMC" >> "Infantry")] call DICT_fnc_setLocal;
[_dict, "squads", ["CUP_B_USMC_InfSquad"]] call DICT_fnc_setLocal;
[_dict, "teams", ["CUP_B_USMC_FireTeam"]] call DICT_fnc_setLocal;
[_dict, "recon_squad", "CUP_B_USMC_FRTeam"] call DICT_fnc_setLocal;
[_dict, "recon_team", "CUP_B_USMC_FRTeam"] call DICT_fnc_setLocal;

[_dict, "name", "USMC"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_US_F"] call DICT_fnc_setLocal;
[_dict, "box", "Box_NATO_Equip_F"] call DICT_fnc_setLocal;
