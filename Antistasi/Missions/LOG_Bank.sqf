#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};
params ["_bank"];

private _position = getPos _bank;
private _posbase = getMarkerPos "FIA_HQ";

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _ciudad = [call AS_fnc_location_cities, _position] call BIS_fnc_nearestPosition;
private _mrkfin = createMarker [format ["LOG%1", random 100], _position];
private _nombredest = [_ciudad] call localizar;
_mrkfin setMarkerShape "ICON";

private _tskTitle = localize "STR_tsk_logBank";
private _tskDesc = format [localize "STR_tskDesc_logBank",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP];

private _truck = "C_Van_01_box_F" createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [1,50,"C_Van_01_box_F"]);
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

private _tsk = ["LOG",[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_position,"CREATED",5,true,true,"Interact"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
private _mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _position];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [30,30];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerAlphaLocal 0;

private _tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
private _grupo = [_position, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _mrk, "SAFE","SPAWNED", "NOVEH2", "FORTIFY"] execVM "scripts\UPSMON.sqf";
{[_x, false] spawn AS_fnc_initUnitAAF} forEach units _grupo;

_position = _bank buildingPos 1;

private _fnc_clean = {
	{deleteVehicle _x} forEach units _grupo;
	deleteGroup _grupo;
	deleteMarker _mrk;
	deleteMarker _mrkfin;

	[_truck] call vaciar;
	deleteVehicle _truck;

	[1200,_tsk] spawn borrarTask;
};

private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or (not alive _truck)};

private _fnc_missionFailed = {
	_tsk = ["LOG",[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_position,"FAILED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[5000] remoteExec ["resourcesAAF",2];
	[-1800] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	_tsk = ["LOG",[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_position,"SUCCEEDED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[0,5000] remoteExec ["resourcesFIA",2];
	[-2,0] remoteExec ["prestige",2];
	[1800] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	{if (_x distance _truck < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

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
} forEach ([AS_P("spawnDistance"),0,_position,"BLUFORSpawn"] call distanceUnits);

private _fnc_loadCondition = {
	(_truck distance _position < 7) and ({(_x distance _truck < 50)} count units _grupo == 0)
};

// wait 2m or the mission to fail
[_truck, 120, _fnc_loadCondition, _fnc_missionFailedCondition] call AS_fnc_wait_or_fail;

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

{
	if (isPlayer _x) then {
		[petros,"hint","Park the truck in the base to finish this mission"] remoteExec ["commsMP",_x]
	};
} forEach ([80,0,_truck,"BLUFORSpawn"] call distanceUnits);

waitUntil {sleep 1; (_truck distance _posbase < 50) and speed _truck == 0 or _fnc_missionFailedCondition};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

waitUntil {sleep 1; speed _truck == 0};

call _fnc_missionSuccessful;
