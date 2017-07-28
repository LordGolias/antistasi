params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = "";
private _tskDesc = "";

switch _type do {
    case "powerplant": {
        _tskTitle = localize "STR_tsk_CONPower";
        _tskDesc = localize "STR_tskDesc_CONPower"
    };
    case "hillAA": {
        _tskTitle = localize "STR_tsk_CONOPAA";
        _tskDesc = localize "STR_tskDesc_CONOPAA"
    };
    case "outpost": {
        _tskTitle = localize "STR_tsk_CONOP";
        _tskDesc = localize "STR_tskDesc_CONOP";
    };
	default {
		_tskTitle = "Take location";
		_tskDesc = "Clear enemy presence in %1 and capture it before %2:%3.";
	};
};

_tskDesc = format [_tskDesc,[_location] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Target"] call BIS_fnc_setTask;

private _fnc_clean = {
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"Target"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {_location call AS_fnc_location_side == "FIA"};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Target"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
