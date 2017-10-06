#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = [AS_P("antenasPos_alive"),_location call AS_location_fnc_position] call BIS_fnc_nearestPosition;

	private _tiempolim = 120;
	private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];

	private _tskTitle = _mission call AS_mission_fnc_title;
	private _tskDesc = format [localize "STR_tskDesc_DesAntenna",
		[_location] call AS_fnc_location_name,
		numberToDate [2035,dateToNumber _fechalim] select 3,
		numberToDate [2035,dateToNumber _fechalim] select 4, (["AAF", "name"] call AS_fnc_getEntity)];

	[_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
	[_mission, "position", _position] call AS_spawn_fnc_set;
	[_mission, [_tskDesc,_tskTitle,_location], _position, "Destroy"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _position = [_mission, "position"] call AS_spawn_fnc_get;
	private _mrkfin = createMarker [format ["DES%1", random 100], _position];
	_mrkfin setMarkerShape "ICON";

	private _task = ([_mission, "resources"] call AS_spawn_fnc_get) select 0;
	[_mission, "resources", [_task, [[], [], [_mrkfin]]]] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _location = _mission call AS_mission_fnc_location;
	private _position = [_mission, "position"] call AS_spawn_fnc_get;

	private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;

	private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission] remoteExec ["AS_mission_fnc_fail", 2];
	};

	private _antenna = nearestBuilding _position;

	private _fnc_missionSuccessfulCondition = {(not alive _antenna) or (_location call AS_location_fnc_side == "FIA")};

	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		[_mission, _position] remoteExec ["AS_mission_fnc_success", 2];
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_destroyAntenna_states = ["initialize", "spawn", "run", "clean"];
AS_mission_destroyAntenna_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
