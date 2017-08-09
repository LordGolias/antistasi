#include "../macros.hpp"
params ["_location", ["_fromBase", ""]];

private _debug_prefix = format ["patrolCA from '%1' to '%2' cancelled: ", _fromBase, _location];
if (server getVariable "blockCSAT") exitWith {
	private _message = " blocked";
	AS_ISDEBUG(_debug_prefix + _message);
};

private _isDirectAttack = false;
private _base = "";
private _aeropuerto = "";

if (_fromBase != "") then {
	_isDirectAttack = true;
	if (_fromBase call AS_fnc_location_type == "airfield") then {
		_aeropuerto = _base;
		_base = "";
	} else {
		_base = _fromBase;
	};
};

if ((!_isDirectAttack) and (diag_fps < AS_P("minimumFPS"))) exitWith {
	private _message = "minimumFPS";
	AS_ISDEBUG(_debug_prefix + _message);
};

private _isLocation = false;
private _exit = false;
private _position = "";
if (typeName _location == typeName "") then {
	_isLocation = true;
	_position = _location call AS_fnc_location_position;
} else {
	_position = _location;
};

if (!_isDirectAttack and !(_position call radioCheck)) exitWith {
	private _message = "no radio contact";
	AS_ISDEBUG(_debug_prefix + _message);
};

if (_isLocation and !_isDirectAttack and (_location in smallCAmrk)) exitWith {
	private _message = "location being patrolled";
	AS_ISDEBUG(_debug_prefix + _message);
};

private _exit = false;
if (!_isLocation) then {
	// do not patrol closeby patrol locations.
	_closestPatrolPosition = [smallCApos, _position] call BIS_fnc_nearestPosition;
	if (_closestPatrolPosition distance _position < (AS_P("spawnDistance")/2)) exitWith {_exit = true;};

	// do not patrol closeby to patrolled markers.
	if (count smallCAmrk > 0) then {
		_closestPatrolMarker = [smallCAmrk, _position] call BIS_fnc_nearestPosition;
		if ((_closestPatrolMarker call AS_fnc_location_position) distance _position < (AS_P("spawnDistance")/2)) then {_exit = true;};
	};
};

if (_exit) exitWith {
	private _message = "nearby being patrolled";
	AS_ISDEBUG(_debug_prefix + _message);
};

// select base to attack from.
if (!_isDirectAttack) then {
	_base = [_position] call findBasesForCA;
	if (_base == "") then {_aeropuerto = [_position] call findAirportsForCA};
};

// check if CSAT will help.
private _hayCSAT = false;
if ((_base == "") and (_aeropuerto == "") and (random 100 < AS_P("CSATsupport"))) then {
	_hayCSAT = true;
};

if ((_base == "") and (_aeropuerto == "") and (!_hayCSAT)) exitWith {
	private _message = "no bases close to attack";
	AS_ISDEBUG(_debug_prefix + _message);
};  // if no way to create patrol, exit.

// Compute threat and decide to use bases airfields or none.
private _threatEval = 0;

// decide to not use airfield if not enough air units or AA treat too high
if (_aeropuerto != "") then {
	private _transportHelis = count (["transportHelis"] call AS_fnc_AAFarsenal_all);
	private _armedHelis = count (["armedHelis"] call AS_fnc_AAFarsenal_all);
	private _planes = count (["planes"] call AS_fnc_AAFarsenal_all);
	// 1 transported + any other if _isLocation.
	if (_transportHelis < 1 or _isLocation and (_transportHelis + _armedHelis + _planes < 2)) then {
		_aeropuerto = "";
	};

	// decide to not send air units if treat of AA is too high.
	if (_aeropuerto != "" and !_isDirectAttack) then {
		_threatEval = [_position] call AAthreatEval;
		if (_threatEval > 15 and _planes == 0) then {
			_aeropuerto = "";
		};
	};
};

// decide to not send if treat is too high.
if (_base != "") then {
	_threatEval = [_position] call landThreatEval;
	private _trucks = count (["trucks"] call AS_fnc_AAFarsenal_all);
	private _apcs = count (["apcs"] call AS_fnc_AAFarsenal_all);
	private _tanks = count (["tanks"] call AS_fnc_AAFarsenal_all);

	if (!_isDirectAttack) then {
		if (_threatEval > 15 and _tanks == 0 or
			_threatEval > 5 and (_tanks + _apcs == 0) or
			(_tanks + _apcs + _trucks == 0)) then {
			_base = "";
		};
	};
};

if ((_base == "") and (_aeropuerto == "") and (!_hayCSAT)) exitWith {
	private _message = "threat too high or no arsenal";
	AS_ISDEBUG(_debug_prefix + _message);
};

/////////////////////////////////////////////////////////////////////////////
////////////////////// Checks passed. Build the patrol //////////////////////
/////////////////////////////////////////////////////////////////////////////

// save the marker or position
if (_isLocation) then {
	smallCAmrk pushBackUnique _location; publicVariable "smallCAmrk";
} else {
	smallCApos pushBack _position; publicVariable "smallCApos";
};

// lists of spawned stuff to delete in the end.
private _soldados = [];
private _vehiculos = [];
private _grupos = [];

