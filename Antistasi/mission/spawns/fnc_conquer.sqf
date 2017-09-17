private _fnc_initialize = {
    params ["_mission"];
    private _location = _mission call AS_mission_fnc_location;
    private _position = _location call AS_location_fnc_position;
    private _type = _location call AS_location_fnc_type;

    private _tiempolim = 60;
    private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
    private _fechalimnum = dateToNumber _fechalim;

    private _tskTitle = _mission call AS_mission_fnc_title;
    private _tskDesc = "";

    switch _type do {
        case "powerplant": {
            _tskDesc = localize "STR_tskDesc_CONPower";
        };
        case "hillAA": {
            _tskDesc = localize "STR_tskDesc_CONOPAA";
        };
        case "outpost": {
            _tskDesc = localize "STR_tskDesc_CONOP";
        };
    	default {
    		_tskDesc = "Clear enemy presence in %1 and capture it before %2:%3.";
    	};
    };

    _tskDesc = format [_tskDesc,[_location] call AS_fnc_location_name,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

    [_mission, [_tskDesc,_tskTitle,_location], _position, "Target"] call AS_mission_spawn_fnc_saveTask;
    [_mission, "max_date", dateToNumber _fechalim] call AS_spawn_fnc_set;
};

private _fnc_spawn = {
    params ["_mission"];
    private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
    [_mission, "resources", [_task, [], [], []]] call AS_spawn_fnc_set;
};

private _fnc_run = {
    params ["_mission"];
    private _location = _mission call AS_mission_fnc_location;
    private _max_date = [_mission, "max_date"] call AS_spawn_fnc_get;
    private _fnc_missionFailedCondition = {dateToNumber date > _max_date};

    private _fnc_missionFailed = {
    	([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
    	_mission remoteExec ["AS_mission_fnc_fail", 2];
    };

    private _fnc_missionSuccessfulCondition = {_location call AS_location_fnc_side == "FIA"};

    private _fnc_missionSuccessful = {
    	([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
    	_mission remoteExec ["AS_mission_fnc_success", 2];
    };

    [_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_conquer_states = ["initialize", "spawn", "run", "clean"];
AS_mission_conquer_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
