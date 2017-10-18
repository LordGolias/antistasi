// clean everything because we do not need the default stuff
if (isServer) then {
	{AS_FIArecruitment setVariable [_x, nil, true];} forEach (allVariables AS_FIArecruitment);
};

if (isServer) then {
	AS_FIArecruitment setVariable ["land_vehicles", [
		"CUP_C_UAZ_Unarmed_TK_CIV",
		"CUP_C_LR_Transport_CTK",
		"CUP_C_V3S_Open_TKC",
		"CUP_I_Datsun_PK",
		statMG, statMortar, statAT, statAA
	], true];
	AS_FIArecruitment setVariable ["CUP_C_UAZ_Unarmed_TK_CIV", 300, true];
	AS_FIArecruitment setVariable ["CUP_C_LR_Transport_CTK", 300, true];
	AS_FIArecruitment setVariable ["CUP_C_V3S_Open_TKC", 600, true];
	AS_FIArecruitment setVariable ["CUP_I_Datsun_PK", 700, true];
	AS_FIArecruitment setVariable [statMG, 800, true];
	AS_FIArecruitment setVariable [statMortar, 800, true];
	AS_FIArecruitment setVariable [statAT, 800, true];
	AS_FIArecruitment setVariable [statAA, 800, true];

	AS_FIArecruitment setVariable ["water_vehicles", ["B_G_Boat_Transport_01_F"], true];
	AS_FIArecruitment setVariable ["B_G_Boat_Transport_01_F", 400, true];

	// First helicopter of this list is undercover
	AS_FIArecruitment setVariable ["air_vehicles", ["CUP_B_MH6J_OBS_USA"], true];
	AS_FIArecruitment setVariable ["CUP_B_MH6J_OBS_USA", 6000, true];
};

AS_FIA_vans = ["CUP_C_LR_Transport_CTK"];
