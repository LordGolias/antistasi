#include "../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _tiempolim = 60;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _posHQ = "FIA_HQ" call AS_fnc_location_position;
	private _fMarkers = "FIA" call AS_fnc_location_S;

	// select list of valid bases
	private _bases = [];
	{
		private _basePosition = _x call AS_fnc_location_position;
		if ((_position distance _basePosition < 7500) and
			(_position distance _basePosition > 1500) and
			(not (_x call AS_fnc_location_spawned))) then {_bases pushBack _x}
	} forEach (["base", "AAF"] call AS_fnc_location_TS);

	// select nearest base to
	private _base = "";
	private _basePosition = [];
	if (count _bases > 0) then {
		_base = [_bases,_position] call BIS_fnc_nearestPosition;
		_basePosition = _base call AS_fnc_location_position;
	};
	if (_base == "") exitWith {
		hint "There are no supplies missing.";
	};

	// find a suitable position for the medical supplies
	// try 20 times, if fail, the mission does not start
	private _crashPosition = [];
	for "_i" from 0 to 20 do {
		sleep 0.1;
		_crashPosition = [_position,2000,random 360] call BIS_fnc_relPos;
		private _nfMarker = [_fMarkers,_crashPosition] call BIS_fnc_nearestPosition;
		private _fposition = _nfMarker call AS_fnc_location_position;
		private _hposition = _nfMarker call AS_fnc_location_position;
		if ((!surfaceIsWater _crashPosition) &&
		    (_crashPosition distance _posHQ < 4000) &&
			(_fposition distance _crashPosition > 500) &&
			(_hposition distance _crashPosition > 800)) exitWith {};
	};

	if (_crashPosition isEqualTo []) exitWith {
		hint "There are no supplies missing.";
	};

	private _tskTitle = _mission call AS_fnc_mission_title;
	private _tskDesc = format [localize "STR_tskDesc_logMedical",
		[_location] call localizar, _location,
		[_base] call localizar, _base,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4,
		A3_STR_INDEP
	];

	private _vehicleType = selectRandom AS_FIA_vans;

	private _crashPositionMrk = [_crashPosition,random 200,random 360] call BIS_fnc_relPos;
	_crashPosition = _crashPosition findEmptyPosition [0,100,_vehicleType];
	private _mrkfin = createMarker [format ["REC%1", random 100], _crashPositionMrk];
	_mrkfin setMarkerShape "ICON";

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "crashPosition", _crashPosition] call AS_spawn_fnc_set;
	[_mission, "vehicleType", _vehicleType] call AS_spawn_fnc_set;
	[_mission, "basePosition", _basePosition] call AS_spawn_fnc_set;
	[_mission, "resources", [taskNull, [], [], [_mrkfin]]] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_mrkfin], _crashPositionMrk, "Heal"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _crashPosition = [_mission, "crashPosition"] call AS_spawn_fnc_get;
	private _basePosition = [_mission, "basePosition"] call AS_spawn_fnc_get;
	private _vehicleType = [_mission, "vehicleType"] call AS_spawn_fnc_get;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	private _vehiculos = [];
	private _grupos = [];

	private _truck = createVehicle [_vehicleType, _crashPosition, [], 0, "CAN_COLLIDE"];
	[_truck,"Mission Vehicle"] spawn inmuneConvoy;
	AS_Sset("reportedVehs", AS_S("reportedVehs") + [_truck]);
	_vehiculos pushBack _truck;

	private _crate1 = "Box_IND_Support_F" createVehicle _crashPosition;
	private _crate2 = "Box_IND_Support_F" createVehicle _crashPosition;
	private _crate3 = "Box_NATO_WpsSpecial_F" createVehicle _crashPosition;
	private _crate4 = "Box_NATO_WpsSpecial_F" createVehicle _crashPosition;
	_vehiculos append [_crate1, _crate2, _crate3, _crate4];

	_crate1 setPos ([getPos _truck, 6, 185] call BIS_Fnc_relPos);
	_crate2 setPos ([getPos _truck, 4, 167] call BIS_Fnc_relPos);
	_crate3 setPos ([getPos _truck, 8, 105] call BIS_Fnc_relPos);
	_crate4 setPos ([getPos _truck, 5, 215] call BIS_Fnc_relPos);
	_crate1 setDir (getDir _truck + (floor random 180));
	_crate2 setDir (getDir _truck + (floor random 180));
	_crate3 setDir (getDir _truck + (floor random 180));
	_crate4 setDir (getDir _truck + (floor random 180));

	[_crate1] call emptyCrate;
	[_crate2] call emptyCrate;
	[_crate3] call emptyCrate;
	[_crate4] call emptyCrate;

	_crate1 addItemCargoGlobal ["FirstAidKit", 40];
	_crate2 addItemCargoGlobal ["FirstAidKit", 40];
	_crate3 addItemCargoGlobal ["Medikit", 10];
	_crate4 addItemCargoGlobal ["Medikit", 10];

	private _tipoGrupo = [infGarrisonSmall, "AAF"] call fnc_pickGroup;
	private _grupo = [_crashPosition, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
	_grupos pushBack _grupo;

	{[_x] call AS_fnc_initUnitAAF} forEach units _grupo;

	private _tam = 100;
	private _road = objNull;
	while {true} do {
		private _roads = _basePosition nearRoads _tam;
		if (count _roads > 0) exitWith {_road = _roads select 0;};
		_tam = _tam + 50;
	};

	private _vehicle = [position _road, 0, selectRandom ("trucks" call AS_AAFarsenal_fnc_valid), side_red] call bis_fnc_spawnvehicle;
	private _veh = _vehicle select 0;
	[_veh, "AAF"] call AS_fnc_initVehicle;
	[_veh,"AAF Escort"] spawn inmuneConvoy;
	private _grupoVeh = _vehicle select 2;
	{[_x] spawn AS_fnc_initUnitAAF} forEach units _grupoVeh;
	_grupos pushBack _grupoVeh;
	_vehiculos pushBack _veh;

	sleep 1;

	_tipoGrupo = [infSquad, "AAF"] call fnc_pickGroup;
	_grupo = [_basePosition, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;

	{_x assignAsCargo _veh; _x moveInCargo _veh; [_x] call AS_fnc_initUnitAAF} forEach units _grupo;
	_grupos pushBack _grupo;

	[_veh] spawn smokeCover;

	private _Vwp0 = _grupoVeh addWaypoint [_crashPosition, 0];
	_Vwp0 setWaypointType "TR UNLOAD";
	_Vwp0 setWaypointBehaviour "SAFE";
	private _Gwp0 = _grupo addWaypoint [_crashPosition, 0];
	_Gwp0 setWaypointType "GETOUT";
	_Vwp0 synchronizeWaypoint [_Gwp0];

	private _markers = ([_mission, "resources"] call AS_spawn_fnc_get) select 3;
	[_mission, "truck", _truck] call AS_spawn_fnc_set;
	[_mission, "crates", [_crate1, _crate2, _crate3, _crate4]] call AS_spawn_fnc_set;
	[_mission, "resources", [_task, _grupos, _vehiculos, _markers]] call AS_spawn_fnc_set;
};

private _fnc_wait_to_arrive = {
	params ["_mission"];
	private _truck = [_mission, "truck"] call AS_spawn_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};
	// wait for any activity around the truck
	waitUntil {sleep 1;
		({(side _x == side_blue) and (_x distance _truck < 50)} count allUnits > 0) or _fnc_missionFailedCondition
	};

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	};
};

