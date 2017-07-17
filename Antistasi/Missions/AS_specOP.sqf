#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};
params ["_location", "_source"];

private _posicion = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;

if (_source == "mil") then {
	private _val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_ASSpecOp";
private _tskDesc = format [localize "STR_tskDesc_ASSpecOp",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _tsk = ["AS",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"CREATED",5,true,true,"Kill"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

private _mrkfin = createMarkerLocal [format ["specops%1", random 100],_posicion];
_mrkfin setMarkerShapeLocal "RECTANGLE";
_mrkfin setMarkerSizeLocal [500,500];
_mrkfin setMarkerTypeLocal "hd_warning";
_mrkfin setMarkerColorLocal "ColorRed";
_mrkfin setMarkerBrushLocal "DiagGrid";
_mrkfin setMarkerAlphaLocal 0;

private _grupo = [_posicion, side_red, [opGroup_SpecOps, side_red] call fnc_pickGroup] call BIS_Fnc_spawnGroup;
sleep 1;
private _uav = createVehicle [opUAVsmall, _posicion, [], 0, "FLY"];
createVehicleCrew _uav;
[leader _grupo, _mrkfin, "RANDOM", "SPAWNED", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
{[_x] spawn CSATinit; _x allowFleeing 0} forEach units _grupo;

private _grupoUAV = group (crew _uav select 1);
[leader _grupoUAV, _mrkfin, "SAFE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;

	if (_source == "mil") then {
		private _val = server getVariable "milActive";
		server setVariable ["milActive", _val - 1, true];
	};

	[[_grupo, _grupoUAV], [_uav], [_mrkfin]] call AS_fnc_cleanResources;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["AS",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"FAILED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[5,0,_posicion] remoteExec ["citySupportChange",2];
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {{alive _x} count units _grupo == 0};

private _fnc_missionSuccessful = {
	_tsk = ["AS",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[0,200] remoteExec ["resourcesFIA",2];
	[0,5,_posicion] remoteExec ["citySupportChange",2];
	[600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posicion,"BLUFORSpawn"] call distanceUnits);
	[10,AS_commander] call playerScoreAdd;
	[0,3] remoteExec ["prestige",2];

	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
