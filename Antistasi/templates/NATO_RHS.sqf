private _dict = [AS_entities, "NATO"] call DICT_fnc_get;

[_dict, "helis_paradrop", ["RHS_MELB_MH6M"]] call DICT_fnc_setLocal;
[_dict, "helis_land", ["RHS_UH60M_d"]] call DICT_fnc_setLocal;
[_dict, "helis_fastrope", ["RHS_CH_47F_light"]] call DICT_fnc_setLocal;

[_dict, "helis_attack", ["RHS_AH64D_AA","RHS_AH64D_GS","RHS_AH64D"]] call DICT_fnc_setLocal;
[_dict, "helis_armed", ["RHS_MELB_AH6M_H","RHS_MELB_AH6M_M"]] call DICT_fnc_setLocal;
[_dict, "planes", ["RHS_A10"]] call DICT_fnc_setLocal;

bluUAV = ["B_UAV_02_F"];

[_dict, "mbts", ["rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy"]] call DICT_fnc_setLocal;

[_dict, "trucks", ["rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy"]] call DICT_fnc_setLocal;
[_dict, "apcs", ["RHS_M2A3","RHS_M2A3_BUSKI"]] call DICT_fnc_setLocal;

[_dict, "artillery1", ["RHS_M119_D"]] call DICT_fnc_setLocal;
[_dict, "artillery2", ["RHS_M119_D"]] call DICT_fnc_setLocal;

[_dict, "other_vehicles", [
"rhsusf_m113d_usarmy_supply",
"rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy",
"rhsusf_M978A4_BKIT_usarmy_d"
]] call DICT_fnc_setLocal;

bluStatAA = ["RHS_Stinger_AA_pod_D"];
bluStatAT = ["RHS_TOW_TriPod_D"];
bluStatHMG = ["RHS_M2StaticMG_D"];
bluStatMortar = ["RHS_M252_D"];

[_dict, "gunner", "rhsusf_usmc_marpat_d_rifleman_light"] call DICT_fnc_setLocal;
[_dict, "crew", "rhsusf_usmc_marpat_d_crewman"] call DICT_fnc_setLocal;
[_dict, "pilot", "rhsusf_army_ocp_helipilot"] call DICT_fnc_setLocal;

[_dict, "cfgGroups", (configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry")] call DICT_fnc_setLocal;

bluAirCav = ["rhsusf_usmc_recon_marpat_d_teamleader_fast","rhsusf_usmc_recon_marpat_d_marksman_fast","rhsusf_usmc_recon_marpat_d_autorifleman_fast","rhsusf_usmc_recon_marpat_d_rifleman_at_fast","rhsusf_usmc_recon_marpat_d_rifleman_fast","rhsusf_usmc_recon_marpat_d_machinegunner_m249_fast"];

bluSquad = ["rhs_group_nato_usmc_d_infantry_squad"];
bluSquadWeapons = ["rhs_group_nato_usmc_d_infantry_weaponsquad"];
bluTeam = ["rhs_group_nato_usmc_d_infantry_team"];
bluATTeam = ["rhs_group_nato_usmc_d_infantry_team_heavy_AT"];

bluIR = "rhsusf_acc_anpeq15";

bluFlag = "Flag_US_F";
AS_NATOname = "USMC";

blu40mm = [
"rhs_mag_M433_HEDP",
"1Rnd_HE_Grenade_shell",
"SmokeShell",
"SmokeShellGreen",
"rhs_mag_m576"
];

bluAT = [
"rhs_weap_smaw_optic",
"rhs_weap_M136_hedp"
];

bluAA = [
"rhs_weap_fim92"
];

genATLaunchers = genATLaunchers + bluAT;
genAALaunchers = genAALaunchers + bluAA;
