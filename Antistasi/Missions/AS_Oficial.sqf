if (!isServer and hasInterface) exitWith {};
params ["_location", "_source"];

private _posicion = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;

if (_source == "mil") then {
	private _val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

private _tiempolim = 30;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_ASOfficer";
private _tskDesc = format [localize "STR_tskDesc_ASOfficer",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _tsk = ["AS",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"CREATED",5,true,true,"Kill"] call BIS_fnc_setTask;
misiones pushBack _tsk;
publicVariable "misiones";

private _grp = createGroup side_red;

private _oficial = ([_posicion, 0, opI_OFF, _grp] call bis_fnc_spawnvehicle) select 0;
private _piloto = ([_posicion, 0, opI_PIL, _grp] call bis_fnc_spawnvehicle) select 0;

_grp selectLeader _oficial;
[leader _grp, _location, "SAFE", "SPAWNED", "NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

{[_x] spawn CSATinit; _x allowFleeing 0} forEach units _grp;


private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;

	if (_source == "mil") then {
		private _val = server getVariable "milActive";
		server setVariable ["milActive", _val - 1, true];
	};

	[[_grp]] call AS_fnc_cleanResources;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["AS",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"FAILED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;
	[_location,-30] call AS_fnc_location_increaseBusy;

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {not alive _oficial};

private _fnc_missionSuccessful = {
	_tsk = ["AS",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[0,300] remoteExec ["resourcesFIA",2];
	[1800] remoteExec ["AS_fnc_changeSecondsforAAFattack", 2];
	{
		if (isPlayer _x) then {
			[10,_x] call playerScoreAdd
		}
	} forEach ([500,0,_posicion,"BLUFORSpawn"] call distanceUnits);
	[5,AS_commander] call playerScoreAdd;
	[_location,30] call AS_fnc_location_increaseBusy;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