private _fnc_wait_to_unload = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;
	private _truck = [_mission, "truck"] call AS_spawn_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
	private _groups = ([_mission, "resources"] call AS_spawn_fnc_get) select 1;

	private _crashPosition = [_mission, "crashPosition"] call AS_spawn_fnc_get;

	([_mission, "AUTOASSIGNED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

	// make all FIA around the truck non-captive
	{
		if (captive _x) then {
			[_x,false] remoteExec ["setCaptive",_x];
		};
	} forEach ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

	// make all enemies rush to the truck
	{
		{
			_x doMove _crashPosition;
		} forEach units _x;
	} forEach _groups;

	private _fnc_loadCratesCondition = {
		// The condition to allow loading the crates into the truck
		(_truck distance _crashPosition < 20) and {speed _truck < 1} and
		{{alive _x and not (_x call AS_fnc_isUnconscious)} count ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0} and
		{{(side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
	};

	private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};

	// wait for the truck to unload (2m) or the mission to fail
	[_truck, 120, _fnc_loadCratesCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

	if (call _fnc_missionFailedCondition) then {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];

		// set the spawn state to `run` so that the next one is `clean`, since this ends the mission
		[_mission, "state_index", 3] call AS_spawn_fnc_set;
	} else {
		([_mission, "AUTOASSIGNED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

		private _message = format ["Good to go. Deliver these supplies to %1 on the double.",[_location] call localizar];
		{
			if (isPlayer _x) then {
				[petros,"globalChat",_message] remoteExec ["commsMP",_x]
			};
		} forEach ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

		private _crates = [_mission, "crates"] call AS_spawn_fnc_get;
		_crates params ["_crate1", "_crate2", "_crate3", "_crate4"];
		_crate1 attachTo [_truck, [0.3,-1.0,-0.4]];
		_crate2 attachTo [_truck, [-0.3,-1.0,-0.4]];
		_crate3 attachTo [_truck, [0,-1.6,-0.4]];
		_crate4 attachTo [_truck, [0,-2.0,-0.4]];
	};
};

private _fnc_wait_to_deliver = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;
	private _truck = [_mission, "truck"] call AS_spawn_fnc_get;
	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {(dateToNumber date > _max_date) or (not alive _truck)};

	waitUntil {sleep 1; (_truck distance _position < 40 and (speed _truck == 0)) or _fnc_missionFailedCondition};

	if (_truck distance _position < 40 and (speed _truck == 0)) then {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_success", 2];

		private _message = "Leave the vehicle here, they'll come to pick it up.";
		{
			if (isPlayer _x) then {
				[petros,"globalChat",_message] remoteExec ["commsMP",_x]
			};
		} forEach ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

		// remove fuel, eject all and lock
		_truck setFuel 0;
		{
			_x action ["eject", _truck];
		} forEach (crew _truck);
		sleep 1;
		_truck lock 2;
		{
			if (isPlayer _x) then {
				[_truck,true] remoteExec ["fnc_lockVehicle",_x];
			};
		} forEach ([100, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
	} else {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_fnc_mission_fail", 2];
	};
};

AS_mission_helpMeds_states = ["initialize", "spawn", "wait_to_arrive",
	"wait_to_unload", "wait_to_deliver", "clean"];
AS_mission_helpMeds_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_wait_to_arrive,
	_fnc_wait_to_unload,
	_fnc_wait_to_deliver,
	AS_mission_fnc_clean
];
