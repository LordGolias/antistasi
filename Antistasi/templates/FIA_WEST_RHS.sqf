private _dict = ([AS_entities, "FIA_WEST"] call DICT_fnc_get) call DICT_fnc_copy;
[_dict, "side", str west] call DICT_fnc_set;
[_dict, "name", "CGF (RHS)"] call DICT_fnc_set;
[_dict, "flag", "Flag_FIA_F"] call DICT_fnc_set;

[_dict, "soldier", "rhsgref_cdf_b_reg_rifleman"] call DICT_fnc_set;
[_dict, "crew", "rhsgref_cdf_b_reg_crew"] call DICT_fnc_set;
[_dict, "survivor", "rhsgref_cdf_b_reg_rifleman"] call DICT_fnc_set;
[_dict, "engineer", "rhsgref_cdf_b_reg_enginner"] call DICT_fnc_set;
[_dict, "medic", "rhsgref_cdf_b_reg_medic"] call DICT_fnc_set;

[_dict, "unlockedWeapons", ["rhs_weap_makarov_pm","rhs_weap_aks74u"]] call DICT_fnc_set;

[_dict, "unlockedMagazines", ["rhs_mag_9x18_8_57N181S","rhs_30Rnd_545x39_AK","rhs_mag_rdg2_white"]] call DICT_fnc_set;

[_dict, "unlockedBackpacks", ["rhs_assault_umbts"]] call DICT_fnc_set;

[_dict, "vans", ["rhs_Ural_Open_Civ_01", "rhs_Ural_Open_Civ_02", "rhs_Ural_Open_Civ_03"]] call DICT_fnc_set;

[_dict, "static_aa", "RHS_Stinger_AA_pod_D"] call DICT_fnc_set;
[_dict, "static_at", "RHS_TOW_TriPod_D"] call DICT_fnc_set;
[_dict, "static_mg", "RHS_M2StaticMG_D"] call DICT_fnc_set;
[_dict, "static_mortar", "RHS_M252_D"] call DICT_fnc_set;

[_dict, "squads_custom_cost", {
	params ["_squadType"];
	private _cost = 0;
	private _costHR = 0;
	if (_squadType == "mobile_aa") then {
		_costHR = 3;
		_cost = _costHR*("Crew" call AS_fnc_getCost) +
			    (["rhsgref_cdf_b_gaz66_zu23"] call AS_fnc_getFIAvehiclePrice);
	} else {
		_costHR = 2;
		private _piece = call {
			if (_squadType == "mobile_at") exitWith {["FIA", "static_at"] call AS_fnc_getEntity};
			if (_squadType == "mobile_mortar") exitWith {["FIA", "static_mortar"] call AS_fnc_getEntity};
		};
		_cost = _costHR*("Crew" call AS_fnc_getCost) +
				(["B_G_Van_01_transport_F"] call AS_fnc_getFIAvehiclePrice) +
				(_piece call AS_fnc_getFIAvehiclePrice);
	};
	[_costHR, _cost]
}] call DICT_fnc_set;

[_dict, "squads_custom_init", {
	params ["_squadType", "_position"];
	private _grupo = grpNull;

	if (_squadType == "mobile_aa") then {
		private _pos = _position findEmptyPosition [1,30,"rhsgref_cdf_b_gaz66_zu23"];
		private _vehicle = [_pos, 0, "rhsgref_cdf_b_gaz66_zu23", side_blue] call bis_fnc_spawnvehicle;
		private _veh = _vehicle select 0;
		private _vehCrew = _vehicle select 1;
		{deleteVehicle _x} forEach crew _veh;
		_grupo = _vehicle select 2;
		[_veh, "FIA"] call AS_fnc_initVehicle;
		private _driv = _grupo createUnit [["FIA", "crew"] call AS_fnc_getEntity, _pos, [],0, "NONE"];
		_driv moveInDriver _veh;
		private _gun = _grupo createUnit [["FIA", "crew"] call AS_fnc_getEntity, _pos, [],0, "NONE"];
		_gun moveInGunner _veh;
		private _com = _grupo createUnit [["FIA", "crew"] call AS_fnc_getEntity, _pos, [],0, "NONE"];
		_com moveInCommander _veh;
	} else {
		private _pos = _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
		private _vehicleData = [_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
		private _camion = _vehicleData select 0;
		_grupo = _vehicleData select 2;
		_grupo setVariable ["staticAutoT",false,true];

		private _pieceType = call {
			if (_squadType == "mobile_at") exitWith {["FIA", "static_at"] call AS_fnc_getEntity};
			if (_squadType == "mobile_mortar") exitWith {["FIA", "static_mortar"] call AS_fnc_getEntity};
		};

		private _piece = _pieceType createVehicle (_position findEmptyPosition [1,30,"B_G_Van_01_transport_F"]);
		private _morty = _grupo createUnit [["FIA", "crew"] call AS_fnc_getEntity, _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"], [], 0, "NONE"];

		if (_squadType == "mobile_mortar") then {
			_morty moveInGunner _piece;
			_piece setVariable ["attachPoint", [0,-1.5,0.54]];
			[_morty,_camion,_piece] spawn AS_fnc_activateMortarCrewOnTruck;
		} else {
			_piece attachTo [_camion,[0,-2.4,-0.6]];
			_piece setDir (getDir _camion + 180);
			_morty moveInGunner _piece;
		};
		[_camion, "FIA"] call AS_fnc_initVehicle;
		[_piece, "FIA"] call AS_fnc_initVehicle;
	};
	_grupo
}] call DICT_fnc_set;

// FIA minefield uses first of this list
[_dict, "land_vehicles", ["rhsgref_cdf_b_reg_uaz_open","rhs_Ural_Open_Civ_01","rhsgref_cdf_b_reg_uaz_dshkm"]] call DICT_fnc_set;
[_dict, "water_vehicles", ["B_G_Boat_Transport_01_F"]] call DICT_fnc_set;
// First helicopter of this list is undercover
[_dict, "air_vehicles", ["rhs_Mi8amt_civilian"]] call DICT_fnc_set;

[_dict, "cars_armed", ["rhsgref_cdf_b_reg_uaz_dshkm"]] call DICT_fnc_set;

// costs of **land vehicle**. Every vehicle in `"land_vehicles"` must be here.
private _costs = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "costs"] call DICT_fnc_del; // delete old
[_dict, "costs", _costs] call DICT_fnc_set;
[_costs, "rhsgref_cdf_b_reg_uaz_open", 300] call DICT_fnc_set;
[_costs, "rhs_Ural_Open_Civ_01", 600] call DICT_fnc_set;
[_costs, "rhsgref_cdf_b_reg_uaz_open", 700] call DICT_fnc_set;
[_costs, "rhsgref_cdf_b_gaz66_zu23", 1200] call DICT_fnc_set; // used in custom vehicles

_dict
