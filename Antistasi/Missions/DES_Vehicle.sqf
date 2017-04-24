#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};
params ["_location", "_source"];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _nombredest = [_location] call localizar;

_tskTitle = localize "STR_tsk_DesVehicle";
_tskDesc = localize "STR_tskDesc_DesVehicle";

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

_tiempolim = 120;
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_tipoVeh = "";
_texto = "";

private _tanks = ["tanks"] call AS_fnc_AAFarsenal_all;
if (count _tanks > 0) then {
	_tipoVeh = selectRandom _tanks;
	_texto = "Enemy Tank";
} else {
	_tipoVeh = selectRandom (["apcs"] call AS_fnc_AAFarsenal_valid);
	_texto = "Enemy IFV";
};

_tsk = ["DES",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_texto],
	_tskTitle,_location],_posicion,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
_camionCreado = false;

waitUntil {sleep 1;(dateToNumber date > _fechalimnum) or (_location call AS_fnc_location_spawned)};

if (_location call AS_fnc_location_spawned) then
	{
	_camionCreado = true;
	_pos = [];
	if (_size > 40) then {_pos = [_posicion, 10, _size, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos} else {_pos = _posicion findEmptyPosition [10,60,_tipoVeh]};
	_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
	_veh allowdamage false;
	_veh setDir random 360;
	[_veh, "AAF"] call AS_fnc_initVehicle;

	_grupo = createGroup side_green;

	sleep 5;
	_veh allowDamage true;

	for "_i" from 1 to 3 do
		{
		_unit = ([_pos, 0, sol_CREW, _grupo] call bis_fnc_spawnvehicle) select 0;
		[_unit] spawn AS_fnc_initUnitAAF;
		sleep 2;
		};
	waitUntil {sleep 1;({leader _grupo knowsAbout _x > 1.4} count ([AS_P("spawnDistance"),0,leader _grupo,"BLUFORSpawn"] call distanceUnits) > 0) or (dateToNumber date > _fechalimnum) or (not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)};

	if ({leader _grupo knowsAbout _x > 1.4} count ([AS_P("spawnDistance"),0,leader _grupo,"BLUFORSpawn"] call distanceUnits) > 0) then {_grupo addVehicle _veh;};

	waitUntil {sleep 1;(dateToNumber date > _fechalimnum) or (not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)};

	if ((not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)) then
		{
		_tsk = ["DES",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_texto],
			_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		[0,300] remoteExec ["resourcesFIA",2];
		[2,0] remoteExec ["prestige",2];
		if (_tipoVeh == opSPAA) then {[3,3] remoteExec ["prestige",2]; [0,10,_posicion] remoteExec ["citySupportChange",2]} else {[0,5,_posicion] remoteExec ["citySupportChange",2]};
		[1200] remoteExec ["timingCA",2];
		{if (_x distance _veh < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
		[5,AS_commander] call playerScoreAdd;
		["mis"] remoteExec ["fnc_BE_XP", 2];
		};
	};
if (dateToNumber date > _fechalimnum) then
	{
	_tsk = ["DES",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_texto],
		_tskTitle,_location],_posicion,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[-5,-100] remoteExec ["resourcesFIA",2];
	[5,0,_posicion] remoteExec ["citySupportChange",2];
	if (_tipoVeh == opSPAA) then {[0,-3] remoteExec ["prestige",2]};
	[-600] remoteExec ["timingCA",2];
	[-10,AS_commander] call playerScoreAdd;
	};

[1200,_tsk] spawn borrarTask;

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val - 1, true];
};

waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};

if (_camionCreado) then
	{
	{deleteVehicle _x} forEach units _grupo;
	deleteGroup _grupo;
	if (!([AS_P("spawnDistance"),1,_veh,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _veh};
	};
