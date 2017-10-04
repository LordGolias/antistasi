private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

bluHeliTrans = ["CUP_B_CH53E_USMC", "CUP_B_UH1Y_UNA_USMC"];
bluHeliTS = ["CUP_B_UH1Y_UNA_USMC"];
bluHeliDis = ["CUP_B_CH53E_USMC"];
bluHeliRope = ["CUP_B_CH53E_USMC"];
bluHeliArmed = ["CUP_B_UH1Y_Gunship_Dynamic_USMC", "CUP_B_MH60L_DAP_2x_AT_USN", "CUP_B_MH60L_DAP_2x_Escort_USN", "CUP_B_MH60L_DAP_2x_Multi_USN"];
bluHeliGunship = ["CUP_B_AH1Z_Dynamic_USMC"];
bluCASFW = ["CUP_B_F35B_CAS_USMC"];

bluUAV = ["CUP_B_USMC_MQ9"];

planesNATO = bluHeliTrans + bluHeliArmed + bluHeliGunship + bluCASFW;
planesNATOTrans = bluHeliTrans;

[_dict, "mbts", ["CUP_B_M1A1_DES_USMC", "CUP_B_M1A2_TUSK_MG_DES_USMC"]] call DICT_fnc_setLocal;

[_dict, "trucks", ["CUP_B_MTVR_USMC"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["CUP_B_LAV25M240_desert_USMC", "CUP_B_LAV25_desert_USMC"]] call DICT_fnc_setLocal;

[_dict, "artillery1", ["CUP_B_M270_HE_USMC"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["UP_B_M270_DPICM_USMC"]] call DICT_fnc_setLocal;

[_dict, "other_vehicles", [
"B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F",
"B_MRAP_01_F", "B_MRAP_01_hmg_F",
"B_Truck_01_medical_F", "B_Truck_01_fuel_F"
]] call DICT_fnc_setLocal;

[_dict, "other_vehicles", [
"CUP_B_HMMWV_Unarmed_USMC","rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy",
"CUP_B_HMMWV_Ambulance_USMC","CUP_B_MTVR_Refuel_USMC"
]] call DICT_fnc_setLocal;

bluStatAA = ["CUP_B_TOW_TriPod_USMC"];
bluStatAT = ["CUP_B_TOW_TriPod_USMC"];
bluStatHMG = ["CUP_B_M2StaticMG_USMC"];
bluStatMortar = ["CUP_B_M252_USMC"];

[_dict, "gunner", "CUP_B_USMC_Crew"] call DICT_fnc_setLocal;
[_dict, "crew", "CUP_B_USMC_Crew"] call DICT_fnc_setLocal;
[_dict, "pilot", "CUP_B_USMC_Pilot"] call DICT_fnc_setLocal;

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
