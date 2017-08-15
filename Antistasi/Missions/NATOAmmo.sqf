#include "../macros.hpp"
params ["_mission"];

private _position = [_mission, "position"] call AS_fnc_mission_get;
private _support = [_mission, "NATOsupport"] call AS_fnc_mission_get;

private _tskTitle = localize "STR_tsk_NATOSupply";
private _tskDesc = localize "STR_tskDesc_NATOSupply";

private _mrkfin = createMarker [_mission, _position];
_mrkfin setMarkerShape "ICON";
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 60];
private _fechalimnum = dateToNumber _fechalim;

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_position,"CREATED",5,true,true,"rifle"] call BIS_fnc_setTask;

private _vehicles = [];
private _groups = [];

private _fnc_clean = {
	{AS_commander hcRemoveGroup _x} forEach _groups;
	[_groups, _vehicles, [_mrkFin]] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _origen = "spawnNATO";
private _orig = _origen call AS_fnc_location_position;


private _helifn = [_orig, 0, selectRandom bluHeliDis, side_blue] call bis_fnc_spawnvehicle;
private _heli = _helifn select 0;
private _grupoHeli = _helifn select 2;
_groups pushBack _grupoHeli;
{[_x] spawn NATOinitCA} forEach units _grupoHeli;
[_heli, "NATO"] call AS_fnc_initVehicle;
_vehicles pushBack _heli;
_heli setPosATL [getPosATL _heli select 0, getPosATL _heli select 1, 1000];
_heli disableAI "TARGET";
_heli disableAI "AUTOTARGET";
_heli flyInHeight 200;
_grupoHeli setCombatMode "BLUE";

AS_commander hcSetGroup [_grupoHeli];
_grupoHeli setVariable ["isHCgroup", true, true];

waitUntil {sleep 2; (_heli distance _position < 300) or {!canMove _heli} or {dateToNumber date > _fechalimnum}};

if (_heli distance _position < 300) then {
	private _chute = createVehicle ["B_Parachute_02_F", [0, 0, 0], [], 0, 'NONE'];
    _chute setPos [getPosASL _heli select 0, getPosASL _heli select 1, (getPosASL _heli select 2) - 50];
    private _crate = createVehicle ["B_supplyCrate_F", [0, 0, 0], [], 0, 'NONE'];
    _crate attachTo [_chute, [0, 0, -1.3]];
    [_crate, _support] call AS_fnc_fillCrateNATO;
    _vehicles append [_chute, _crate];
    private _wp3 = _grupoHeli addWaypoint [_orig, 0];
	_wp3 setWaypointType "MOVE";
	_wp3 setWaypointSpeed "FULL";
    waitUntil {position _crate select 2 < 1 || isNull _chute};
	private _humo = "SmokeShellBlue" createVehicle position _crate;
	_vehicles pushBack _humo;

    _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_position,"SUCCEEDED",5,true,true,"rifle"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
} else {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_position,"FAILED",5,true,true,"rifle"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
};

call _fnc_clean;
