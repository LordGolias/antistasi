if (!isServer and hasInterface) exitWith {};

// find road spots to spawn vehicles on, provide initial heading
fnc_findSpawnSpots = {
	params ["_origin", ["_dest", "base_4"], ["_spot", false]];
	private ["_roads", "_startRoad"];
	_startRoad = _origin;
	_roads = [];

	if (_spot) exitWith {
		[_origin, "none"] call fnc_getpresetSpawnPos;
	};

	private _tam = 10;

	if !(typeName _origin == "ARRAY") then {
		_startRoad = getMarkerPos _origin;
	};
	if (worldName == "Altis") then {
		_startRoad = [_origin, "road"] call fnc_getpresetSpawnPos;
	};
	if !(typeName _dest == "ARRAY") then {
		_dest = getMarkerPos _dest;
	};

	while {true} do {
		_roads = _startRoad nearRoads _tam;
		if (count _roads > 0) exitWith {};
		_tam = _tam + 10;
	};

	private _road = _roads select 0;
	private _conRoads = roadsConnectedto _road;
	private _posRoad = position _road;
	private _dist = _posRoad distance2D _dest;
	if (count _conRoads > 0) then {
		{
			if ((position _x distance2D _dest) < _dist) then {
				_posRoad = position _x;
				_dist = _posRoad distance2D _dest;
			};
		} forEach _conRoads;
	};
	private _dir = [position _road, _posRoad] call BIS_fnc_dirTo;

	[position _road, _dir]
};

fnc_initialiseVehicle = {
	params ["_spawnPos", "_vehicleType", "_direction", ["_side", side_green], ["_allVehicles", []], ["_allGroups", []], ["_allSoldiers", []], ["_details", false]];

	private _vehicleArray = [_spawnPos, _direction, _vehicleType, _side] call bis_fnc_spawnvehicle;
	private _vehicle = _vehicleArray select 0;
	private _vehicleCrew = _vehicleArray select 1;
	private _vehicleGroup = _vehicleArray select 2;

	[_vehicleCrew, _side, _vehicle] call fnc_initialiseUnits;

	_allVehicles pushBackUnique _vehicle;
	_allGroups pushBackUnique _vehicleGroup;
	_allSoldiers = _allSoldiers + _vehicleCrew;

	private _return = [_allVehicles, _allGroups, _allSoldiers];
	if (_details) then {
		_return pushBack [_vehicle, _vehicleGroup, _vehicleCrew];
	};
	_return;
};

fnc_initialiseUnits = {
	params ["_soldiersToInit", ["_initSide", side_green], ["_vehicleToInit", "none"]];

	if (typeName _initSide == "GROUP") then {
		_initSide = side _initSide;
	};

    if (_initSide == side_red) then {
    	if (typeName _soldiersToInit == "ARRAY") then {
    		{[_x] spawn CSATinit} forEach _soldiersToInit;
    	}
    	else {
    		{[_x] spawn CSATinit} forEach units _soldiersToInit;
    	};
        if !(_vehicleToInit isEqualTo "none") then {
			[_vehicleToInit, "CSAT"] call AS_fnc_initVehicle;
        };
    } else {
    	if (typeName _soldiersToInit == "ARRAY") then {
    		{[_x] spawn fnc_initialiseUnits} forEach _soldiersToInit;
    	}
    	else {
    		{[_x] spawn fnc_initialiseUnits} forEach units _soldiersToInit;
    	};
        if !(_vehicleToInit isEqualTo "none") then {
			[_vehicleToInit, "AAF"] call AS_fnc_initVehicle;
        };
    };
};

