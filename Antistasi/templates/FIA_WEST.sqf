private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str west] call DICT_fnc_setLocal;
[_dict, "roles", ["anti_state"]] call DICT_fnc_setLocal;
[_dict, "name", "FIA"] call DICT_fnc_setLocal;
[_dict, "flag", "Flag_FIA_F"] call DICT_fnc_setLocal;

[_dict, "vests", ["V_BandollierB_oli"]] call DICT_fnc_setLocal;

[_dict, "googles", [
	"G_Balaclava_blk",
	"G_Balaclava_combat",
	"G_Balaclava_lowprofile",
	"G_Balaclava_oli",
	"G_Bandanna_beast",
	"G_Tactical_Black",
	"G_Aviator",
	"G_Shades_Black"]
] call DICT_fnc_setLocal;

[_dict, "uniforms", [
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
	"U_OG_leader"]
] call DICT_fnc_setLocal;

[_dict, "helmets", [
	"H_Booniehat_khk", "H_Booniehat_oli", "H_Booniehat_grn",
	"H_Booniehat_dirty", "H_Cap_oli", "H_Cap_blk", "H_MilCap_rucamo",
	"H_MilCap_gry", "H_BandMask_blk",
	"H_Bandanna_khk", "H_Bandanna_gry",
	"H_Bandanna_camo", "H_Shemag_khk", "H_Shemag_tan",
	"H_Shemag_olive", "H_ShemagOpen_tan", "H_Beret_grn", "H_Beret_grn_SF",
	"H_Watchcap_camo", "H_TurbanO_blk", "H_Hat_camo", "H_Hat_tan",
	"H_Beret_blk", "H_Beret_red",
	"H_Beret_02", "H_Watchcap_khk"]
] call DICT_fnc_setLocal;

[_dict, "unlockedWeapons", [
	"hgun_PDW2000_F",
	"hgun_ACPC2_F"]
] call DICT_fnc_setLocal;

[_dict, "unlockedMagazines", [
	"9Rnd_45ACP_Mag",
	"30Rnd_9x21_Mag"]
] call DICT_fnc_setLocal;

[_dict, "unlockedBackpacks", ["B_TacticalPack_blk"]] call DICT_fnc_setLocal;

[_dict, "soldier", "B_G_Soldier_F"] call DICT_fnc_setLocal;
[_dict, "crew", "B_G_Soldier_lite_F"] call DICT_fnc_setLocal;
[_dict, "survivor", "B_G_Survivor_F"] call DICT_fnc_setLocal;
[_dict, "engineer", "B_G_engineer_F"] call DICT_fnc_setLocal;
[_dict, "medic", "B_G_medic_F"] call DICT_fnc_setLocal;

[_dict, "vans", ["C_Van_01_box_F"]] call DICT_fnc_setLocal;

[_dict, "squad", [
	"Squad Leader", "Medic", "AT Specialist", "Autorifleman", "Grenadier", "Rifleman", "Rifleman", "Rifleman"
]] call DICT_fnc_setLocal;
[_dict, "team", ["Squad Leader", "Medic", "Grenadier", "Rifleman"]] call DICT_fnc_setLocal;
[_dict, "team_at", ["AT Specialist", "AT Specialist"]] call DICT_fnc_setLocal;
[_dict, "team_sniper", ["Rifleman", "Sniper"]] call DICT_fnc_setLocal;
[_dict, "team_patrol", ["Rifleman", "Grenadier"]] call DICT_fnc_setLocal;

[_dict, "squads", ["squad", "team", "team_at", "team_sniper", "team_patrol", "mobile_aa", "mobile_at", "mobile_mortar"]] call DICT_fnc_setLocal;
[_dict, "squad_names", ["Squad", "Team", "AT Team", "Sniper Team", "Patrol", "Mobile AA", "Mobile AT", "Mobile Mortar"]] call DICT_fnc_setLocal;

[_dict, "squads_custom", ["mobile_aa", "mobile_at", "mobile_mortar"]] call DICT_fnc_setLocal;
[_dict, "squads_custom_cost", {
	params ["_squadType"];
	private _pieceType = call {
		if (_squadType == "mobile_aa") exitWith {["FIA", "static_aa"] call AS_fnc_getEntity};
		if (_squadType == "mobile_at") exitWith {["FIA", "static_at"] call AS_fnc_getEntity};
		if (_squadType == "mobile_mortar") exitWith {["FIA", "static_mortar"] call AS_fnc_getEntity};
	};
	private _cost = 2*(AS_data_allCosts getVariable "Crew");
	private _costHR = 2;
	_cost = _cost + (_pieceType call AS_fnc_getFIAvehiclePrice) +
		(["B_G_Van_01_transport_F"] call AS_fnc_getFIAvehiclePrice);
	[_costHR, _cost]
}] call DICT_fnc_setLocal;

[_dict, "squads_custom_init", {
	params ["_squadType", "_position"];
	private _pos = _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
    private _veh = [_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
	private _camion = _veh select 0;
	private _grupo = _veh select 2;
	_grupo setVariable ["staticAutoT", false, true];
	private _pieceType = call {
		if (_squadType == "mobile_aa") exitWith {["FIA", "static_aa"] call AS_fnc_getEntity};
		if (_squadType == "mobile_at") exitWith {["FIA", "static_at"] call AS_fnc_getEntity};
		if (_squadType == "mobile_mortar") exitWith {["FIA", "static_mortar"] call AS_fnc_getEntity};
	};

	private _piece = _pieceType createVehicle (_position findEmptyPosition [1,30,"B_G_Van_01_transport_F"]);
	private _morty = _grupo createUnit [["FIA", "crew"] call AS_fnc_getEntity, _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"], [], 0, "NONE"];

	if (_squadType == "mobile_mortar") then {
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
}] call DICT_fnc_setLocal;

[_dict, "static_aa", "B_static_AA_F"] call DICT_fnc_setLocal;
[_dict, "static_at", "B_static_AT_F"] call DICT_fnc_setLocal;
[_dict, "static_mg", "B_HMG_01_high_F"] call DICT_fnc_setLocal;
[_dict, "static_mortar", "B_G_Mortar_01_F"] call DICT_fnc_setLocal;

// FIA minefield uses first of this list
[_dict, "land_vehicles", ["C_Offroad_01_F","C_Van_01_transport_F","B_G_Quadbike_01_F","B_G_Offroad_01_armed_F"]] call DICT_fnc_setLocal;
[_dict, "water_vehicles", ["B_G_Boat_Transport_01_F"]] call DICT_fnc_setLocal;
// First helicopter of this list is undercover
[_dict, "air_vehicles", ["C_Heli_Light_01_civil_F"]] call DICT_fnc_setLocal;

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

_dict
