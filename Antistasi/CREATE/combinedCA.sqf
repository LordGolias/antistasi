#include "../macros.hpp"
params ["_mrkdestino"];

private _posdestino = _mrkdestino call AS_fnc_location_position;

private _grupos = [];
private _soldados = [];
private _pilotos = [];
private _vehiculos = [];

private _prestigeCSAT = AS_P("prestigeCSAT");

private _base = [_posdestino] call findBasesForCA;
private _aeropuerto = [_posdestino] call findAirportsForCA;

if ((_base=="") and (_aeropuerto=="")) exitWith {};

private _CSAT = false;
if ((random 100 < _prestigeCSAT) and (_prestigeCSAT >= 20) && !(server getVariable "blockCSAT")) then {
	_CSAT = true;
};

if ((_aeropuerto != "") or _CSAT) then {_threatEvalAir = [_posdestino] call AAthreatEval};

if (_base != "") then {_threatEvalLand = [_posdestino] call landThreatEval};

private _nombredest = [_mrkDestino] call localizar;
private _nombreorig = [_aeropuerto] call localizar;
private _markTsk = _aeropuerto;
if (_base != "") then {
	_nombreorig = [_base] call localizar;
	_markTsk = _base;
};

_tsk = ["AtaqueAAF",
	[side_blue,civilian],
	[format ["AAF Is attacking from the %1. Intercept them or we may loose a sector",_nombreorig], "AAF Attack", _mrkdestino],
	_posdestino,
	"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;
misiones pushbackUnique "AtaqueAAF"; publicVariable "misiones";
private _tiempo = time + 3600;

if (_CSAT) then {
	if (AS_P("resourcesAAF") > 20000) then {
		[-20000] remoteExec ["resourcesAAF",2];
		[5,0] remoteExec ["prestige",2];
	} else {
		[5,-20] remoteExec ["prestige",2]
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
		{[_x] spawn CSATinit; _pilotos pushBack _x} forEach _heliCrew;
		_grupos pushBack _grupoheli;
		_vehiculos pushBack _heli;
		[_heli, "CSAT"] call AS_fnc_initVehicle;

		if (not(_tipoVeh in opHeliTrans)) then {
			_wp1 = _grupoheli addWaypoint [_posdestino, 0];
			_wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
		}
		else {
			{_x setBehaviour "CARELESS"} forEach units _grupoheli;

			private _tipogrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
			private _grupo = [_posorigen, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados pushBack _x; [_x] spawn CSATinit} forEach units _grupo;
			_grupos pushBack _grupo;
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;
			if (((_posdestino call AS_location_type) in ["base","airfield"]) or (random 10 < _threatEvalAir)) then {
				[_heli,_grupo,_posdestino,_threatEvalAir] spawn airdrop;
			} else {
				if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then {
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
					private _landpos = [];
					_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
					_vehiculos pushBack _pad;

					[_grupoheli, _posorigen, _landpos, _mrkdestino, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
				} else {
					[_grupoheli, _posorigen, _posdestino, _mrkdestino, _grupo, 25*60] call fnc_QRF_fastrope;
				};
			};
		};
		sleep 15;
	};

	_tsk = ["AtaqueAAF",
		[side_blue,civilian],
		[format ["AAF and CSAT are attacking %2 from the %1. Intercept them or we may loose a sector",_nombreorig,_nombredest],
		"AAF Attack", _mrkdestino],
		_posdestino,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;
	[["TaskSucceeded", ["", format ["%1 under fire",_nombredest]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	//bombardeo aereo!!!
	[_mrkDestino] spawn {
		params ["_mrkDestino"];
		for "_i" from 0 to round (random 2) do {
			[_mrkdestino, selectRandom opCASFW] spawn airstrike;
			sleep 30;
		};
		if ((_mrkdestino call AS_fnc_location_type) in ["base","airfield"]) then {
			[_mrkdestino] spawn artilleria;
		};
	};
};


if (_base != "") then {
	[_base,60] call AS_fnc_location_increaseBusy;
	private _posorigen = _base call AS_fnc_location_position;
	private _size = _base call AS_fnc_location_size;

	// compute number of trucks based on the marker size
	private _nVeh = round (_size/30);
	if (_nVeh < 1) then {_nVeh = 1};

	// spawn them
	for "_i" from 1 to _nveh do {
		private _toUse = "trucks";
		if (_threatEval > 3 and (["apcs"] call AS_fnc_AAFarsenal_count > 0)) then {
			_toUse = "apcs";
		};
		if (_threatEval > 5 and (["tanks"] call AS_fnc_AAFarsenal_count > 0)) then {
			_toUse = "tanks";
		};
		([_toUse, _posorigen, _posdestino, _threatEval, _isMarker] call AS_fnc_createLandAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
		_soldados append _soldiers1;
		_grupos append _groups1;
		_vehiculos append _vehicles1;
		sleep 5;
	};
};

// check if we have capabilities to use air units
// decide to not use airfield if not enough air units or AA treat too high
if (_aeropuerto != "") then {
	private _transportHelis = count (["transportHelis"] call AS_fnc_AAFarsenal_all);
	private _armedHelis = count (["armedHelis"] call AS_fnc_AAFarsenal_all);
	private _planes = count (["planes"] call AS_fnc_AAFarsenal_all);
	// 1 transported + any other if _isMarker.
	if (_transportHelis < 1 or (_transportHelis + _armedHelis + _planes < 3)) then {
		_aeropuerto = "";
	};
};


if (_aeropuerto != "") then {
	[_aeropuerto,60] call AS_fnc_location_increaseBusy;
	if (_base != "") then {sleep ((_posorigen distance _posdestino)/16)};

	private _posorigen = _aeropuerto call AS_fnc_location_position;
	_posorigen set [2,300];

	// spawn a UAV
	if (AS_AAFarsenal_uav != "") then {
		private _uav = createVehicle [AS_AAFarsenal_uav, _posorigen, [], 0, "FLY"];
		_uav removeMagazines "6Rnd_LG_scalpel";
		_vehiculos pushBack _uav;
		[_uav, "AAF"] call AS_fnc_initVehicle;
		[_uav,"UAV"] spawn inmuneConvoy;
		[_uav,_posdestino] spawn VANTinfo;
		createVehicleCrew _uav;
		_soldados append crew _uav;
		_grupouav = group (crew _uav select 0);
		_grupos pushBack _grupouav;
		{[_x] spawn AS_fnc_initUnitAAF} forEach units _grupoUav;
		private _uwp0 = _grupouav addWayPoint [_posdestino,0];
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
		([_toUse, _posorigen, _posdestino] call AS_fnc_createAirAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
		_soldados append _soldiers1;
		_grupos append _groups1;
		_vehiculos append _vehicles1;
		sleep 15;
	};
};


private _solMax = round ((count _soldados)/3);


waitUntil {sleep 5;
	(({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or
	({alive _x} count _soldados < _solMax) or
	(time > _tiempo) or
	(_mrkdestino call AS_fnc_location_side == "FIA")
};

if (_mrkdestino call AS_fnc_location_side == "FIA") then
	{
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posdestino,"BLUFORSpawn"] call distanceUnits);
	[5,AS_commander] call playerScoreAdd;
	if (!_CSAT) then
		{
		_tsk = ["AtaqueAAF",
			[side_blue,civilian],
			[format ["AAF Is attacking from %1. Intercept them or we may loose a sector",_nombreorig],
			"AAF Attack",_mrkdestino], _posdestino,
			"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
		}
	else
		{
		_tsk = ["AtaqueAAF",
			[side_blue,civilian],
			[format ["AAF and CSAT are attacking %2 from %1. Intercept them or we may loose a sector",_nombreorig,_nombredest],
			"AAF Attack",_mrkdestino], _posdestino,
			"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
		};
	{_x doMove _posorigen} forEach _soldados;
	{_wpRTB = _x addWaypoint [_posorigen, 0]; _x setCurrentWaypoint _wpRTB} forEach _grupos;
	}
else
	{
	[-10,AS_commander] call playerScoreAdd;
	if (!_CSAT) then
		{
		_tsk = ["AtaqueAAF",
			[side_blue,civilian],
			[format ["AAF Is attacking from %1. Intercept them or we may loose a sector",_nombreorig],
			"AAF Attack",_mrkdestino], _posdestino,
			"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
		}
	else
		{
		_tsk = ["AtaqueAAF",
			[side_blue,civilian],
			[format ["AAF and CSAT are attacking %2 from %1. Intercept them or we may loose a sector",_nombreorig,_nombredest],
			"AAF Attack",_mrkdestino], _posdestino,
			"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
		};
	waitUntil {sleep 1; !(_mrkdestino call AS_fnc_location_spawned)};
	};

if (cuentaCA < 0) then {
	cuentaCA = 600;
};

[2700] remoteExec ["timingCA",2];

sleep 30;

[0,_tsk] spawn borrarTask;

{
waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _soldados;
{
waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _pilotos;

{
waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _vehiculos;
{
if (!([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
} forEach _vehiculos;
{deleteGroup _x} forEach _grupos;
