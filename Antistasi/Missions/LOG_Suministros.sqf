#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _taskTitle = localize "STR_task_logSupply";
private _taskDesc = format [localize "STR_taskDesc_logSupply",[_location] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_location],_position,"CREATED",5,true,true,"Heal"] call BIS_fnc_setTask;

private _pos = (getMarkerPos "FIA_HQ") findEmptyPosition [1,50,"C_Van_01_box_F"];

private _truck = "C_Van_01_box_F" createVehicle _pos;
[_truck, "FIA"] call AS_fnc_initVehicle;
{_x reveal _truck} forEach (allPlayers - hcArray);
[_truck,"Mission Vehicle"] spawn inmuneConvoy;

private _fnc_clean = {
	waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,_truck,"BLUFORSpawn"] call distanceUnits)) or ((_truck distance (getMarkerPos "FIA_HQ") < 60) && (speed _truck < 1))};
	[_truck] call vaciar;
	deleteVehicle _truck;

	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {
	(not alive _truck) or (dateToNumber date > _fechalimnum)
};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_location],_position,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_location],_position,"SUCCEEDED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

waitUntil {sleep 1; (_truck distance _position < 40) and (speed _truck < 1) or _fnc_missionFailedCondition};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

[_position] remoteExec ["patrolCA", HCattack];

private _fnc_unloadCondition = {
	(_truck distance _position < 40) and
	(speed _truck < 1) and
	({_x getVariable ["inconsciente",false]} count ([40,0,_truck,"BLUFORSpawn"] call distanceUnits) !=
	 count ([40,0,_truck,"BLUFORSpawn"] call distanceUnits)) and
	({(side _x == side_green) and (_x distance _truck < 50)} count allUnits == 0)
};

// make all FIA around the truck non-captive
{
	private _soldierFIA = _x;
	if (captive _soldierFIA) then {
		[_soldierFIA,false] remoteExec ["setCaptive",_soldierFIA];
	};
} forEach ([300,0,_truck,"BLUFORSpawn"] call distanceUnits);

{
	// make all enemies around notice the truck
	if ((side _x == side_green) and {_x distance _position < AS_P("spawnDistance")}) then {
		if (_x distance _position < 300) then {
			_x doMove position _truck;
		} else {
			_x reveal [_truck, 4];
		};
	};
	// send all nearby civilians to the truck
	if ((side _x == civilian) and {_x distance _position < AS_P("spawnDistance")} and {_x distance _position < 300}) then {_x doMove position _truck};
} forEach allUnits;

// eject and lock truck
{
	_x action ["eject", _truck];
} forEach (crew _truck);
sleep 1;
_truck lock 2;
{if (isPlayer _x) then {[_truck,true] remoteExec ["fnc_lockVehicle",_x];}} forEach ([100,0,_truck,"BLUFORSpawn"] call distanceUnits);
_truck engineOn false;

// wait for the truck to unload (2m) or the mission to fail
[_truck, 120, _fnc_unloadCondition, _fnc_missionFailedCondition] call AS_fnc_wait_or_fail;

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

call _fnc_missionSuccessful;
