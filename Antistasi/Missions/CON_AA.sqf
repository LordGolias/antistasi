if (!isServer and hasInterface) exitWith{};
params ["_location", "_source"];

private _posicion = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;

_tskTitle = localize "STR_tsk_CONOPAA";
_tskDesc = localize "STR_tskDesc_CONOPAA";

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

_tiempolim = 90;//120
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_tsk = ["CON",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
	_tskTitle,_location],_posicion,"CREATED",5,true,true,"Target"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

waitUntil {sleep 1;
	(dateToNumber date > _fechalimnum) or
	(_location call AS_fnc_location_side == "FIA")};

if (dateToNumber date > _fechalimnum) then {
	_tsk = ["CON",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
		_tskTitle,_location],_posicion,"FAILED",5,true,true,"Target"] call BIS_fnc_setTask;
	[5,0,_posicion] remoteExec ["citySupportChange",2];
	[-600] remoteExec ["timingCA",2];
	[-10,AS_commander] call playerScoreAdd;
};

if (_location call AS_fnc_location_side == "FIA") then {
	sleep 10;
	_tsk = ["CON",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
		_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Target"] call BIS_fnc_setTask;
	[0,200] remoteExec ["resourcesFIA",2];
	[-5,0,_posicion] remoteExec ["citySupportChange",2];
	[600] remoteExec ["timingCA",2];
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posicion,"BLUFORSpawn"] call distanceUnits);
	[10,AS_commander] call playerScoreAdd;
	// BE module
	if (hayBE) then {
		["mis"] remoteExec ["fnc_BE_XP", 2];
	};
	// BE module
};

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val - 1, true];
};

[1200,_tsk] spawn borrarTask;
