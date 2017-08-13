#include "../macros.hpp"
params ["_mission"];

private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _bankPosition = [AS_bankPositions, _position] call BIS_fnc_nearestPosition;
private _bank = (nearestObjects [_bankPosition, [], 25]) select 0;

private _posbase = getMarkerPos "FIA_HQ";

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _mrkfin = createMarker [format ["LOG%1", random 100], _position];
private _nombredest = [_location] call localizar;
_mrkfin setMarkerShape "ICON";

private _taskTitle = localize "STR_tsk_logBank";
private _taskDesc = format [localize "STR_tskDesc_logBank",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP];

private _task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_mrkfin],_position,"CREATED",5,true,true,"Interact"] call BIS_fnc_setTask;

private _truckType = selectRandom AS_FIA_vans;
private _truck = _truckType createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [1,50,_truckType]);
{_x reveal _truck} forEach (allPlayers - hcArray);
[_truck] spawn vehInit;
_truck setVariable ["destino",_nombredest,true];
_truck addEventHandler ["GetIn", {
	if (_this select 1 == "driver") then {
		private _texto = format ["Bring this truck to %1 Bank and park it in the main entrance",(_this select 0) getVariable "destino"];
		_texto remoteExecCall ["hint",_this select 2];
	};
}];

[_truck, "Mission Vehicle"] spawn inmuneConvoy;

private _mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _position];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [30,30];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerAlphaLocal 0;

private _tipoGrupo = [infSquad, "AAF"] call fnc_pickGroup;
private _grupo = [_position, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _mrk, "SAFE","SPAWNED", "NOVEH2", "FORTIFY"] execVM "scripts\UPSMON.sqf";
{[_x, false] spawn AS_fnc_initUnitAAF} forEach units _grupo;

_position = _bank buildingPos 1;

private _fnc_clean = {
	[_truck] call vaciar;
	[[_grupo], [_truck], [_mrk, _mrkfin]] call AS_fnc_cleanResources;

	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or (not alive _truck)};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_mrkfin],_position,"FAILED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_mrkfin],_position,"SUCCEEDED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

waitUntil {sleep 1; (_truck distance _position < 7) or _fnc_missionFailedCondition};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// once the truck arrives there, send a patrol and make AAF aware of the truck
[_position] remoteExec ["patrolCA",HCattack];

{
	private _fiaSoldier = _x;
	if (_fiaSoldier distance _truck < 300) then {
		if ((captive _fiaSoldier) and (isPlayer _fiaSoldier)) then {
			[player, false] remoteExec ["setCaptive", _fiaSoldier]
		};
		{
			_x reveal [_fiaSoldier, 4];
		} forEach units _grupo;
	};
} forEach ([AS_P("spawnDistance"), _position, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

private _fnc_loadCondition = {
	// The condition to allow loading the crates into the truck
	(_truck distance _position < 7) and {speed _truck < 1} and
	{{alive _x and not (_x call AS_fnc_isUnconscious)} count ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0} and
	{{(side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
};

private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";

// wait 2m or the mission to fail
[_truck, 120, _fnc_loadCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

{
	if (isPlayer _x) then {
		[petros,"hint","Park the truck in the base to finish this mission"] remoteExec ["commsMP",_x]
	};
} forEach ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

waitUntil {sleep 1; (_truck distance _posbase < 50) and speed _truck == 0 or _fnc_missionFailedCondition};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

waitUntil {sleep 1; speed _truck == 0};

call _fnc_missionSuccessful;
