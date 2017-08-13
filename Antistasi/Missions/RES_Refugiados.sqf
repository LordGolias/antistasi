params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _size = _location call AS_fnc_location_size;

private _tskTitle = _mission call AS_fnc_mission_title;
private _tskDesc = format [localize "STR_tskDesc_resRefugees", [_location] call localizar, A3_STR_INDEP];

private _POWs = [];

// get a house with at least 5 positions
private _houses = nearestObjects [_position, ["house"], _size];
private _house_positions = [];
private _house = _houses select 0;
while {count _house_positions < 5} do {
	_house = selectRandom _houses;
	_house_positions = [_house] call BIS_fnc_buildingPositions;
	if (count _house_positions < 5) then {
		_houses = _houses - [_house]
	};
};

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],getPos _house,"CREATED",5,true,true,"run"] call BIS_fnc_setTask;

private _grupo = createGroup side_blue;

private _num = (count _house_positions) max 8;
for "_i" from 0 to _num - 1 do {
	private _unit = _grupo createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, _house_positions select _i, [], 0, "NONE"];
	_unit allowdamage false;
	_unit disableAI "MOVE";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "TARGET";
	_unit setBehaviour "CARELESS";
	_unit allowFleeing 0;
	_unit setSkill 0;
	_POWs pushBack _unit;
	[[_unit,"refugiado"],"AS_fnc_addAction"] call BIS_fnc_MP;
	sleep 1;
};
{_x allowDamage true} forEach _POWs;

[_position, _mission] spawn {
	params ["_position", "_mission"];
	sleep (5*60 + random (30*60));
	if (_mission call AS_fnc_mission_status == "active") then {[_position] remoteExec ["patrolCA",HCattack]};
};

private _fnc_clean = {
	[[_grupo]] call AS_fnc_cleanResources;

	sleep 30;
	[_task] call BIS_fnc_deleteTask;
	_mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {{alive _x} count _POWs < (count _POWs)/2};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],getPos _house,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
	[_mission,  {not alive _x or captive _x} count _POWs] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {{(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _POWs > ({alive _x} count _POWs) / 2};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],getPos _house,"SUCCEEDED",5,true,true,"run"] call BIS_fnc_setTask;
	[_mission,  {alive _x} count _POWs] remoteExec ["AS_fnc_mission_success", 2];

	{[_x] join _grupo; [_x] orderGetin false} forEach _POWs;

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
