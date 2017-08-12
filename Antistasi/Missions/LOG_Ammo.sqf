params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _size = _location call AS_fnc_location_size;

private _tiempolim = 60;  // 1h
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_logAmmo";
private _tskDesc = format [localize "STR_tskDesc_logAmmo", [_location] call localizar, numberToDate [2035,_fechalimnum] select 3, numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"rearm"] call BIS_fnc_setTask;

private _groups = [];
private _vehicles = [];
private _markers = [];

private _fnc_clean = {
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {dateToNumber date > _fechalimnum};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"rearm"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
	call _fnc_clean;
};

waitUntil {sleep 1;False or _fnc_missionFailedCondition or (_location call AS_fnc_location_spawned)};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

private _pos = [];
while {count _pos > 0} do {
	_pos = _position findEmptyPosition [10,_size, vehAmmo];
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
	private _tipoGrupo = [infGarrisonSmall, "AAF"] call fnc_pickGroup;
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
	_task = [_mission, [side_blue,civilian], [_tskDesc,_tskTitle,_location], _position, "SUCCEEDED",5,true,true,"rearm"] call BIS_fnc_setTask;
	[_mission, getPos _truck] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

_fnc_missionFailedCondition = {(not alive _truck) or {dateToNumber date > _fechalimnum}};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
