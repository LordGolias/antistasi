params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _POWs = [];

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_resPrisoners";
private _tskDesc = format [localize "STR_tskDesc_resPrisoners",[_location] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"run"] call BIS_fnc_setTask;

private _prisioners = 5 + round random 10;
private _grpPOW = createGroup side_blue;
for "_i" from 1 to _prisioners do {
	private _unit = _grpPOW createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, [_position, 5, random 360] call BIS_Fnc_relPos, [], 0, "NONE"];
	_unit allowDamage false;
	_unit setCaptive true;
	_unit disableAI "MOVE";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "TARGET";
	_unit setUnitPos "UP";
	_unit setBehaviour "CARELESS";
	_unit allowFleeing 0;
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	sleep 1;
	_POWS pushBack _unit;
	[[_unit, "prisionero"],"flagaction"] call BIS_fnc_MP;
};

sleep 5;

{_x allowDamage true} forEach _POWS;

private _fnc_clean = {
	[[_grpPOW]] call AS_fnc_cleanResources;

	sleep 30;
	[_task] call BIS_fnc_deleteTask;
	_mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {{alive _x} count _POWs < (count _POWs)/2};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
	[_mission,  {not alive _x or captive _x} count _POWs] remoteExec ["AS_fnc_mission_fail", 2];

	{_x setCaptive false} forEach _POWs;
};

private _fnc_missionSuccessfulCondition = {{(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _POWs > ({alive _x} count _POWs) / 2};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"run"] call BIS_fnc_setTask;
	[_mission,  {alive _x} count _POWs] remoteExec ["AS_fnc_mission_success", 2];

	{[_x] join _grpPOW; [_x] orderGetin false} forEach _POWs;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
