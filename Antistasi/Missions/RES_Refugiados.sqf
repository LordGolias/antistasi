if (!isServer and hasInterface) exitWith{};
params ["_location"];

private _position = _location call AS_fnc_location_position;
private _location_name = [_location] call localizar;
private _size = _location call AS_fnc_location_size;

private _tskTitle = localize "STR_tsk_resRefugees";
private _tskDesc = format [localize "STR_tskDesc_resRefugees", _location_name, A3_STR_INDEP];

private _POWs = [];

// get a house with at least 5 positions
private _houses = nearestObjects [_position, ["house"], _size];
private _house_positions = [];
private _house = _houses select 0;
while {count _house_positions < 5} do {
	_house = _houses call BIS_Fnc_selectRandom;
	_house_positions = [_house] call BIS_fnc_buildingPositions;
	if (count _house_positions < 5) then {
		_houses = _houses - [_house]
	};
};

private _tsk = ["RES",[side_blue,civilian],[_tskDesc,_tskTitle,_location],getPos _house,"CREATED",5,true,true,"run"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

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
	[[_unit,"refugiado"],"flagaction"] call BIS_fnc_MP;
	sleep 1;
};
{_x allowDamage true} forEach _POWs;

sleep 30;

[_house] spawn {
	params ["_house"];
	sleep (300 + random 1800);
	if ("RES" in misiones) then {[position _house] remoteExec ["patrolCA",HCattack]};
};

private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;

	[[_grupo]] call AS_fnc_cleanResources;
};

private _fnc_missionFailedCondition = {{alive _x} count _POWs < (count _POWs)/2};

private _fnc_missionFailed = {
	_tsk = ["RES",[side_blue,civilian],[_tskDesc,_tskTitle,_location_name],getPos _house,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
	[count _POWs,0] remoteExec ["prestige",2];
	[0,-15,_position] remoteExec ["citySupportChange",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {{(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _POWs > ({alive _x} count _POWs) / 2};

private _fnc_missionSuccessful = {
	_tsk = ["RES",[side_blue,civilian],[_tskDesc,_tskTitle,_location_name],getPos _house,"SUCCEEDED",5,true,true,"run"] call BIS_fnc_setTask;
	private _hr = {alive _x} count _POWs;
	[_hr,0] remoteExec ["resourcesFIA",2];
	[0,_hr,_location] remoteExec ["citySupportChange",2];
	[_hr,0] remoteExec ["prestige",2];
	{if (_x distance getMarkerPos "FIA_HQ" < 500) then {[_hr,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[round (_hr/2),AS_commander] call playerScoreAdd;
	{[_x] join _grupo; [_x] orderGetin false} forEach _POWs;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
