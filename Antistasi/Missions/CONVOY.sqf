#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _missionType = _mission call AS_fnc_mission_type;

private _origin = _position call findBasesForConvoy;
if (_origin == "") exitWith {
	hint "mission is no longer available";
	_mission call AS_fnc_mission_remove;
};
private _posbase = _origin call AS_fnc_location_position;

private _tiempolim = 120;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = "";
private _tskDesc = "";
private _tskIcon = "";
private _mainVehicleType = "";
call {
	if (_missionType == "convoy_money") exitWith {
		_tskTitle = localize "STR_tsk_CVY_Money";
		_tskDesc = localize "STR_tskDesc_CVY_Money";
		_tskIcon = "move";
		_mainVehicleType = "C_VAN_01_BOX_F";
	};
	if (_missionType == "convoy_supplies") exitWith {
		_tskTitle = localize "STR_tsk_CVY_Supply";
		_tskDesc = localize "STR_tskDesc_CVY_Supply";
		_tskIcon = "heal";
		_mainVehicleType = "C_VAN_01_BOX_F";
	};
	if (_missionType == "convoy_armor") exitWith {
		_tskTitle = localize "STR_tsk_CVY_Armor";
		_tskDesc = localize "STR_tskDesc_CVY_Armor";
		_tskIcon = "destroy";
		private _tanks = ["tanks"] call AS_fnc_AAFarsenal_all;
		if (count _tanks == 0) then {
			_tanks = ["apcs"] call AS_fnc_AAFarsenal_valid;
			diag_log format ["[AS] Error: convoy: tanks requested but not available", _mission];
		};
		_mainVehicleType = selectRandom _tanks;
	};
	if (_missionType == "convoy_ammo") exitWith {
		_tskTitle = localize "STR_tsk_CVY_Ammo";
		_tskDesc = localize "STR_tskDesc_CVY_Ammo";
		_tskIcon = "rearm";
		if (["supplies"] call AS_fnc_AAFarsenal_count == 0) then {
			diag_log format ["[AS] Error: convoy: supplies requested but not available", _mission];
		};
		_mainVehicleType = vehAmmo;
	};
	if (_missionType == "convoy_hvt") exitWith {
		_tskTitle = localize "STR_tsk_CVY_HVT";
		_tskDesc = localize "STR_tskDesc_CVY_HVT";
		_tskIcon = "destroy";
	};
	if (_missionType == "convoy_prisoners") exitWith {
		_tskTitle = localize "STR_tsk_CVY_Pris";
		_tskDesc = localize "STR_tskDesc_CVY_Pris";
		_tskIcon = "run";
		private _trucks = ["trucks"] call AS_fnc_AAFarsenal_all;
		if (count _trucks == 0) then {
			_trucks = ["trucks"] call AS_fnc_AAFarsenal_valid;
			diag_log format ["[AS] Error: convoy: trucks requested but not available", _mission];
		};
		_mainVehicleType = selectRandom _trucks;
	};
};

_tskDesc = format [_tskDesc,[_origin] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,[_location] call localizar];
_tskTitle = format [_tskTitle, A3_STR_INDEP];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_position],_position,"CREATED",5,true,true,_tskIcon] call BIS_fnc_setTask;

private _groups = [];
private _vehicles = [];

// particular to specific missions. They do not need to be cleaned.
private _grpPOW = grpNull;
private _POWs = [];
private _hvt = objNull;

[_origin,30] call AS_fnc_location_increaseBusy;

private _group = createGroup side_green;
_groups pushBack _group;

([_posbase, _position] call fnc_findSpawnSpots) params ["_posRoad", "_dir"];

// initialisation of vehicles
private _initVehs = {
	params ["_specs"];
	_specs = _specs + [_dir, _group, _vehicles, _groups, [], true];
	_specs call fnc_initialiseVehicle;
};

sleep (2 * 60);

private _escortSize = 1;
if ([_location] call isFrontline) then {_escortSize = (round random 2) + 1};

// spawn escorts
for "_i" from 1 to _escortSize do {
	sleep 20;
	private _apcs = ["trucks", "apcs"] call AS_fnc_AAFarsenal_all;
	private _escortVehicleType = selectRandom _apcs;

	private _vehData = [[_posRoad, _escortVehicleType]] call _initVehs;
	_vehicles = _vehData select 0;
	_groups = _vehData select 1;

	private _veh = (_vehData select 3) select 0;
	[_veh,"AAF Convoy Escort"] spawn inmuneConvoy;

	private _tipoGrupo = "";
	if (_escortVehicleType call AS_fnc_AAFarsenal_category == "apcs") then {
		_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
	} else {
		_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
	};

	private _grupoEsc = [_posbase, side_green, _tipoGrupo] call BIS_Fnc_spawnGroup;
	{[_x] call AS_fnc_initUnitAAF;_x assignAsCargo _veh;_x moveInCargo _veh; [_x] join _group} forEach units _grupoEsc;
	deleteGroup _grupoEsc;
};

sleep 20;

private _vehObj = _mainVehicleType createVehicle _posRoad;
_vehicles pushBack _vehObj;
_vehObj setDir _dir;

private _driver = ([_posbase, 0, sol_DRV, _group] call bis_fnc_spawnvehicle) select 0;
_driver assignAsDriver _vehObj;
_driver moveInDriver _vehObj;
[_driver] call AS_fnc_initUnitAAF;
_driver addEventHandler ["killed", {
	{
		_x action ["EJECT", _vehObj];
		unassignVehicle _x;
	} forEach crew _vehObj;
}];

