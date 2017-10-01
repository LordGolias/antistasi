// uniforms that allow the player to stay undercover
AS_FIAuniforms_undercover = [
	"U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped",
	"U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite",
	"U_C_Commoner1_1","U_C_Commoner1_2","U_C_Commoner1_3","U_Rangemaster",
	"U_C_Poor_1","U_C_Poor_2","U_C_WorkerCoveralls",
	"U_C_Poor_shorts_1","U_C_Commoner_shorts","U_C_ShirtSurfer_shorts",
	"U_C_TeeSurfer_shorts_1","U_C_TeeSurfer_shorts_2"
];

AS_FIAhelmets_undercover = [
	"H_Booniehat_khk", "H_Booniehat_oli", "H_Booniehat_grn",
	"H_Booniehat_dirty", "H_Cap_oli", "H_Cap_blk", "H_MilCap_rucamo",
	"H_MilCap_gry", "H_BandMask_blk",
	"H_Bandanna_khk", "H_Bandanna_gry",
	"H_Bandanna_camo", "H_Shemag_khk", "H_Shemag_tan",
	"H_Shemag_olive", "H_ShemagOpen_tan", "H_Beret_grn", "H_Beret_grn_SF",
	"H_Watchcap_camo", "H_TurbanO_blk", "H_Hat_camo", "H_Hat_tan",
	"H_Beret_blk", "H_Beret_red",
	"H_Beret_02", "H_Watchcap_khk"
];

AS_FIAvests_undercover = [
	"V_BandollierB_oli"
];

AS_FIAgoogles_undercover = [
	"G_Balaclava_blk",
	"G_Balaclava_combat",
	"G_Balaclava_lowprofile",
	"G_Balaclava_oli",
	"G_Bandanna_beast",
	"G_Tactical_Black",
	"G_Aviator",
	"G_Shades_Black"
];

AS_FIAuniforms = [
	"U_IG_Guerilla1_1",
	"U_IG_Guerilla2_1",
	"U_IG_Guerilla2_2",
	"U_IG_Guerilla2_3",
	"U_IG_Guerilla3_1",
	"U_IG_Guerilla3_2",
	"U_IG_leader",
	"U_BG_Guerilla1_1",
	"U_BG_Guerilla2_2",
	"U_BG_Guerilla2_3",
	"U_BG_Guerilla3_1",
	"U_BG_Guerilla3_2",
	"U_BG_leader",
	"U_OG_Guerilla1_1",
	"U_OG_Guerilla2_1",
	"U_OG_Guerilla2_2",
	"U_OG_Guerilla2_3",
	"U_OG_Guerilla3_1",
	"U_OG_Guerilla3_2",
	"U_OG_leader"
];

// maps unit classes to AS unit types.
// The different AS types are used to equip from the arsenal.
// For example, "Sniper" favours high-zoom scopes, "Rifleman" favours broad zoom (high zoom AND low zoom)
// Another example: "Medic" takes a bag full of meds from the arsenal
// 	To modders: this needs to be a list of pairs (i,i+1) where the first item
// 	is the unit class, and the second item is the AS type.
AS_FIAsoldiersMapping = [
    "B_G_Soldier_F", "Rifleman",
    "B_G_Soldier_GL_F", "Grenadier",
    "B_G_medic_F", "Medic",
    "B_G_Soldier_AR_F", "Autorifleman",
    "B_G_Soldier_SL_F", "Squad Leader",
    "B_G_officer_F", "Rifleman",
    "B_G_Soldier_TL_F", "Rifleman",
    "B_G_Soldier_LAT_F", "AT Specialist",
    "B_G_Soldier_M_F", "Sniper",
	"B_G_Sharpshooter_F", "Sniper",
    "B_G_engineer_F", "Repair Specialist",
    "B_G_Soldier_LAT_F", "AA Specialist",  // AA specialist is spawned as B_G_Soldier_LAT_F
    "B_G_Soldier_exp_F", "Explosives Specialist",
    "B_G_Soldier_A_F", "Ammo Bearer",
    "B_G_Soldier_lite_F", "Crew",
    "B_G_Survivor_F", "Survivor"
];

AS_FIA_vans = ["C_Van_01_box_F"];

// maps standard classes to AS squad types.
// 	To modders: squad types are 1) recruitable and 2) spawned in cities, etc.
AS_FIAsquadsMapping = [
    "IRG_InfSquad", "Infantry Squad",
    "IRG_InfTeam", "Infantry Team",
    "IRG_InfTeam_AT", "AT Team",
    "IRG_SniperTeam_M", "Sniper Team",
    "IRG_InfSentry", "Sentry Team"
];

