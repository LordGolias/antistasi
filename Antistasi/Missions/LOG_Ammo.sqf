if (!isServer and hasInterface) exitWith{};
params ["_location"];

private _posicion = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;
private _size = _location call AS_fnc_location_size;

private _tiempolim = 60;  // 1h
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_logAmmo";
private _tskDesc = format [localize "STR_tskDesc_logAmmo", _nombredest, numberToDate [2035,_fechalimnum] select 3, numberToDate [2035,_fechalimnum] select 4];

private _tsk = ["LOG",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"CREATED",5,true,true,"rearm"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

private _groups = [];
private _vehicles = [];
private _markers = [];

private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_tsk = ["LOG",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posicion,"FAILED",5,true,true,"rearm"] call BIS_fnc_setTask;
	[-1200] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

waitUntil {sleep 1;False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

private _pos = [];
while {true} do {
	_pos = _posicion findEmptyPosition [10,_size, vehAmmo];
	if (count _pos > 0) exitWith {};
	_size = _size + 20
};

private _truck = vehAmmo createVehicle _pos;
_vehicles pushBack _truck;
[_truck, "Convoy"] call AS_fnc_fillCrateAAF;

// patrol marker. To be deleted in the end
private _mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _pos];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [20,20];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerAlphaLocal 0;

// patrol groups
for "_i" from 1 to (2 + floor random 3) do {
	private _tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
	private _group = [_pos, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
	_groups append _group;
	if (random 10 < 33) then {
		private _perro = _group createUnit ["Fin_random_F",_pos,[],0,"FORM"];
		[_perro] call guardDog;
	};
	[leader _group, _mrk, "SAFE","SPAWNED", "NOVEH2"] execVM "scripts\UPSMON.sqf";
	{[_x, false] call AS_fnc_initUnitAAF} forEach units _group;
};

private _fnc_missionSuccessfulCondition = {({_x getVariable ["BLUFORSpawn",false]} count crew _truck > 0)};

private _fnc_missionSuccessful = {
	[position _truck] spawn patrolCA;
	_tsk = ["LOG",[side_blue,civilian], [_tskDesc,_tskTitle,_location], _posicion, "SUCCEEDED",5,true,true,"rearm"] call BIS_fnc_setTask;
	[0,300] remoteExec ["resourcesFIA",2];
	[1200] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

_fnc_missionFailedCondition = {(not alive _truck) or _fnc_missionFailedCondition};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
