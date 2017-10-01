// clean everything because we do not need the default stuff
{AS_FIAvehicles setVariable [_x, nil];} forEach (allVariables AS_FIAvehicles);

AS_FIAvehicles setVariable ["land_vehicles", [
	"CUP_C_UAZ_Unarmed_TK_CIV",
	"CUP_C_LR_Transport_CTK",
	"CUP_C_V3S_Open_TKC",
	"CUP_I_Datsun_PK",
	statMG, statMortar, statAT, statAA
]];
AS_FIAvehicles setVariable ["CUP_C_UAZ_Unarmed_TK_CIV", 300];
AS_FIAvehicles setVariable ["CUP_C_LR_Transport_CTK", 300];
AS_FIAvehicles setVariable ["CUP_C_V3S_Open_TKC", 600];
AS_FIAvehicles setVariable ["CUP_I_Datsun_PK", 700];
AS_FIAvehicles setVariable [statMG, 800];
AS_FIAvehicles setVariable [statMortar, 800];
AS_FIAvehicles setVariable [statAT, 800];
AS_FIAvehicles setVariable [statAA, 800];

AS_FIAvehicles setVariable ["water_vehicles", ["B_G_Boat_Transport_01_F"]];
AS_FIAvehicles setVariable ["B_G_Boat_Transport_01_F", 400];

// First helicopter of this list is undercover
AS_FIAvehicles setVariable ["air_vehicles", ["CUP_B_MH6J_OBS_USA"]];
AS_FIAvehicles setVariable ["CUP_B_MH6J_OBS_USA", 6000];

AS_FIA_vans = ["CUP_C_LR_Transport_CTK"];