fnc_infoScreen = {
	params ["_type"];

	private _pI = [];
	private _p2 = [];
	private _p3 = [];

	if (_type == "status") then {

		private _p1 = ["Number of vehicles in garage: %1", count vehInGarage];
		_pI pushBackUnique (format _p1);

		if (count vehInGarage > 0) then {
			private _vehicleTypes = [];
			{
				_vehicleTypes pushBackUnique _x;
			} forEach vehInGarage;
			_p2 = ["List of vehicles \n"];
			_p2v = [];
			for "_i" from 0 to (count _vehicleTypes - 1) do {
				_p2 pushBack ("%" + str ((2*(_i+1))-1) + " x %" + str (2*(_i+1)));
				if (_i < (count _vehicleTypes - 1)) then {_p2 pushBack ", "};
				_p2v = _p2v + [getText (configFile >> "CfgVehicles" >> _vehicleTypes select _i >> "displayName"), ({_x == _vehicleTypes select _i} count vehInGarage)];
			};
			_p2 = _p2 joinString "";
			_p2 = [_p2] + _p2v;
			_pI pushBackUnique (format _p2);
		};
	};

	[petros,_type,_pI] remoteExec ["commsMP",AS_commander];
};

fnc_togglePetrosAnim = {
	params [["_force", false]];

	if (_force) exitWith {
		petros setVariable ["AS_animPetros", false, true];
		[petros] remoteExec ["BIS_fnc_ambientAnim__terminate", [0,-2] select isDedicated, true];
		[] call fnc_rearmPetros;
	};

	if (server getVariable ["AS_toggleAnim", false]) exitWith {
		[petros,"BE", "Currently changing Petros' state, try again in a few seconds."] remoteExec ["commsMP",AS_commander];
	};

	server setVariable ["AS_toggleAnim", true, true];

	if (petros getVariable ["AS_animPetros", false]) then {
		petros setVariable ["AS_animPetros", false, true];
	} else {
		[] remoteExec ["petrosAnimation", 2];
	};

	server setVariable ["AS_toggleAnim", nil, true];
};

fnc_rearmPetros = {
	private _mag = currentMagazine petros;
	petros removeMagazines _mag;
	petros removeWeaponGlobal (primaryWeapon petros);
	[petros, selectRandom (AAFWeapons arrayIntersect (AS_weapons select 0)), 5, 0] call BIS_fnc_addWeapon;
	petros selectweapon primaryWeapon petros;
};

fnc_logOutput = {
	params ["_text"];
	diag_log format ["Client-side log entry: %1", _text];
};
publicVariable "fnc_logOutput";

fnc_deployPad = {
	params ["_obj", "_caller"];

	private _pos = position _obj;
	server setVariable ["AS_vehicleOrientation", [_caller, _obj] call BIS_fnc_dirTo, true];
	if ((_pos distance fuego) > 30) exitWith {
		[petros,"hint","Too far from HQ."] remoteExec ["commsMP",AS_commander];
		deleteVehicle _obj;
	};
	if !(isNil "vehiclePad") exitWith {
		[petros,"hint","Pad already deployed."] remoteExec ["commsMP",AS_commander];
		deleteVehicle _obj;
	};

	deleteVehicle _obj;
	vehiclePad = createVehicle ["Land_JumpTarget_F", _pos, [], 0, "CAN_COLLIDE"];

	publicVariable "vehiclePad";
};

fnc_selectCMPData = {
	params ["_marker"];
	private ["_data"];

	switch (_marker) do {
		case "Agela": {
			_data = AS_MTN_Agela;
		};
		case "Agia Stemma": {
			_data = AS_MTN_AgiaStemma;
		};
		case "Agios Andreas": {
			_data = AS_MTN_AgiosAndreas;
		};
		case "Agios Minas": {
			_data = AS_MTN_AgiosMinas;
		};
		case "Amoni": {
			_data = AS_MTN_Amoni;
		};
		case "Didymos": {
			_data = AS_MTN_Didymos;
		};
		case "Kira": {
			_data = AS_MTN_Kira;
		};
		case "Pyrsos": {
			_data = AS_MTN_Pyrsos;
		};
		case "Riga": {
			_data = AS_MTN_Riga;
		};
		case "Skopos": {
			_data = AS_MTN_Skopos;
		};
		case "Synneforos": {
			_data = AS_MTN_Synneforos;
		};
		case "Thronos": {
			_data = AS_MTN_Thronos;
		};

		case "puesto_2": {
			_data = AS_OP_2;
		};
		case "puesto_6": {
			_data = AS_OP_6;
		};
		case "puesto_11": {
			_data = AS_OP_11;
		};
		case "puesto_17": {
			_data = AS_OP_17;
		};
		case "puesto_23": {
			_data = AS_OP_23;
		};
	};

	_data
};
