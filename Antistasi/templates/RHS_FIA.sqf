// clean everything because we do not need the default stuff
if (isServer) then {
	{AS_FIArecruitment setVariable [_x, nil, true];} forEach (allVariables AS_FIArecruitment);
};

// todo: transform this list into the lists below
private _vehFIA = [
	"C_Offroad_01_F",
	"C_Van_01_transport_F",
	"RHS_Mi8amt_civilian",
	"B_G_Quadbike_01_F",
	"rhs_uaz_open_MSV_01",
	"rhs_gaz66o_msv",
	"B_G_Offroad_01_armed_F",
	"rhs_DSHKM_ins",
	"rhs_2b14_82mm_msv",
	"rhs_Metis_9k115_2_vdv",
	"RHS_ZU23_VDV",
	"rhs_bmd1_chdkz",
	"rhs_gaz66_r142_vdv"
];

if (isServer) then {
	AS_FIArecruitment setVariable ["land_vehicles", [
		"C_Offroad_01_F","C_Van_01_transport_F","B_G_Quadbike_01_F",
		"rhs_uaz_open_MSV_01",
		"B_G_Offroad_01_armed_F",
		"B_HMG_01_high_F","B_G_Mortar_01_F","B_static_AT_F","B_static_AA_F"
	], true];

	// All elements in the lists above must be priced below or their price is 300
	AS_FIArecruitment setVariable ["C_Offroad_01_F", 300, true];
	AS_FIArecruitment setVariable ["C_Van_01_transport_F", 600, true];
	AS_FIArecruitment setVariable ["B_G_Quadbike_01_F", 50, true];
	AS_FIArecruitment setVariable ["rhs_uaz_open_MSV_01", 600, true];
	AS_FIArecruitment setVariable ["B_G_Offroad_01_armed_F", 700, true];
	AS_FIArecruitment setVariable ["B_HMG_01_high_F", 800, true];
	AS_FIArecruitment setVariable ["B_G_Mortar_01_F", 800, true];
	AS_FIArecruitment setVariable ["B_static_AT_F", 800, true];
	AS_FIArecruitment setVariable ["B_static_AA_F", 800, true];

	AS_FIArecruitment setVariable ["water_vehicles", ["B_G_Boat_Transport_01_F"], true];
	AS_FIArecruitment setVariable ["B_G_Boat_Transport_01_F", 400, true];

	// First helicopter of this list is undercover
	AS_FIArecruitment setVariable ["air_vehicles", ["rhs_Mi8amt_civilian"], true];
	AS_FIArecruitment setVariable ["rhs_Mi8amt_civilian", 6000, true];
};
