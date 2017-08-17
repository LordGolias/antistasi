#include "../macros.hpp"
params ["_mission"];

private _location = _mission call AS_fnc_mission_location;
private _position = [AS_P("antenasPos_dead"),_location call AS_fnc_location_position] call BIS_fnc_nearestPosition;

private _nombredest = [_location] call localizar;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = _mission call AS_fnc_mission_title;
private _tskDesc = format [localize "STR_tskDesc_repAntenna",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;

private _veh = objNull;
private _group = grpNull;

private _fnc_clean = {
	if (not isNull _veh) then {
		[[_group], [_veh]] call AS_fnc_cleanResources;
	};

	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[_mission, _position] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {not alive _veh or (_location call AS_fnc_location_side == "FIA")};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

// wait for location to be spawned to spawn everything
waitUntil {sleep 1; False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// repair truck
private _pos = _position findEmptyPosition [10,60,selectRandom vehTruckBox];
_veh = createVehicle [selectRandom vehTruckBox, _pos, [], 0, "NONE"];
_veh allowdamage false;
_veh setDir random 360;
_veh allowDamage true;
[_veh, "AAF"] call AS_fnc_initVehicle;

// repair soldiers
private _group = createGroup side_red;
for "_i" from 1 to 3 do {
	private _unit = ([_pos, 0, sol_CREW, _group] call bis_fnc_spawnvehicle) select 0;
	[_unit] call AS_fnc_initUnitAAF;
	sleep 1;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
