params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _missionType = _mission call AS_fnc_mission_type;

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = "";
private _tskDesc = "";
call {
	if (_missionType == "kill_officer") exitWith {
		_tskTitle = localize "STR_tsk_ASOfficer";
		_tskDesc = localize "STR_tskDesc_ASOfficer"
	};
	if (_missionType == "kill_specops") exitWith {
		_tskTitle = localize "STR_tsk_ASSpecOp";
		_tskDesc = localize "STR_tskDesc_ASSpecOp";
	};
};
_tskDesc = format [_tskDesc,[_location] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Kill"] call BIS_fnc_setTask;

private _resources = [[],[],[]];
private _target = objNull; // target: unit or group

call {
	if (_missionType == "kill_officer") exitWith {
		private _group = createGroup side_red;

		_target = ([_position, 0, opI_OFF, _group] call bis_fnc_spawnvehicle) select 0;
        ([_position, 0, opI_PIL, _group] call bis_fnc_spawnvehicle) select 0;

		_group selectLeader _target;
		[leader _group, _location, "SAFE", "SPAWNED", "NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

		{[_x] spawn CSATinit; _x allowFleeing 0} forEach units _group;

		_resources = [[_group]];
	};
	if (_missionType == "kill_specops") exitWith {
		private _mrkfin = createMarkerLocal [_mission,_position];
		_mrkfin setMarkerShapeLocal "RECTANGLE";
		_mrkfin setMarkerSizeLocal [500,500];
		_mrkfin setMarkerTypeLocal "hd_warning";
		_mrkfin setMarkerColorLocal "ColorRed";
		_mrkfin setMarkerBrushLocal "DiagGrid";
		_mrkfin setMarkerAlphaLocal 0;

		private _group = [_position, side_red, [opGroup_SpecOps, side_red] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
		private _uav = createVehicle [opUAVsmall, _position, [], 0, "FLY"];
		createVehicleCrew _uav;
		[leader _group, _mrkfin, "RANDOM", "SPAWNED", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		{[_x] spawn CSATinit; _x allowFleeing 0} forEach units _group;

		private _groupUAV = group (crew _uav select 1);
		[leader _groupUAV, _mrkfin, "SAFE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

		_resources = [[_group, _groupUAV], [_uav], [_mrkfin]];
        _target = _group;
	};
};

private _fnc_clean = {
	_resources call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	if (_missionType == "kill_specops") exitWith {
		[5,0,_position] remoteExec ["citySupportChange",2];
	};

	if (_missionType == "kill_officer") then {
		[_location,-30] call AS_fnc_location_increaseBusy;
	};

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {not alive _target};
if (typeName _target == "GROUP") then {
    _fnc_missionSuccessfulCondition = {{alive _x} count units _target == 0};
};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[0,200] remoteExec ["resourcesFIA",2];

	if (_missionType == "kill_specops") then {
		[0,5,_position] remoteExec ["citySupportChange",2];
		[600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	};
	if (_missionType == "kill_officer") then {
		[1800] remoteExec ["AS_fnc_changeSecondsforAAFattack", 2];
		[_location,30] call AS_fnc_location_increaseBusy;
	};

	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_position,"BLUFORSpawn"] call distanceUnits);
	[10,AS_commander] call playerScoreAdd;
	[0,3] remoteExec ["prestige",2];
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
