#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

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
	_texto = "Enemy APC";
};

private _tskTitle = localize "STR_tsk_DesVehicle";
private _tskDesc = format [localize "STR_tskDesc_DesVehicle",[_location] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_texto];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;

private _group = grpNull;
private _veh = objNull;

private _fnc_clean = {
	if (not isNull _group) then {
		[[_group], [_veh]] call AS_fnc_cleanResources;
	};
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {
	(not alive _veh) or ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0)
};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[_mission, getPos _veh] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

waitUntil {sleep 1; False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// spawn vehicle and crew
private _pos = _position findEmptyPosition [10,60,_tipoVeh];
_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
_veh setDir random 360;
[_veh, "AAF"] call AS_fnc_initVehicle;

_group = createGroup side_red;
for "_i" from 1 to 3 do {
	private _unit = ([_pos, 0, sol_CREW, _group] call bis_fnc_spawnvehicle) select 0;
	[_unit] spawn AS_fnc_initUnitAAF;
	sleep 2;
};

private _fnc_becomeAwareCondition = {
	// condition for the crew to become aware of danger
	({leader _group knowsAbout _x > 1.4} count ([AS_P("spawnDistance"), leader _group, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0)
};

waitUntil {sleep 1;
	False or _fnc_becomeAwareCondition or _fnc_missionSuccessfulCondition or _fnc_missionFailedCondition
};

if (call _fnc_becomeAwareCondition) then {
	_group addVehicle _veh;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
