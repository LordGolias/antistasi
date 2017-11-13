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

bluMBT = ["CUP_B_M1A1_DES_USMC", "CUP_B_M1A2_TUSK_MG_DES_USMC"];
bluAPC = ["CUP_B_LAV25M240_desert_USMC", "CUP_B_LAV25_desert_USMC"];
bluIFV = ["CUP_B_AAV_USMC"];
bluIFVAA = ["CUP_B_HMMWV_Avenger_USMC"];
bluArty = ["CUP_B_M270_DPICM_USMC", "CUP_B_M270_HE_USMC"];
bluMLRS = ["CUP_B_M270_DPICM_USMC", "CUP_B_M270_HE_USMC"];
bluMRAP = ["CUP_B_HMMWV_Unarmed_USMC"];
bluMRAPHMG = ["CUP_B_HMMWV_M1114_USMC"];
bluTruckTP = ["CUP_B_MTVR_USMC"];
bluTruckMed = ["CUP_B_HMMWV_Ambulance_USMC"];
bluTruckFuel = ["CUP_B_MTVR_Refuel_USMC"];

vehNATO = bluMBT + bluAPC + bluIFV + bluIFVAA + bluArty + bluMLRS + bluMRAP + bluMRAPHMG + bluTruckTP + bluTruckMed + bluTruckFuel;

bluStatAA = ["CUP_B_TOW_TriPod_USMC"];
bluStatAT = ["CUP_B_TOW_TriPod_USMC"];
bluStatHMG = ["CUP_B_M2StaticMG_USMC"];
bluStatMortar = ["CUP_B_M252_USMC"];

// Soldiers
bluPilot = "CUP_B_USMC_Pilot";
bluCrew = "CUP_B_USMC_Crew";
bluGunner = "CUP_B_USMC_Crew";
bluMRAPHMGgroup = ["CUP_B_USMC_Soldier","CUP_B_USMC_Soldier"];
bluMRAPgroup = ["CUP_B_USMC_Medic","CUP_B_USMC_Officer","CUP_B_USMC_Soldier"];
bluAirCav = ["CUP_B_USMC_Officer","CUP_B_USMC_Medic","CUP_B_USMC_Soldier","CUP_B_USMC_Soldier_GL","CUP_B_USMC_Soldier_HAT","CUP_B_USMC_Soldier_Marksman", "CUP_B_USMC_Soldier_AR"];

// groups that are spawned
NATOConfigGroupInf = (configfile >> "CfgGroups" >> "West" >> "CUP_B_USMC" >> "Infantry");
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