if (_base != "") then {
	private _posorigen = _base call AS_fnc_location_position;
	_aeropuerto = "";
	_hayCSAT = false;
	if (!_isDirectAttack) then {[_base,20] call AS_fnc_location_increaseBusy;};

	private _toUse = "trucks";
	if (_threatEval > 3 and (["apcs"] call AS_fnc_AAFarsenal_count > 0)) then {
		_toUse = "apcs";
	};
	if (_threatEval > 5 and (["tanks"] call AS_fnc_AAFarsenal_count > 0)) then {
		_toUse = "tanks";
	};

	([_toUse, _posorigen, _position, _threatEval, _isLocation] call AS_fnc_createLandAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
	_soldados append _soldiers1;
	_grupos append _groups1;
	_vehiculos append _vehicles1;
};

if (_aeropuerto != "") then {
	if (!_isDirectAttack) then {[_aeropuerto,20] call AS_fnc_location_increaseBusy;};
	_posorigen = _aeropuerto call AS_fnc_location_position;
	_cuenta = 1;
	if (_isLocation) then {_cuenta = 2};
	for "_i" from 1 to _cuenta do {  // the attack has 2 units for a non-marker
		private _toUse = "transportHelis";  // last attack is always a transport

		// first attack (1/2) can be any unit, stronger the higher the treat
		if (_i < _cuenta) then {
			if (["armedHelis"] call AS_fnc_AAFarsenal_count > 0) then {
				_toUse = "armedHelis";
			};
			if (_threatEval > 15 and (["planes"] call AS_fnc_AAFarsenal_count > 0)) then {
				_toUse = "planes";
			};
		};
		([_toUse, _posorigen, _position] call AS_fnc_createAirAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
		_soldados = _soldados + _soldiers1;
		_grupos = _grupos + _groups1;
		_vehiculos = _vehiculos + _vehicles1;
		sleep 30;
		};
	};

if (_hayCSAT) then {
	private _posorigen = getMarkerPos "spawnCSAT";
	private _posorigen set [2,300];  // high in the skies
	for "_i" from 1 to 3 do {
		private _tipoVeh = "";
		if (_i == 3) then {
			_tipoVeh = selectRandom opHeliTrans;
		} else {
			if (_threatEval > 10) then {_tipoVeh = selectRandom (opAir - opHeliTrans)} else {_tipoVeh = selectRandom opAir};
		};
		private _pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
		if (count _pos == 0) then {_pos = _posorigen};

		([_pos, 0,_tipoVeh, side_red] call bis_fnc_spawnvehicle) params ["_heli", "_heliCrew", "_grupoheli"];
		_soldados = _soldados + _heliCrew;
		_grupos = _grupos + [_grupoheli];
		_vehiculos = _vehiculos + [_heli];
		[_heli] spawn CSATVEHinit;
		{[_x] spawn CSATinit} forEach _heliCrew;
		if (!(_tipoVeh in opHeliTrans)) then {  // attack heli
			private _wp1 = _grupoheli addWaypoint [_position, 0];
			private _wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
		} else {  // transport heli
			{_x setBehaviour "CARELESS";} forEach units _grupoheli;
			private _tipoGrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
			_grupo = [_posorigen, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados = _soldados + [_x]; [_x] spawn CSATinit} forEach units _grupo;
			_grupos = _grupos + [_grupo];
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;

			if (((_location call AS_fnc_location_type) in ["base", "airfield"]) or
			    (random 10 < _threatEval)) then {
				[_heli,_grupo,_position,_threatEval] spawn airdrop;
			} else {
				if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then {
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
					private _landpos = [];
					_landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
					_vehiculos = _vehiculos + [_pad];

					[_grupoheli, _posorigen, _landpos, _location, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;

					/* _wp0 = _grupoheli addWaypoint [_landpos, 0];
					_wp0 setWaypointType "TR UNLOAD";
					_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT';[vehicle this] call smokeCoverAuto"];
					[_grupoheli,0] setWaypointBehaviour "CARELESS";
					_wp3 = _grupo addWaypoint [_landpos, 0];
					_wp3 setWaypointType "GETOUT";
					_wp0 synchronizeWaypoint [_wp3];
					_wp4 = _grupo addWaypoint [_position, 1];
					_wp4 setWaypointType "SAD";
					_wp2 = _grupoheli addWaypoint [_posorigen, 1];
					_wp2 setWaypointType "MOVE";
					_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"]; */
					[_grupoheli,1] setWaypointBehaviour "AWARE";
					}
				else {
					[_heli,_grupo,_position,_posorigen,_grupoheli] spawn fastropeCSAT;
				};
			};
		};
		sleep 15;  // time between spawning choppers
	};
};

//// All units sent. Cleanup below.

if (_isLocation) then {
	private _solMax = round ((count _soldados)/3);
	private _tiempo = time + 3600;

	waitUntil {sleep 5;
		(({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or
		({alive _x} count _soldados < _solMax) or
		(_location call AS_fnc_location_side == "AAF") or
		(time > _tiempo)
	};

	smallCAmrk = smallCAmrk - [_location]; publicVariable "smallCAmrk";

	waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};
}
else {
	waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_position,"BLUFORSpawn"] call distanceUnits)};
	smallCApos = smallCApos - [_position]; publicVariable "smallCApos";
};

if (count _soldados > 0) then {
	{
		waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)};
		deleteVehicle _x;
	} forEach _soldados;
};

{deleteGroup _x} forEach _grupos;

if !(isNil {_vehiculos}) then {
	if (count _vehiculos > 0) then {
		{
			if (!([AS_P("spawnDistance"),1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
		} forEach _vehiculos;
	};
};
