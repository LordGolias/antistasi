if (!isServer and hasInterface) exitWith{};
params ["_location", ["_source",""]];

private _posicion = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
private _nombredest = [_location] call localizar;

if (_source == "civ") then {
	private _val = server getVariable "civActive";
	server setVariable ["civActive", _val + 1, true];
};
if (_source == "mil") then {
	private _val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

private _tiempolim = 90;
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
};

_tskDesc = format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _tsk = ["CON",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"CREATED",5,true,true,"Target"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;
	if (_source == "civ") then {
		private _val = server getVariable "civActive";
		server setVariable ["civActive", _val - 1, true];
	};
    if (_source == "mil") then {
        private _val = server getVariable "milActive";
		server setVariable ["milActive", _val - 1, true];
    };
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["CON",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"FAILED",5,true,true,"Target"] call BIS_fnc_setTask;
	[5,0,_posicion] remoteExec ["citySupportChange",2];
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {_location call AS_fnc_location_side == "FIA"};

private _fnc_missionSuccessful = {
	_tsk = ["CON",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Target"] call BIS_fnc_setTask;
	[0,200] remoteExec ["resourcesFIA",2];
	[-5,0,_posicion] remoteExec ["citySupportChange",2];
	[600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posicion,"BLUFORSpawn"] call distanceUnits);
	[10,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
