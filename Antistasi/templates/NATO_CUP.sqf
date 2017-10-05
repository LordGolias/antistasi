private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["CUP_B_UH1Y_UNA_USMC"]] call DICT_fnc_setLocal;
[_dict, "helis_land", ["CUP_B_CH53E_USMC"]] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", []] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["CUP_B_AH1Z_Dynamic_USMC"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["CUP_B_UH1Y_Gunship_Dynamic_USMC", "CUP_B_MH60L_DAP_2x_AT_USN", "CUP_B_MH60L_DAP_2x_Escort_USN", "CUP_B_MH60L_DAP_2x_Multi_USN"]] call DICT_fnc_setLocal;
[_dict, "planes", ["CUP_B_F35B_CAS_USMC"]] call DICT_fnc_setLocal;

[_dict, "uavs_small", []] call DICT_fnc_setLocal;
[_dict, "uavs_attack", ["CUP_B_USMC_MQ9"]] call DICT_fnc_setLocal;

[_dict, "mbts", ["CUP_B_M1A1_DES_USMC", "CUP_B_M1A2_TUSK_MG_DES_USMC"]] call DICT_fnc_setLocal;

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

bluStatAA = ["CUP_B_TOW_TriPod_USMC"];
bluStatAT = ["CUP_B_TOW_TriPod_USMC"];
bluStatHMG = ["CUP_B_M2StaticMG_USMC"];
bluStatMortar = ["CUP_B_M252_USMC"];

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "CUP_B_USMC" >> "Infantry")] call DICT_fnc_setLocal;

bluAirCav = ["CUP_B_USMC_Officer","CUP_B_USMC_Medic","CUP_B_USMC_Soldier","CUP_B_USMC_Soldier_GL","CUP_B_USMC_Soldier_HAT","CUP_B_USMC_Soldier_Marksman", "CUP_B_USMC_Soldier_AR"];

// groups that are spawned
bluSquad = ["CUP_B_USMC_InfSquad"];
bluSquadWeapons = ["CUP_B_USMC_InfSquad"];
bluTeam = ["CUP_B_USMC_FireTeam"];
bluATTeam = ["CUP_B_USMC_HeavyATTeam"];

bluIR = "acc_pointer_IR";

bluFlag = "Flag_US_F";
AS_NATOname = "USMC";

bluAT = [
    "CUP_Weapon_launch_Javelin",
    "CUP_Weapon_launch_M136",
    "CUP_Weapon_launch_NLAW"
];

bluAA = [
    "CUP_Weapon_launch_FIM92Stinger"
];
