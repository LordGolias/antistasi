#include "../macros.hpp"

AS_fnc_AAFroadPatrol = {
	AS_SERVER_ONLY("AAFroadPatrol");
	private _validTypes = vehPatrol + [vehBoat];
	_validTypes = _validTypes arrayIntersect (AS_AAFarsenal_categories call AS_fnc_AAFarsenal_all);
	_validTypes = _validTypes arrayIntersect _validTypes;

	private _max_patrols = 3*(count allPlayers);
	if (AAFpatrols >= _max_patrols) exitWith {
		AS_ISDEBUG("[AS] Debug: AAFroadPatrol: max patrols reached");
	};

	private _origin = "";
	private _type = "";
	{
		private _candidate = selectRandom _validTypes;
		private _category = _candidate call AS_fnc_AAFarsenal_category;

		private _validOrigins = ["base"];
		if (_category == "trucks") then {
			_validOrigins = ["base", "outpost"];
		};
		if (_category in ["armedHelis", "transportHelis", "planes"]) then {
			_validOrigins = ["airfield"];
		};
		if (_type == vehBoat) then {
			_validOrigins = ["searport"];
		};
		_validOrigins = [_validOrigins, "AAF"] call AS_fnc_location_TS;

		_validOrigins = _validOrigins select {!(_x call AS_fnc_location_spawned)};
		if (count _validOrigins > 0) exitWith {
			_origin = [_validOrigins, getMarkerPos "FIA_HQ"] call BIS_fnc_nearestPosition;
			_type = _candidate;
		};
	} forEach (_validTypes call AS_fnc_shuffle);
	private _category = [_type] call AS_fnc_AAFarsenal_category;

	if (_type == "") exitWith {
		AS_ISDEBUG("[AS] debug: fnc_createRoadPatrol cancelled: no valid types");
	};

	private _spawnName = format ["AAFroadPatrol", floor random 100];
	[_spawnName, "AAFpatrol"] call AS_spawn_fnc_add;
	[_spawnName, "type", _type] call AS_spawn_fnc_set;
	[_spawnName, "isFlying", _category in ["armedHelis","transportHelis", "planes"]] call AS_spawn_fnc_set;
	[_spawnName, "origin", _origin] call AS_spawn_fnc_set;

	[["AAFroadPatrol", _spawnName], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
};

private _fnc_spawn = {
	params ["_spawnName"];
	AAFpatrols = AAFpatrols + 1;
	publicVariable "AAFpatrols";
	private _type = [_spawnName, "type"] call AS_spawn_fnc_get;
	private _isFlying = [_spawnName, "isFlying"] call AS_spawn_fnc_get;
	private _origin = [_spawnName, "origin"] call AS_spawn_fnc_get;
	private _posbase = _origin call AS_fnc_location_position;

	if not _isFlying then {
		if (_type == vehBoat) then {
			_posbase = [_posbase,50,150,10,2,0,0] call BIS_Fnc_findSafePos;
		} else {
			private _tam = 10;
			private _roads = [];
			while {count _roads == 0} do {
				_roads = _posbase nearRoads _tam;
				_tam = _tam + 10;
			};
			private _road = _roads select 0;
			_posbase = position _road;
		};
	};

	private _vehicle = [_posbase, 0,_type, side_red] call bis_fnc_spawnvehicle;
	private _veh = _vehicle select 0;
	[_veh, "AAF"] call AS_fnc_initVehicle;
	[_veh,"Patrol"] spawn inmuneConvoy;
	private _vehCrew = _vehicle select 1;
	{_x call AS_fnc_initUnitAAF} forEach _vehCrew;
	private _grupoVeh = _vehicle select 2;

	if (_type isKindOf "Car") then {
		private _groupType = [selectRandom infGarrisonSmall, "AAF"] call fnc_pickGroup;
		private _tempGroup = createGroup side_red;
		[_groupType call AS_fnc_groupCfgToComposition, _tempGroup, _posbase, _veh call AS_fnc_availableSeats] call AS_fnc_createGroup;
		{
			_x assignAsCargo _veh;
			_x moveInCargo _veh;
			[_x] joinsilent _grupoveh;
			_x call AS_fnc_initUnitAAF;
		} forEach units _tempGroup;
		deleteGroup _tempGroup;
		[_veh] spawn smokeCover;
	};

	[_spawnName, "resources", [taskNull, [_grupoVeh], [_veh], []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_spawnName"];
	private _isFlying = [_spawnName, "isFlying"] call AS_spawn_fnc_get;
	private _type = [_spawnName, "type"] call AS_spawn_fnc_get;

	private _grupoveh = ([_spawnName, "resources"] call AS_spawn_fnc_get) select 1 select 0;
	private _veh = ([_spawnName, "resources"] call AS_spawn_fnc_get) select 2 select 0;
	private _soldados = units _grupoveh;

	private _fnc_destinations = {

		private _potentialLocations = call {
			if _isFlying exitWith {
				"AAF" call AS_fnc_location_S
			};
			if (_type == vehBoat) exitWith {
				[["searport"], "AAF"] call AS_fnc_location_TS
			};
			[["base", "airfield", "resource", "factory", "powerplant", "outpost", "outpostAA"],
			"AAF"] call AS_fnc_location_TS
		};

		private _posHQ = getMarkerPos "FIA_HQ";
		_potentialLocations select {_posHQ distance (_x call AS_fnc_location_position) < 3000}
	};

	private _arraydestinos = call _fnc_destinations;
	private _distancia = 200;

	if (count _arraydestinos < 1) exitWith {
		AS_ISDEBUG("[AS] debug: fnc_createRoadPatrol cancelled: no valid destinations");
	};

	private _continue_condition = {
		(canMove _veh) and {alive _veh} and {count _arraydestinos > 0} and {{alive _x} count _soldados != 0} and
		{{fleeing _x} count _soldados != {alive _x} count _soldados}
	};

	private _destino = selectRandom _arraydestinos;
	private _posdestino = _destino call AS_fnc_location_position;
	private _Vwp0 = _grupoVeh addWaypoint [_posdestino, 0];
	_Vwp0 setWaypointType "MOVE";
	_Vwp0 setWaypointBehaviour "SAFE";
	_Vwp0 setWaypointSpeed "LIMITED";
	_veh setFuel 1;
	while {(_veh distance _posdestino > _distancia) and _continue_condition} do {
		sleep 20;
		{
			if (_x select 2 == side_blue) then {
				private _arevelar = _x select 4;
				private _nivel = (driver _veh) knowsAbout _arevelar;
				if (_nivel > 1.4) then {
					{
						if (leader _x distance _veh < AS_P("spawnDistance")) then {_x reveal [_arevelar,_nivel]};
					} forEach allGroups;
				};
			};
		} forEach (driver _veh nearTargets AS_P("spawnDistance"));
	};

	if _isFlying then {
		_arrayDestinos = "AAF" call AS_fnc_location_S;
	} else {
		if (_type == vehBoat) then {
			_arraydestinos = ([["searport"], "AAF"] call AS_fnc_location_TS) select {(_x call AS_fnc_location_position) distance (position _veh) < 2500};
		} else {
			_arraydestinos = call _fnc_destinations;
		};
	};

	if (call _continue_condition) then {
		// repeat this state
		[_spawnName, "state_index", 1] call AS_spawn_fnc_set;
	};
};

private _fnc_clean = {
	params ["_spawnName"];
	AAFpatrols = AAFpatrols - 1;
	publicVariable "AAFpatrols";
	([_spawnName, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
};

AS_spawn_AAFroadPatrol_states = ["spawn", "run", "clean"];
AS_spawn_AAFroadPatrol_state_functions = [
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
