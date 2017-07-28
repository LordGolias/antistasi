#include "../macros.hpp"
params ["_mission"];

private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _foundSuitablePlace = false;
private _posCmp = "";
private _dirveh = 0;
{
	// roads farther than 150m and closer than 300m
	private _road = _x;
	if ((_road distance _position > 150) and (_road distance _position < 300)) then {
		private _road2 = (_road nearRoads 5) select 0;
		if (!isNil "_road2") then {
			private _p2 = getPos ((roadsConnectedto _road2) select 0);
			_posCmp = [_road, 8, ([_road,_p2] call BIS_fnc_DirTo) + 90] call BIS_Fnc_relPos;
			_dirveh = [_posCmp,_road] call BIS_fnc_DirTo;
			if (count (nearestObjects [_posCmp, [], 6]) < 1) then {
				_foundSuitablePlace = true;
			};
		};
	};
	if _foundSuitablePlace exitWith {};
} forEach (([_location, "roads"] call AS_fnc_location_get) call AS_fnc_shuffle);

if not _foundSuitablePlace exitWith {
	[[petros, "globalChat", "Dealer cancelled the deal."],"commsMP"] call BIS_fnc_MP;
	_mission call AS_fnc_mission_remove;
};

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _nombredest = [_location] call localizar;

private _tskTitle = localize "Str_tsk_fndExp";
private _tskDesc = format [localize "Str_tskDesc_fndExp",_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posCmp,"CREATED",5,true,true,"Find"] call BIS_fnc_setTask;

private _groups = [];
private _vehicles = [];

private _fnc_clean = {
	[_groups, _vehicles, []] call AS_fnc_cleanResources;
	expCrate = "";
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _objs = [_posCmp, _dirveh, call (compile (preprocessFileLineNumbers "Compositions\cmpExp.sqf"))] call BIS_fnc_ObjectsMapper;
_vehicles append _objs;

private _groupDev = createGroup civilian;
private _dealer = _groupDev createUnit ["C_Nikos", [0,0,0], [], 0.9, "NONE"];
_dealer allowDamage false;
_dealer setPos _posCmp;
_dealer setDir _dirveh;
_dealer removeWeaponGlobal (primaryWeapon _dealer);
_dealer setIdentity "Devin";
_dealer disableAI "MOVE";
_dealer setunitpos "up";

{
	call {
		if (str typeof _x find "Land_PlasticCase_01_medium_F" > -1) exitWith {expCrate = _x; [expCrate] call emptyCrate;};
		if (str typeof _x find "Box_Syndicate_Wps_F" > -1) exitWith { [_x] call emptyCrate;};
		if (str typeof _x find "Box_IED_Exp_F" > -1) exitWith { [_x] call emptyCrate;};
	};
} forEach _objs;

private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or !(alive _dealer)};
private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posCmp,"FAILED",5,true,true,"Find"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_fail", 2];
};
private _fnc_missionSuccessfulCondition = {
	{((side _x isEqualTo side_blue) or (side _x isEqualTo civilian)) and
	  (_x distance _dealer < 10)} count allPlayers > 0
};
private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_posCmp,"SUCCEEDED",5,true,true,"Find"] call BIS_fnc_setTask;
	[[_dealer,"buy_exp"],"flagaction"] call BIS_fnc_MP;

	_mission remoteExec ["AS_fnc_mission_success", 2];
};

private _missionStartCondition = {
	{_x distance _dealer < 200} count (allPlayers - hcArray) > 0
};

waitUntil {sleep 1; False or _missionStartCondition or _fnc_missionFailedCondition};

_dealer allowDamage true;
["spawnCSAT", _posCmp, _location, 15, "transport", "small"] remoteExec ["enemyQRF",HCattack];

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;

waitUntil {sleep 10; call _fnc_missionFailedCondition};

[[_dealer,"remove"],"flagaction"] call BIS_fnc_MP;
if (alive _dealer) then {
	_dealer enableAI "ANIM";
	_dealer enableAI "MOVE";
	_dealer stop false;
	_dealer doMove ((selectRandom ("resource" call AS_fnc_location_T)) call AS_fnc_location_position);
};

call _fnc_clean;
