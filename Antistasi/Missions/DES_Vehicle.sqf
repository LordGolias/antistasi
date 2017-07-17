#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};
params ["_location", "_source"];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;
private _nombredest = [_location] call localizar;

if (_source == "mil") then {
	private _val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tipoVeh = "";
private _texto = "";

private _tanks = ["tanks"] call AS_fnc_AAFarsenal_all;
if (count _tanks > 0) then {
	_tipoVeh = selectRandom _tanks;
	_texto = "Enemy Tank";
} else {
	_tipoVeh = selectRandom (["apcs"] call AS_fnc_AAFarsenal_valid);
	_texto = "Enemy IFV";
};

private _tskTitle = localize "STR_tsk_DesVehicle";
private _tskDesc = format [localize "STR_tskDesc_DesVehicle",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_texto];

private _tsk = ["DES",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

private _group = grpNull;
private _veh = objNull;

private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;

	if (_source == "mil") then {
		private _val = server getVariable "milActive";
		server setVariable ["milActive", _val - 1, true];
	};

	if (not isNull _group) then {
		[[_group], [_veh]] call AS_fnc_cleanResources;
	};
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["DES",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[-5,-100] remoteExec ["resourcesFIA",2];
	[5,0,_posicion] remoteExec ["citySupportChange",2];
	if (_tipoVeh == opSPAA) then {[0,-3] remoteExec ["prestige",2]};
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

waitUntil {sleep 1; False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// spawn vehicle and crew
private _pos = _posicion findEmptyPosition [10,60,_tipoVeh];
_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
_veh setDir random 360;
[_veh, "AAF"] call AS_fnc_initVehicle;

_group = createGroup side_green;
for "_i" from 1 to 3 do {
	private _unit = ([_pos, 0, sol_CREW, _group] call bis_fnc_spawnvehicle) select 0;
	[_unit] spawn AS_fnc_initUnitAAF;
	sleep 2;
};

private _fnc_missionSuccessfulCondition = {
	(not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)
};

private _fnc_missionSuccessful = {
	_tsk = ["DES",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[0,300] remoteExec ["resourcesFIA",2];
	[2,0] remoteExec ["prestige",2];
	if (_tipoVeh == opSPAA) then {[3,3] remoteExec ["prestige",2]; [0,10,_posicion] remoteExec ["citySupportChange",2]} else {[0,5,_posicion] remoteExec ["citySupportChange",2]};
	[1200] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	{if (_x distance _veh < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

private _fnc_becomeAwareCondition = {
	// condition for the crew to become aware of danger
	({leader _group knowsAbout _x > 1.4} count ([AS_P("spawnDistance"),0,leader _group,"BLUFORSpawn"] call distanceUnits) > 0)
};

waitUntil {sleep 1;
	False or _fnc_becomeAwareCondition or _fnc_missionSuccessfulCondition or _fnc_missionFailedCondition
};

if (call _fnc_becomeAwareCondition) then {
	_group addVehicle _veh;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
