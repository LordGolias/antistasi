if (!isServer and hasInterface) exitWith{};
private ["_antena"];

private _posicion = getPos _antena;
private _location = [call AS_fnc_location_all, _posicion] call BIS_fnc_nearestPosition;
private _nombredest = [_location] call localizar;

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_DesAntenna";
private _tskDesc = format [localize "STR_tskDesc_DesAntenna",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP];

private _mrkfin = createMarker [format ["DES%1", random 100], _posicion];
_mrkfin setMarkerShape "ICON";

private _tsk = ["DES",[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posicion,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";


private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;

	[[], [], [_mrkfin]] call AS_fnc_cleanResources;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["DES",[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posicion,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {(not alive _antena) or (_location call AS_fnc_location_side == "FIA")};

private _fnc_missionSuccessful = {
	sleep 15;
	_tsk = ["DES",[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posicion,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[5,-5] remoteExec ["prestige",2];
	[600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	{if (_x distance _posicion < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
