#include "../macros.hpp"
params ["_location", ["_fromBase", ""]];

private _debug_prefix = format ["patrolCA from '%1' to '%2' cancelled: ", _fromBase, _location];
if AS_S("blockCSAT") exitWith {
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

if (_isLocation and !_isDirectAttack and (_location in AS_P("patrollingLocations"))) exitWith {
	private _message = "location being patrolled";
	AS_ISDEBUG(_debug_prefix + _message);
};

private _exit = false;
if (!_isLocation) then {
	// do not patrol closeby patrol locations.
	private _closestPatrolPosition = [AS_P("patrollingPositions"), _position] call BIS_fnc_nearestPosition;
	if (_closestPatrolPosition distance _position < (AS_P("spawnDistance")/2)) exitWith {_exit = true;};

	// do not patrol closeby to patrolled markers.
	if (count AS_P("patrollingLocations") > 0) then {
		private _closestPatrolMarker = [AS_P("patrollingLocations"), _position] call BIS_fnc_nearestPosition;
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
////////////////////// Checks passed. spawn the patrol //////////////////////
/////////////////////////////////////////////////////////////////////////////

private _spawnName = format ["AAFpatrol", floor random 100];
[_spawnName, "AAFpatrol"] call AS_spawn_fnc_add;
[_spawnName, "location", _location] call AS_spawn_fnc_set;
[_spawnName, "base", _base] call AS_spawn_fnc_set;
[_spawnName, "airfield", _aeropuerto] call AS_spawn_fnc_set;
[_spawnName, "useCSAT", _hayCSAT] call AS_spawn_fnc_set;
[_spawnName, "isDirectAttack", _isDirectAttack] call AS_spawn_fnc_set;
[_spawnName, "threatEval", _threatEval] call AS_spawn_fnc_set;

[_spawnName] call AS_spawn_fnc_execute;
