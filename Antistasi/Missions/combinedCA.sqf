#include "../macros.hpp"
params ["_location"];

private _debug_prefix = format ["combinedCA from '%1' to '%2' cancelled: ", _location];
if AS_S("blockCSAT") exitWith {
	private _message = "blocked";
	AS_ISDEBUG(_debug_prefix + _message);
};

private _position = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;

private _base = [_position] call findBasesForCA;
private _aeropuerto = [_position] call findAirportsForCA;

// check if we have capabilities to use air units
// decide to not use airfield if not enough air units
if (_aeropuerto != "") then {
	private _transportHelis = count (["transportHelis"] call AS_fnc_AAFarsenal_all);
	private _armedHelis = count (["armedHelis"] call AS_fnc_AAFarsenal_all);
	private _planes = count (["planes"] call AS_fnc_AAFarsenal_all);
	// 1 transported + any other if _isMarker.
	if (_transportHelis < 1 or (_transportHelis + _armedHelis + _planes < 3)) then {
		_aeropuerto = "";
	};
};

if ((_base=="") and (_aeropuerto=="")) exitWith {
	private _message = "no available bases nor airports";
	AS_ISDEBUG(_debug_prefix + _message);
};

////////////// Mission will start //////////////

// check whether CSAT will support
private _CSAT = false;
private _prestigeCSAT = AS_P("CSATsupport");
if ((random 100 < _prestigeCSAT) and (_prestigeCSAT >= 20) and not AS_S("blockCSAT")) then {
	_CSAT = true;
};

private _nombreorig = if (_base != "") then {
	[_base] call localizar
} else {
	[_aeropuerto] call localizar
};

private _tskTitle = "AAF Attack";
private _tskDesc = "AAF is attacking %1. Defend it or we lose it";
if _CSAT then {
	_tskDesc = "AAF and CSAT are attacking %1. Defend it or we lose it";
};
_tskDesc = format [_tskDesc,_nombreorig];

private _mission = ["aaf_attack", _location] call AS_fnc_mission_add;
[_mission, "status", "active"] call AS_fnc_mission_set;
private _task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;

private _grupos = [];
private _vehiculos = [];

private _fnc_clean = {
	[_grupos, _vehiculos] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

////////////// Spawn stuff //////////////


private _threatEvalAir = 0;
if (_aeropuerto != "" or _CSAT) then {_threatEvalAir = [_position] call AAthreatEval};

private _threatEvalLand = 0;
if (_base != "") then {_threatEvalLand = [_position] call landThreatEval};


if (_CSAT) then {
	if (AS_P("resourcesAAF") > 20000) then {
		[-20000] remoteExec ["resourcesAAF",2];
		[5,0] remoteExec ["AS_fnc_changeForeignSupport",2];
	} else {
		[5,-20] remoteExec ["AS_fnc_changeForeignSupport",2]
	};
	private _posorigen = getMarkerPos "spawnCSAT";
	_posorigen set [2,300];

	private _cuenta = 3;
	if ((_base == "") or (_aeropuerto == "")) then {_cuenta = 6};

	for "_i" from 1 to _cuenta do {
		private _tipoVeh = "";
		if (_i == _cuenta) then {
			_tipoVeh = selectRandom opHeliTrans;
		} else {
			_tipoVeh = selectRandom opAir;
		};
		private _timeOut = 0;
		private _pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
		while {_timeOut < 60} do {
			if (count _pos > 0) exitWith {};
			_timeOut = _timeOut + 1;
			_pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
			sleep 1;
		};
		if (count _pos == 0) then {_pos = _posorigen};

		private _vehicle = [_posorigen, 0, _tipoVeh, side_red] call bis_fnc_spawnvehicle;
		private _heli = _vehicle select 0;
		private _heliCrew = _vehicle select 1;
		private _grupoheli = _vehicle select 2;
		{_x call AS_fnc_initUnitCSAT} forEach _heliCrew;
		_grupos pushBack _grupoheli;
		_vehiculos pushBack _heli;
		[_heli, "CSAT"] call AS_fnc_initVehicle;

		if (not(_tipoVeh in opHeliTrans)) then {
			private _wp1 = _grupoheli addWaypoint [_position, 0];
			_wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
		} else {
			{_x setBehaviour "CARELESS"} forEach units _grupoheli;

			private _tipogrupo = [opGroup_Squad, "CSAT"] call fnc_pickGroup;
			private _grupo = [_posorigen, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _x call AS_fnc_initUnitCSAT} forEach units _grupo;
			_grupos pushBack _grupo;
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;
			if (((_position call AS_location_type) in ["base","airfield"]) or (random 10 < _threatEvalAir)) then {
				[_heli,_grupo,_position,_threatEvalAir] spawn airdrop;
			} else {
				if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then {
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
					private _landpos = [];
					_landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
					_vehiculos pushBack _pad;

					[_grupoheli, _posorigen, _landpos, _location, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
				} else {
					[_grupoheli, _posorigen, _position, _location, _grupo, 25*60] call fnc_QRF_fastrope;
				};
			};
		};
		sleep 15;
	};

	// drop artillery at bases or airfields
	[["TaskSucceeded", ["", format ["%1 under artillery fire",_nombredest]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
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


private _posorigen = [];
if (_base != "") then {
	[_base,60] call AS_fnc_location_increaseBusy;
	_posorigen = _base call AS_fnc_location_position;
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
		([_toUse, _posorigen, _position, _threatEvalLand] call AS_fnc_createLandAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
		_grupos append _groups1;
		_vehiculos append _vehicles1;
		sleep 5;
	};
};

if (_aeropuerto != "") then {
	[_aeropuerto,60] call AS_fnc_location_increaseBusy;
	if (_base != "") then {sleep ((_posorigen distance _position)/16)};

	_posorigen = _aeropuerto call AS_fnc_location_position;
	_posorigen set [2,300];

	// spawn a UAV
	if (AS_AAFarsenal_uav != "") then {
		private _uav = createVehicle [AS_AAFarsenal_uav, _posorigen, [], 0, "FLY"];
		_uav removeMagazines "6Rnd_LG_scalpel";
		_vehiculos pushBack _uav;
		[_uav, "AAF"] call AS_fnc_initVehicle;
		[_uav,"UAV"] spawn inmuneConvoy;
		[_uav,_position] spawn VANTinfo;
		createVehicleCrew _uav;
		private _grupouav = group (crew _uav select 0);
		_grupos pushBack _grupouav;
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
		([_toUse, _posorigen, _position] call AS_fnc_createAirAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
		_grupos append _groups1;
		_vehiculos append _vehicles1;
		sleep 15;
	};
};

private _soldiers = [];
{_soldiers append (units _x)} forEach _grupos;

private _max_incapacitated = round ((count _soldiers)/2);
private _max_time = time + 60*60;

private _fnc_missionFailedCondition = {_location call AS_fnc_location_side != "FIA"};
private _fnc_missionFailed = {
	_task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_fail", 2];
};
private _fnc_missionSuccessfulCondition = {
	{not alive _x or captive _x} count _soldiers > _max_incapacitated or
	{time > _max_time}
};
private _fnc_missionSuccessful = {
	_task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_success", 2];

	{_x doMove _posorigen} forEach _soldiers;
	{
		private _wpRTB = _x addWaypoint [_posorigen, 0];
		_x setCurrentWaypoint _wpRTB;
	} forEach _grupos;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
