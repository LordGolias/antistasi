params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _nombredest = [_location] call localizar;

private _tskTitle = localize "STR_tsk_DesHeli";
private _tskDesc = format [localize "STR_tskDesc_DesHeli",_nombredest];

private _posHQ = getMarkerPos "FIA_HQ";

private _poscrash = [0,0,0];
while {surfaceIsWater _poscrash or (_poscrash distance _posHQ) < 4000} do {
	sleep 0.1;
	_poscrash = [_position, 5000, random 360] call BIS_fnc_relPos;
};

private _tipoVeh = (["planes", "armedHelis", "transportHelis"] call AS_fnc_AAFarsenal_all) call BIS_fnc_selectRandom;

private _posCrashMrk = [_poscrash,random 500,random 360] call BIS_fnc_relPos;
private _posCrash = _poscrash findEmptyPosition [0,100,_tipoVeh];
private _mrkfin = createMarker [format ["DES%1", random 100], _posCrashMrk];
_mrkfin setMarkerShape "ICON";

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posCrashMrk,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;

private _vehiculos = [];
private _soldados = [];
private _grupos = [];

private _crater = createVehicle ["CraterLong", _poscrash, [], 0, "CAN_COLLIDE"];
private _heli = createVehicle [_tipoVeh, _poscrash, [], 0, "CAN_COLLIDE"];
_heli attachTo [_crater,[0,0,1.5]];
private _smoke = "test_EmptyObjectForSmoke" createVehicle _poscrash;
_smoke attachTo[_heli,[0,1.5,-1]];
_heli setDamage 0.9;
_heli lock 2;
_vehiculos append [_heli, _crater];

private _grpcrash = createGroup side_green;
_grupos pushBack _grpcrash;

private _unit = ([_poscrash, 0, infPilot, _grpcrash] call bis_fnc_spawnvehicle) select 0;
_unit setDamage 1;
_unit moveInDriver _heli;
_soldados pushBack _unit;

private _tam = 100;
private _roads = [];
while {count _roads == 0} do {
	_roads = _position nearRoads _tam;
	_tam = _tam + 50;
};
private _road = _roads select 0;

private _vehType = selectRandom (["apcs"] call AS_fnc_AAFarsenal_valid);
private _vehicle = [position _road, 0,_vehType, side_green] call bis_fnc_spawnvehicle;
private _veh = _vehicle select 0;
[_veh, "AAF"] call AS_fnc_initVehicle;
[_veh,"AAF Escort"] spawn inmuneConvoy;
private _vehCrew = _vehicle select 1;
{[_x] spawn AS_fnc_initUnitAAF} forEach _vehCrew;
private _grupoVeh = _vehicle select 2;
_soldados append _vehCrew;
_grupos pushBack _grupoVeh;
_vehiculos pushBack _veh;

sleep 1;

private _tipoGrupo = [infPatrol, side_green] call fnc_pickGroup;
private _grupo = [_position, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;

{
	_x assignAsCargo _veh;
	_x moveInCargo _veh;
	_soldados pushBack _x;
	[_x] join _grupoveh;
	[_x] spawn AS_fnc_initUnitAAF
} forEach units _grupo;
deleteGroup _grupo;
[_veh] spawn smokeCover;

private _Vwp0 = _grupoVeh addWaypoint [_poscrash, 0];
_Vwp0 setWaypointType "TR UNLOAD";
_Vwp0 setWaypointBehaviour "SAFE";
private _Gwp0 = _grupo addWaypoint [_poscrash, 0];
_Gwp0 setWaypointType "GETOUT";
_Vwp0 synchronizeWaypoint [_Gwp0];

sleep 15;

private _vehicleT = [position _road, 0, selectRandom vehTruckBox, side_green] call bis_fnc_spawnvehicle;
private _vehT = _vehicleT select 0;
[_vehT, "AAF"] call AS_fnc_initVehicle;
[_vehT,"AAF Recover Truck"] spawn inmuneConvoy;
private _vehCrewT = _vehicle select 1;
{[_x] spawn AS_fnc_initUnitAAF} forEach _vehCrewT;
private _grupoVehT = _vehicleT select 2;
_soldados append _vehCrewT;
_grupos  pushBack _grupoVehT;
_vehiculos pushBack _vehT;

_Vwp0 = _grupoVehT addWaypoint [_poscrash, 0];
_Vwp0 setWaypointType "MOVE";
_Vwp0 setWaypointBehaviour "SAFE";


private _fnc_clean = {
	if (!isNull _smoke) then {
		{deleteVehicle _x} forEach (_smoke getVariable ["effects", []]);
		deleteVehicle _smoke;
	};
	[_grupos, _vehiculos, [_mrkfin]] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {_vehT distance _position < 50};

private _fnc_missionFailed = {
	_vehT doMove position _heli;
	if (alive _heli) then {
		_heli attachTo [_vehT,[0,-3,2]];
		{deleteVehicle _x} forEach (_smoke getVariable ["effects", []]);
		deleteVehicle _smoke;
	};

	_Vwp0 = _grupoVehT addWaypoint [_position, 1];
	_Vwp0 setWaypointType "MOVE";
	_Vwp0 setWaypointBehaviour "SAFE";

	_Vwp0 = _grupoVeh addWaypoint [_poscrash, 0];
	_Vwp0 setWaypointType "LOAD";
	_Vwp0 setWaypointBehaviour "SAFE";
	_Gwp0 = _grupo addWaypoint [_poscrash, 0];
	_Gwp0 setWaypointType "GETIN";
	_Vwp0 synchronizeWaypoint [_Gwp0];

	_Vwp0 = _grupoVeh addWaypoint [_position, 2];
	_Vwp0 setWaypointType "MOVE";
	_Vwp0 setWaypointBehaviour "SAFE";

	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posCrashMrk,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;
	call _fnc_clean;
};

private _fnc_missionSuccessfulCondition = {not alive _heli};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posCrashMrk,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	[0,300] remoteExec ["resourcesFIA",2];
	[5,0] remoteExec ["prestige",2];
	[1200] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

	call _fnc_clean;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