// squads that require custom initialization
AS_FIACustomSquad_types = ["Mobile AA", "Mobile AT", "Mobile Mortar"];

AS_fnc_FIACustomSquad_piece = {
	params ["_squadType"];
	if (_squadType == "Mobile AA") exitWith {"B_static_AA_F"};
	if (_squadType == "Mobile AT") exitWith {"B_static_AT_F"};
	if (_squadType == "Mobile Mortar") exitWith {"B_G_Mortar_01_F"};
};

AS_fnc_FIACustomSquad_cost = {
	params ["_squadType"];
	private _cost = 2*(AS_data_allCosts getVariable "Crew");
	private _costHR = 2;
	_cost = _cost + ([[_squadType] call AS_fnc_FIACustomSquad_piece] call AS_fnc_getFIAvehiclePrice) + (["B_G_Van_01_transport_F"] call AS_fnc_getFIAvehiclePrice);
	[_costHR, _cost]
};

AS_fnc_FIACustomSquad_initialization = {
	params ["_squadType", "_position"];
	private _pos = _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
    private _veh = [_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
	private _camion = _veh select 0;
	private _grupo = _veh select 2;
	_grupo setVariable ["staticAutoT", false, true];
	private _piece = ([_squadType] call AS_fnc_FIACustomSquad_piece) createVehicle (_position findEmptyPosition [1,30,"B_G_Van_01_transport_F"]);
	private _morty = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"], [], 0, "NONE"];

	if (_squadType == "Mobile Mortar") then {
		_morty moveInGunner _piece;
		_piece setVariable ["attachPoint", [0,-1.5,0.2]];
		[_morty,_camion,_piece] spawn AS_fnc_activateMortarCrewOnTruck;
	} else {
		_piece attachTo [_camion,[0,-1.5,0.2]];
		_piece setDir (getDir _camion + 180);
		_morty moveInGunner _piece;
	};
	[_camion, "FIA"] call AS_fnc_initVehicle;
	[_piece, "FIA"] call AS_fnc_initVehicle;
	_grupo
};

if (isServer) then {
	// The cost of each AS unit type. Squad cost also depends on this
	AS_data_allCosts setVariable ["Crew", 50, true];
	AS_data_allCosts setVariable ["Ammo Bearer", 50, true];
	AS_data_allCosts setVariable ["Rifleman", 50, true];
	AS_data_allCosts setVariable ["Grenadier", 100, true];
	AS_data_allCosts setVariable ["Autorifleman", 100, true];
	AS_data_allCosts setVariable ["Medic", 300, true];
	AS_data_allCosts setVariable ["Squad Leader", 100, true];
	AS_data_allCosts setVariable ["Repair Specialist", 200, true];
	AS_data_allCosts setVariable ["Explosives Specialist", 200, true];
	AS_data_allCosts setVariable ["AT Specialist", 200, true];
	AS_data_allCosts setVariable ["AA Specialist", 300, true];
	AS_data_allCosts setVariable ["Sniper", 100, true];
};

AS_FIAvehicles setVariable ["land_vehicles", [
	"C_Offroad_01_F","C_Van_01_transport_F","B_G_Quadbike_01_F","B_G_Offroad_01_armed_F",
	"B_HMG_01_high_F","B_G_Mortar_01_F","B_static_AT_F","B_static_AA_F"
]];
AS_FIAvehicles setVariable ["water_vehicles", [
	"B_G_Boat_Transport_01_F"
]];
// First helicopter of this list is undercover
AS_FIAvehicles setVariable ["air_vehicles", [
	"C_Heli_Light_01_civil_F"
]];

// All elements in the lists above must be priced
AS_FIAvehicles setVariable ["C_Offroad_01_F", 300];
AS_FIAvehicles setVariable ["C_Van_01_transport_F", 600];
AS_FIAvehicles setVariable ["B_G_Quadbike_01_F", 50];
AS_FIAvehicles setVariable ["B_G_Offroad_01_armed_F", 700];
AS_FIAvehicles setVariable ["B_HMG_01_high_F", 800];
AS_FIAvehicles setVariable ["B_G_Mortar_01_F", 800];
AS_FIAvehicles setVariable ["B_static_AT_F", 800];
AS_FIAvehicles setVariable ["B_static_AA_F", 800];
AS_FIAvehicles setVariable ["B_G_Boat_Transport_01_F", 400];
AS_FIAvehicles setVariable ["C_Heli_Light_01_civil_F", 6000];
