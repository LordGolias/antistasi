#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};
params ["_location", "_posicion"];

private _nombredest = [_location] call localizar;
private _size = _location call AS_fnc_location_size;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_repAntenna";
private _tskDesc = format [localize "STR_tskDesc_repAntenna",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP];

private _tsk = ["REP",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";


private _veh = objNull;
private _group = grpNull;

private _fnc_clean = {
	[60,_tsk] spawn borrarTask;

	if (not isNull _veh) then {
		[[_group], [_veh]] call AS_fnc_cleanResources;
	};
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["REP",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	// if this mission fails, the antena is re-built.
	[-10000] remoteExec ["resourcesAAF",2];
	antenasMuertas = antenasMuertas - [_posicion];
	private _antena = nearestBuilding _posicion;
	if (isMultiplayer) then {_antena hideObjectGlobal true} else {_antena hideObject true};
	_antena = createVehicle ["Land_Communication_F", _posicion, [], 0, "NONE"];
	antenas = antenas + [_antena];
	publicVariable "antenas";
	private _mrkfin = createMarker [format ["Ant%1", count antenas], _posicion];
	_mrkfin setMarkerShape "ICON";
	_mrkfin setMarkerType "loc_Transmitter";
	_mrkfin setMarkerColor "ColorBlack";
	_mrkfin setMarkerText "Radio Tower";
	mrkAntenas pushBack _mrkfin;
	_antena addEventHandler ["Killed", {
		params ["_antena"];
		private _mrk = [mrkAntenas, _antena] call BIS_fnc_nearestPosition;
		antenas = antenas - [_antena];
		antenasmuertas = antenasmuertas + [getPos _antena];
		deleteMarker _mrk;
		[["TaskSucceeded", ["", "Radio Tower Destroyed"]], "BIS_fnc_showNotification"] call BIS_fnc_MP;
	}];

	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {not alive _veh or (_location call AS_fnc_location_side == "FIA")};

private _fnc_missionSuccessful = {
	_tsk = ["REP",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[2,0] remoteExec ["prestige",2];
	[1200] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

// wait for location to be spawned to spawn everything
waitUntil {sleep 1; False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// repair truck
private _pos = _posicion findEmptyPosition [10,60,selectRandom vehTruckBox];
_veh = createVehicle [selectRandom vehTruckBox, _pos, [], 0, "NONE"];
_veh allowdamage false;
_veh setDir random 360;
_veh allowDamage true;
[_veh, "AAF"] call AS_fnc_initVehicle;

// repair soldiers
private _group = createGroup side_green;
for "_i" from 1 to 3 do {
	private _unit = ([_pos, 0, sol_CREW, _group] call bis_fnc_spawnvehicle) select 0;
	[_unit] call AS_fnc_initUnitAAF;
	sleep 1;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
