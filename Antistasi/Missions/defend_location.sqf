#include "../macros.hpp"

AS_fnc_defendLocation = {
	AS_SERVER_ONLY("defendLocation");
	params ["_location"];
	private _debug_prefix = format ["defendLocation from '%1' to '%2' cancelled: ", _location];
	if AS_S("blockCSAT") exitWith {
		private _message = "blocked";
		AS_ISDEBUG(_debug_prefix + _message);
	};

	private _position = _location call AS_fnc_location_position;

	private _base = [_position] call findBasesForCA;
	private _airfield = [_position] call findAirportsForCA;

	// check if we have capabilities to use air units
	// decide to not use airfield if not enough air units
	if (_airfield != "") then {
		private _transportHelis = count (["transportHelis"] call AS_fnc_AAFarsenal_all);
		private _armedHelis = count (["armedHelis"] call AS_fnc_AAFarsenal_all);
		private _planes = count (["planes"] call AS_fnc_AAFarsenal_all);
		// 1 transported + any other if _isMarker.
		if (_transportHelis < 1 or (_transportHelis + _armedHelis + _planes < 3)) then {
			_airfield = "";
		};
	};

	if ((_base=="") and (_airfield=="")) exitWith {
		private _message = "no available bases nor airports";
		AS_ISDEBUG(_debug_prefix + _message);
	};

	// check whether CSAT will support
	private _useCSAT = false;
	private _prestigeCSAT = AS_P("CSATsupport");
	if ((random 100 < _prestigeCSAT) and (_prestigeCSAT >= 20) and not AS_S("blockCSAT")) then {
		_useCSAT = true;
	};

	private _mission = ["defend_location", _location] call AS_fnc_mission_add;
	[_mission, "base", _base] call AS_fnc_mission_set;
	[_mission, "airfield", _airfield] call AS_fnc_mission_set;
	[_mission, "useCSAT", _useCSAT] call AS_fnc_mission_set;
	_mission call AS_fnc_mission_activate;
};

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;

	private _base = [_mission, "base"] call AS_fnc_mission_get;
	private _airfield = [_mission, "airfield"] call AS_fnc_mission_get;
	private _useCSAT = [_mission, "useCSAT"] call AS_fnc_mission_get;

	private _tskTitle = "AAF Attack";
	private _tskDesc = "AAF is attacking %1. Defend it or we lose it";
	if _useCSAT then {
		_tskDesc = "AAF and CSAT are attacking %1. Defend it or we lose it";
	};
	_tskDesc = format [_tskDesc,[_location] call localizar];

	[_mission, [_tskDesc,_tskTitle,_location], _position, "Defend"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _position = _location call AS_fnc_location_position;
	private _base = [_mission, "base"] call AS_fnc_mission_get;
	private _airfield = [_mission, "airfield"] call AS_fnc_mission_get;
	private _useCSAT = [_mission, "useCSAT"] call AS_fnc_mission_get;

	[_location, true] call AS_fnc_location_spawn;

	private _threatEvalAir = 0;
	if (_airfield != "" or _useCSAT) then {_threatEvalAir = [_position] call AAthreatEval};

	private _threatEvalLand = 0;
	if (_base != "") then {_threatEvalLand = [_position] call landThreatEval};

	private _groups = [];
	private _vehicles = [];

	if _useCSAT then {
		if (AS_P("resourcesAAF") > 20000) then {
			[-20000] remoteExec ["resourcesAAF",2];
			[5,0] remoteExec ["AS_fnc_changeForeignSupport",2];
		} else {
			[5,-20] remoteExec ["AS_fnc_changeForeignSupport",2]
		};
		private _origin_pos = getMarkerPos "spawnCSAT";
		_origin_pos set [2,300];

		private _cuenta = 3;
		if ((_base == "") or (_airfield == "")) then {_cuenta = 6};

		for "_i" from 1 to _cuenta do {
			private _tipoVeh = "";
			if (_i == _cuenta) then {
				_tipoVeh = selectRandom opHeliTrans;
			} else {
				_tipoVeh = selectRandom opAir;
			};
			private _timeOut = 0;
			private _pos = _origin_pos findEmptyPosition [0,100,_tipoVeh];
			while {_timeOut < 60} do {
				if (count _pos > 0) exitWith {};
				_timeOut = _timeOut + 1;
				_pos = _origin_pos findEmptyPosition [0,100,_tipoVeh];
				sleep 1;
			};
			if (count _pos == 0) then {_pos = _origin_pos};

			private _vehicle = [_origin_pos, 0, _tipoVeh, side_red] call bis_fnc_spawnvehicle;
			private _heli = _vehicle select 0;
			private _heliCrew = _vehicle select 1;
			private _grupoheli = _vehicle select 2;
			{_x call AS_fnc_initUnitCSAT} forEach _heliCrew;
			_groups pushBack _grupoheli;
			_vehicles pushBack _heli;
			[_heli, "CSAT"] call AS_fnc_initVehicle;

			if (not(_tipoVeh in opHeliTrans)) then {
				private _wp1 = _grupoheli addWaypoint [_position, 0];
				_wp1 setWaypointType "SAD";
				[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
			} else {
				{_x setBehaviour "CARELESS"} forEach units _grupoheli;

				private _tipogrupo = [opGroup_Squad, "CSAT"] call fnc_pickGroup;
				private _grupo = [_origin_pos, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
				{_x assignAsCargo _heli; _x moveInCargo _heli; _x call AS_fnc_initUnitCSAT} forEach units _grupo;
				_groups pushBack _grupo;
				[_heli,"CSAT Air Transport"] spawn inmuneConvoy;
				if (((_position call AS_fnc_location_type) in ["base","airfield"]) or (random 10 < _threatEvalAir)) then {
					[_heli,_grupo,_position,_threatEvalAir] spawn airdrop;
				} else {
					if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then {
						{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
						private _landpos = [];
						_landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
						_landPos set [2, 0];
						private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
						_vehicles pushBack _pad;

						[_grupoheli, _origin_pos, _landpos, _location, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
					} else {
						[_grupoheli, _origin_pos, _position, _location, _grupo, 25*60] call fnc_QRF_fastrope;
					};
				};
			};
			sleep 15;
		};

		// drop artillery at bases or airfields
		[["TaskSucceeded", ["", format ["%1 under artillery fire",[_location] call localizar]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		[_location] spawn {
			params ["_location"];
			for "_i" from 0 to round (random 2) do {
				[_location, selectRandom opCASFW] spawn airstrike;
				sleep 30;
			};
			if ((_location call AS_fnc_location_type) in ["base","airfield"]) then {
				[_location] spawn artilleria;
			};
		};
	};

	private _origin_pos = [];
	if (_base != "") then {
		[_base,60] call AS_fnc_location_increaseBusy;
		_origin_pos = _base call AS_fnc_location_position;
		private _size = _base call AS_fnc_location_size;

		// compute number of trucks based on the marker size
		private _nVeh = round (_size/30);
		if (_nVeh < 1) then {_nVeh = 1};

		// spawn them
		for "_i" from 1 to _nveh do {
			private _toUse = "trucks";
			if (_threatEvalLand > 3 and (["apcs"] call AS_fnc_AAFarsenal_count > 0)) then {
				_toUse = "apcs";
			};
			if (_threatEvalLand > 5 and (["tanks"] call AS_fnc_AAFarsenal_count > 0)) then {
				_toUse = "tanks";
			};
			([_toUse, _origin_pos, _position, _threatEvalLand] call AS_fnc_createLandAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
			_groups append _groups1;
			_vehicles append _vehicles1;
			sleep 5;
		};
	};

	if (_airfield != "") then {
		[_airfield,60] call AS_fnc_location_increaseBusy;
		if (_base != "") then {sleep ((_origin_pos distance _position)/16)};

		_origin_pos = _airfield call AS_fnc_location_position;
		_origin_pos set [2,300];

		// spawn a UAV
		if (AS_AAFarsenal_uav != "") then {
			private _uav = createVehicle [AS_AAFarsenal_uav, _origin_pos, [], 0, "FLY"];
			_uav removeMagazines "6Rnd_LG_scalpel";
			_vehicles pushBack _uav;
			[_uav, "AAF"] call AS_fnc_initVehicle;
			[_uav,"UAV"] spawn inmuneConvoy;
			[_uav,_position] spawn VANTinfo;
			createVehicleCrew _uav;
			private _grupouav = group (crew _uav select 0);
			_groups pushBack _grupouav;
			{[_x] spawn AS_fnc_initUnitAAF} forEach units _grupouav;
			private _uwp0 = _grupouav addWayPoint [_position,0];
			_uwp0 setWaypointBehaviour "AWARE";
			_uwp0 setWaypointType "MOVE";
			sleep 5;
		};

		for "_i" from 1 to 3 do {
			private _toUse = "transportHelis";  // last attack is always a transport

			// first 2 rounds can be any unit, stronger the higher the treat
			if (_i < 3) then {
				if (["armedHelis"] call AS_fnc_AAFarsenal_count > 0) then {
					_toUse = "armedHelis";
				};
				if (_threatEvalAir > 15 and (["planes"] call AS_fnc_AAFarsenal_count > 0)) then {
					_toUse = "planes";
				};
			};
			([_toUse, _origin_pos, _position] call AS_fnc_createAirAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
			_groups append _groups1;
			_vehicles append _vehicles1;
			sleep 15;
		};
	};

	private _soldiers = [];
	{_soldiers append (units _x)} forEach _groups;

	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
	[_mission, "origin_pos", _origin_pos] call AS_spawn_fnc_set;
    [_mission, "resources", [_task, _groups, _vehicles, []]] call AS_spawn_fnc_set;
	[_mission, "soldiers", _soldiers] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	private _soldiers = [_mission, "soldiers"] call AS_spawn_fnc_get;
	private _groups = ([_mission, "resources"] call AS_spawn_fnc_get) select 1;

	private _max_incapacitated = round ((count _soldiers)/2);
	private _max_time = time + 60*60;

	private _fnc_missionFailedCondition = {_location call AS_fnc_location_side != "FIA"};
	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_fnc_mission_fail", 2];
	};
	private _fnc_missionSuccessfulCondition = {
		{not alive _x or captive _x} count _soldiers > _max_incapacitated or
		{time > _max_time}
	};
	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_fnc_mission_success", 2];

		private _origin_pos = [_mission, "origin_pos"] call AS_spawn_fnc_get;

		{_x doMove _origin_pos} forEach _soldiers;
		{
			private _wpRTB = _x addWaypoint [_origin_pos, 0];
			_x setCurrentWaypoint _wpRTB;
		} forEach _groups;
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

private _fnc_clean = {
	params ["_mission"];
	private _location = _mission call AS_fnc_mission_location;
	[_location, true] call AS_fnc_location_despawn;
	_mission call AS_mission_fnc_clean;
};

AS_mission_defendLocation_states = ["initialize", "spawn", "run", "clean"];
AS_mission_defendLocation_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	_fnc_clean
];
