if (!isServer and hasInterface) exitWith {};

AS_fnc_roadAndDir = {
	private _position = _this;
	private _road = objNull;
	private _dist = 50;
	{
	    if ((position _x) distance _position < _dist) then {
	        _road = _x;
	        _dist = (position _x) distance _position;
	    };
	} forEach (_position nearRoads 50);
	if (isNull _road) exitWith {[objNull, []]};
	if (count (roadsConnectedto _road) == 0) exitWith {[objNull, []]};
	private _roadcon = (roadsConnectedto _road) select 0;
	private _dirveh = [_roadcon, _road] call BIS_fnc_DirTo;
	[_road, _dirveh]
};

AS_fnc_spawnAAF_roadAT = {
	params ["_position", "_group"];

	private _vehicles = [];
	private _units = [];

	(_position call AS_fnc_roadAndDir) params ["_road", "_dir"];
	if (!isNull _road) then {
		private _pos = [getPos _road, 7, _dir + 270] call BIS_Fnc_relPos;
		private _bunker = "Land_BagBunker_Small_F" createVehicle _pos;
		_bunker setDir _dir;
		_pos = getPosATL _bunker;
		_vehicles pushBack _bunker;

		private _veh = statAT createVehicle _position;
		_veh setPos _pos;
		_veh setDir _dir + 180;
		[_veh, "AAF"] call AS_fnc_initVehicle;
		_vehicles pushBack _veh;

		_unit = ([_position, 0, infGunner, _group] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		[_unit, false] spawn AS_fnc_initUnitAAF;
		_units pushBack _unit;
	};
	[_units, _vehicles]
};

AS_fnc_spawnAAF_patrol = {
	params ["_location", "_amount"];

	private _position = _location call AS_fnc_location_position;

	private _units = [];
	private _groups = [];

	// marker used to set the patrol area
	private _mrk = createMarkerLocal [format ["%1patrolarea", random 100], _position];
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [(AS_P("spawnDistance")/2),(AS_P("spawnDistance")/2)];
	_mrk setMarkerTypeLocal "hd_warning";
	_mrk setMarkerColorLocal "ColorRed";
	_mrk setMarkerBrushLocal "DiagGrid";
	_mrk setMarkerDirLocal (markerDir _location);  // ERROR
	_mrk setMarkerAlphaLocal 0;

	// spawn patrols
	for "_i" from 1 to _amount do {
		if !(_location call AS_fnc_location_spawned) exitWith {};

		private _pos = [0,0,0];
		while {true} do {
			_pos = [_position, 150 + (random 350) ,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
		};
		private _group = [_pos, side_green, [infPatrol, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;

		if (random 10 < 2.5) then {
			[_group createUnit ["Fin_random_F",_pos,[],0,"FORM"]] spawn guardDog;
		};
		[leader _group, _mrk, "SAFE","SPAWNED", "NOVEH2"] execVM "scripts\UPSMON.sqf";

		_groups pushBack _group;
		{[_x, false] spawn AS_fnc_initUnitAAF; _units pushBack _x} forEach units _group;
	};
	[_units, _groups, _mrk]
};

AS_fnc_spawnAAF_patrolSquad = {
	params ["_location", "_amount"];

	private _position = _location call AS_fnc_location_position;
	private _size = _location call AS_fnc_location_size;

	private _units = [];
	private _groups = [];

	for "_i" from 1 to _amount do {
		if (!(_location call AS_fnc_location_spawned) or (_i != 1 and diag_fps < AS_P("minimumFPS"))) exitWith {};
		private _pos = [];
		while {true} do {
			_pos = [_position, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
		};
		private _group = [_pos, side_green, [infSquad, side_green] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
		if (hayRHS) then {_group = [_group, _position] call expandGroup};

		private _stance = "RANDOM";
		if (_i == 1) then {_stance = "RANDOMUP"};

		[leader _group,_location,"SAFE","SPAWNED",_stance,"NOVEH","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_groups pushBack _group;
		{[_x, false] spawn AS_fnc_initUnitAAF; _units pushBack _x} forEach units _group;
		sleep 1;
	};
	[_units, _groups]
};

AS_fnc_spawnAAF_truck = {
	params ["_location"];

	private _position = _location call AS_fnc_location_position;
	private _size = _location call AS_fnc_location_size;

	private _vehicles = [];

	if (["trucks"] call AS_fnc_AAFarsenal_count > 0) then {
		private _type = selectRandom (["trucks"] call AS_fnc_AAFarsenal_all);
		private _pos = _position findEmptyPosition [5,_size, _type];
		private _veh = createVehicle [_type, _pos, [], 0, "NONE"];
		_veh setDir random 360;
		_vehicles pushBack _veh;
		[_veh, "AAF"] call AS_fnc_initVehicle;
	};
	[_vehicles]
};

// find road spots to spawn vehicles on, provide initial heading
fnc_findSpawnSpots = {
	params ["_origin", ["_dest", [0,0,0]], ["_spot", false]];
	private ["_roads", "_startRoad"];
	_startRoad = _origin;
	_roads = [];

	private _tam = 10;

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

		private _p1 = ["Number of vehicles in garage: %1", count AS_P("vehiclesInGarage")];
		_pI pushBackUnique (format _p1);

		if (count AS_P("vehiclesInGarage") > 0) then {
			private _vehicleTypes = [];
			{
				_vehicleTypes pushBackUnique _x;
			} forEach AS_P("vehiclesInGarage");
			_p2 = ["List of vehicles \n"];
			_p2v = [];
			for "_i" from 0 to (count _vehicleTypes - 1) do {
				_p2 pushBack ("%" + str ((2*(_i+1))-1) + " x %" + str (2*(_i+1)));
				if (_i < (count _vehicleTypes - 1)) then {_p2 pushBack ", "};
				_p2v = _p2v + [getText (configFile >> "CfgVehicles" >> _vehicleTypes select _i >> "displayName"), ({_x == _vehicleTypes select _i} count AS_P("vehiclesInGarage"))];
			};
			_p2 = _p2 joinString "";
			_p2 = [_p2] + _p2v;
			_pI pushBackUnique (format _p2);
		};
	};

	[petros,_type,_pI] remoteExec ["commsMP",AS_commander];
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