if (_missionType == "convoy_hvt") then {
	_hvt = ([_posbase, 0, sol_OFF, _group] call bis_fnc_spawnvehicle) select 0;
	[_hvt] spawn AS_fnc_initUnitAAF;
	_hvt assignAsCargo _vehObj;
	_hvt moveInCargo _vehObj;
};
if (_missionType == "convoy_armor") then {
	_vehObj lock 3;
};
if (_missionType == "convoy_prisoners") then {
	_grpPOW = createGroup side_blue;
	_POWS = [];
	_groups pushBack _grpPOW;
	for "_i" from 1 to (1+ round (random 11)) do {
		private _unit = _grpPOW createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, _posbase, [], 0, "NONE"];
		_unit setCaptive true;
		_unit disableAI "MOVE";
		_unit setBehaviour "CARELESS";
		_unit allowFleeing 0;
		_unit assignAsCargo _vehObj;
		_unit moveInCargo [_vehObj, _i + 3]; // 3 because first 3 are in front
		removeAllWeapons _unit;
		removeAllAssignedItems _unit;
		[[_unit,"refugiado"],"AS_fnc_addAction"] call BIS_fnc_MP;
		_POWS pushBack _unit;
	};
};
if (_missionType in ["convoy_money", "convoy_supplies"]) then {
	reportedVehs pushBack _vehObj;
	publicVariable "reportedVehs";
};

// set everyone in motion
private _wp0 = _group addWaypoint [_position, 0];
_wp0 setWaypointType "MOVE";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";


private _fnc_clean = {
	private _wp0 = _group addWaypoint [_posbase, 0];
	_wp0 setWaypointType "MOVE";
	_wp0 setWaypointBehaviour "SAFE";
	_wp0 setWaypointSpeed "LIMITED";
	_wp0 setWaypointFormation "COLUMN";

	[_groups, _vehicles] call AS_fnc_cleanResources;
    sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;

	if (_missionType in ["convoy_money", "convoy_supplies"]) then {
		[_vehObj] call vaciar;
		reportedVehs = reportedVehs - [_vehObj];
		publicVariable "reportedVehs";
	};
};
private _fnc_missionFailedCondition = call {
	if (_missionType in ["convoy_money", "convoy_armor", "convoy_ammo", "convoy_supplies"]) exitWith {
		{(_vehObj distance _position < 100) or (dateToNumber date > _fechalimnum)}
	};
	if (_missionType == "convoy_hvt") exitWith {
		{(_hvt distance _position < 100) or (dateToNumber date > _fechalimnum)}
	};
	if (_missionType == "convoy_prisoners") exitWith {
		{(_vehObj distance _position < 100) or (dateToNumber date > _fechalimnum) or ({alive _x} count _POWs < ({alive _x} count _POWs)/2)}
	};
};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_position],_position,"FAILED",5,true,true,_tskIcon] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	if (_missionType == "convoy_ammo") then {
		[_vehObj] call emptyCrate;
	};
};

private _fnc_missionSuccessfulCondition = call {
	if (_missionType in ["convoy_money", "convoy_armor", "convoy_ammo", "convoy_supplies"]) exitWith {
		(not alive _vehObj) or {driver _vehObj getVariable ["BLUFORSpawn",false]}
	};
	if (_missionType == "convoy_armor") exitWith {
		{not alive _vehObj}
	};
	if (_missionType == "convoy_hvt") exitWith {
		{not alive _hvt}
	};
	if (_missionType == "convoy_prisoners") exitWith {
		{{(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _POWs >= ({alive _x} count _POWs) / 2}
	};
};

private _fnc_missionSuccessful = call {
	if (_missionType in ["convoy_money", "convoy_ammo", "convoy_supplies"]) exitWith {
		{
			private _fnc_missionFailedCondition = {not alive _vehObj or (dateToNumber date > _fechalimnum)};
			private _fnc_missionFailed = {
				_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_position],_position,"SUCCEEDED",5,true,true,_tskIcon] call BIS_fnc_setTask;
				[-5000] remoteExec ["resourcesAAF",2];
				[1800] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
			};
			private _destination = getMarkerPos "FIA_HQ";
			if (_missionType == "convoy_supplies") then {
				_destination = _position;
			};

			private _fnc_missionSuccessfulCondition = {(_vehObj distance _destination < 50) and {speed _vehObj < 1}};
			private _fnc_missionSuccessful = {
				_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_position],_position,"SUCCEEDED",5,true,true,_tskIcon] call BIS_fnc_setTask;
				[_mission, getPos _vehObj] remoteExec ["AS_fnc_mission_success", 2];
			};
			[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
		}
	};
	if (_missionType == "convoy_armor") exitWith {
		{
			_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_position],_position,"SUCCEEDED",5,true,true,_tskIcon] call BIS_fnc_setTask;
			[_mission, getPos _vehObj] remoteExec ["AS_fnc_mission_success", 2];

			[position _vehObj] spawn patrolCA;
		}
	};
	if (_missionType == "convoy_hvt") exitWith {
		{
			_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_position],_position,"SUCCEEDED",5,true,true,_tskIcon] call BIS_fnc_setTask;
			[_mission, getPos _vehObj] remoteExec ["AS_fnc_mission_success", 2];

			[position _hvt] spawn patrolCA;
		}
	};
	if (_missionType == "convoy_prisoners") exitWith {
		{
			[_mission,  getPos _vehObj, {alive _x} count _POWs] remoteExec ["AS_fnc_mission_success", 2];

			{[_x] join _grpPOW; [_x] orderGetin false} forEach _POWs;
		}
	};
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
