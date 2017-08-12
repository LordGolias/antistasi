// clean everything because we do not need the default stuff
if (isServer) then {
	{AS_FIArecruitment setVariable [_x, nil, true];} forEach (allVariables AS_FIArecruitment);
};

if (isServer) then {
	AS_FIArecruitment setVariable ["land_vehicles", [
		"C_Offroad_01_F",
		"rhs_Ural_Open_Civ_01",
		"rhsgref_cdf_b_reg_uaz_open",
		"rhsgref_cdf_b_reg_uaz_dshkm",
		statMG, statMortar, statAT, statAA
	], true];

	// All elements in the lists above must be priced below or their price is 300
	AS_FIArecruitment setVariable ["C_Offroad_01_F", 300, true];
	AS_FIArecruitment setVariable ["rhs_Ural_Open_Civ_01", 600, true];
	AS_FIArecruitment setVariable ["rhsgref_cdf_b_reg_uaz_open", 300, true];
	AS_FIArecruitment setVariable ["rhsgref_cdf_b_reg_uaz_dshkm", 700, true];
	AS_FIArecruitment setVariable [statMG, 800, true];
	AS_FIArecruitment setVariable [statMortar, 800, true];
	AS_FIArecruitment setVariable [statAT, 800, true];
	AS_FIArecruitment setVariable [statAA, 800, true];

	AS_FIArecruitment setVariable ["water_vehicles", ["B_G_Boat_Transport_01_F"], true];
	AS_FIArecruitment setVariable ["B_G_Boat_Transport_01_F", 400, true];

	// First helicopter of this list is undercover
	AS_FIArecruitment setVariable ["air_vehicles", ["rhs_Mi8amt_civilian"], true];
	AS_FIArecruitment setVariable ["rhs_Mi8amt_civilian", 6000, true];
};

AS_FIA_vans = ["rhs_Ural_Open_Civ_01", "rhs_Ural_Open_Civ_02", "rhs_Ural_Open_Civ_03"];

AS_FIACustomSquad_types = ["Mobile AA", "Mobile AT", "Mobile Mortar"];


AS_fnc_FIACustomSquad_piece = {
	params ["_squadType"];
	if (_squadType == "Mobile AT") exitWith {statAT};
	if (_squadType == "Mobile Mortar") exitWith {statMortar};
};

AS_fnc_FIACustomSquad_cost = {
	params ["_squadType"];
	private _cost = 0;
	private _costHR = 0;
	if (_squadType == "Mobile AA") then {
		_costHR = 3;
		_cost = _costHR*(AS_data_allCosts getVariable "Crew") +
			    ([vehTruckAA] call FIAvehiclePrice);
	} else {
		_costHR = 2;
		_cost = _costHR*(AS_data_allCosts getVariable "Crew") +
				(["B_G_Van_01_transport_F"] call FIAvehiclePrice) +
				([[_squadType] call AS_fnc_FIACustomSquad_piece] call FIAvehiclePrice);
	};
	[_costHR, _cost]
};

AS_fnc_FIACustomSquad_initialization = {
	params ["_squadType", "_position"];
	private _grupo = grpNull;

	if (_squadType == "Mobile AA") then {
		private _pos = _position findEmptyPosition [1,30,vehTruckAA];
		private _vehicle = [_pos, 0, vehTruckAA, side_blue] call bis_fnc_spawnvehicle;
		private _veh = _vehicle select 0;
		private _vehCrew = _vehicle select 1;
		{deleteVehicle _x} forEach crew _veh;
		_grupo = _vehicle select 2;
		[_veh, "FIA"] call AS_fnc_initVehicle;
		private _driv = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
		_driv moveInDriver _veh;
		private _gun = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
		_gun moveInGunner _veh;
		private _com = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
		_com moveInCommander _veh;
	} else {
		private _pos = _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
		private _vehicleData = [_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
		private _camion = _vehicleData select 0;
		_grupo = _vehicleData select 2;
		_grupo setVariable ["staticAutoT",false,true];

		private _piece = ([_squadType] call AS_fnc_FIACustomSquad_piece) createVehicle (_position findEmptyPosition [1,30,"B_G_Van_01_transport_F"]);
		private _morty = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _position findEmptyPosition [1,30,"B_G_Van_01_transport_F"], [], 0, "NONE"];

		if (_squadType == "Mobile Mortar") then {
			_morty moveInGunner _piece;
			_piece setVariable ["attachPoint", [0,-1.5,0.54]];
			[_morty,_camion,_piece] spawn mortyAI;
		} else {
			_piece attachTo [_camion,[0,-2.4,-0.6]];
			_piece setDir (getDir _camion + 180);
			_morty moveInGunner _piece;
		};
		[_camion, "FIA"] call AS_fnc_initVehicle;
		[_piece, "FIA"] call AS_fnc_initVehicle;
	};
	_grupo
};
