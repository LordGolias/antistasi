#include "../macros.hpp"

private _prestigio = AS_P("prestigeNATO");
private _aeropuertos = (["airfield", "FIA"] call AS_fnc_location_TS) + ["spawnNATO"];

private _origen = [_aeropuertos,AS_commander] call BIS_fnc_nearestPosition;
private _orig = _origen call AS_fnc_location_position;

private _tiempolim = _prestigio;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _nombreorig = "the NATO Carrier";
if (_origen != "spawnNATO") then {
	_nombreorig = [_origen] call localizar
};

private _tskTitle = "NATO CAS";
private _tskDesc = format ["NATO is providing air support from %1. They will be under our command in 35s and until %2:%3.",_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _mission = ["nato_cas", ""] call AS_fnc_mission_add;
[_mission, "status", "active"] call AS_fnc_mission_set;
private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origen],_orig,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;

private _groups = [];
private _vehicles = [];

private _fnc_clean = {
	[_groups, _vehicles] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _tipoVeh = bluHeliArmed;
if (_prestigio > 70) then {
	_tipoVeh = bluCASFW;
} else {
	if (_prestigio > 30) then {
		_tipoVeh = bluHeliGunship;
	};
};

private _grupoHeli = createGroup side_blue;
_grupoHeli setVariable ["esNATO",true,true];
_grupoHeli setGroupId ["CAS"];
_groups pushBack _grupoHeli;

for "_i" from 1 to 3 do {
	private _helifn = [_orig, 0, selectRandom _tipoVeh, side_blue] call bis_fnc_spawnvehicle;
	private _heli = _helifn select 0;
	_vehicles pushBack _heli;
	private _heliCrew = _helifn select 1;
	private _grupoheliTmp = _helifn select 2;
	{[_x] spawn NATOinitCA; [_x] join _grupoHeli} forEach _heliCrew;
	deleteGroup _grupoheliTmp;
	[_heli, "NATO"] call AS_fnc_initVehicle;
	_heli setPosATL [getPosATL _heli select 0, getPosATL _heli select 1, 1000];
	_heli flyInHeight 300;
	sleep 10;
};
AS_commander hcSetGroup [_grupoHeli];
_grupoHeli setVariable ["isHCgroup", true, true];

private _fnc_missionFailedCondition = {({alive _x} count _vehicles == 0) or ({canMove _x} count _vehicles == 0)};
private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origen],_orig,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
};
private _fnc_missionSuccessfulCondition = {dateToNumber date > _fechalimnum};
private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origen],_orig,"SUCCEEDED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
