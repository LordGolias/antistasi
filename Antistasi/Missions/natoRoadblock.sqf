#include "../macros.hpp"
params ["_mission"];
private _position = [_mission, "position"] call AS_fnc_mission_get;
private _time = [_mission, "time"] call AS_fnc_mission_get;

private _origin = [("FIA" call AS_fnc_location_S) - ["spawnNATO"], AS_commander] call BIS_Fnc_nearestPosition;
private _orig = _origin call AS_fnc_location_position;

private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + (30 max _time)];
private _fechalimnum = dateToNumber _fechalim;

private _nombreorig = [_origin] call localizar;

// this is a hidden marker used by the task and for the location
private _mrk = createMarker [format ["NATOroadblock%1", random 1000], _position];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [50,50];
_mrk setMarkerAlpha 0;

private _tskTitle = "NATO Roadblock Deployment";
private _tskDesc = format ["NATO is dispatching a team from %1 to establish a temporary Roadblock. Send and cover the team until reaches its destination.", _nombreorig];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrk],_position,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;

private _tipoGrupo = [bluATTeam, "NATO"] call fnc_pickGroup;

private _vehicles = [];
private _groups = [];

private _fnc_clean = {
	{AS_commander hcRemoveGroup _x} forEach _groups;
	[_groups, _vehicles, [_mrk]] call AS_fnc_cleanResources;

	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _group = [_orig, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
_groups pushBack _group;
_group setGroupId ["Watch"];
AS_commander hcSetGroup [_group];
_group setVariable ["isHCgroup", true, true];

private _tam = 10;
private _roads = [];
while {count _roads == 0} do {
	_roads = _orig nearRoads _tam;
	_tam = _tam + 10;
};
private _road = _roads select 0;

private _tipoVeh = selectRandom bluTruckTP;
private _pos = position _road findEmptyPosition [1,30, _tipoVeh];
private _transport = _tipoVeh createVehicle _pos;
_group addVehicle _transport;

{
	_x assignAsCargo _transport;
	_x moveInCargo _transport;
} forEach units _group;

{[_x] call AS_fnc_initUnitNATO} forEach units _group;
leader _group setBehaviour "SAFE";

waitUntil {sleep 1;
	({alive _x} count units _group == 0) or
	({(alive _x) and (_x distance _position < 10)} count units _group > 0) or
	(dateToNumber date > _fechalimnum)
};

if ({(alive _x) and (_x distance _position < 10)} count units _group > 0) then {
	if (isPlayer leader _group) then {
		private _owner = (leader _group) getVariable ["owner",leader _group];
		(leader _group) remoteExec ["removeAllActions",leader _group];
		_owner remoteExec ["selectPlayer",leader _group];
		(leader _group) setVariable ["owner",_owner,true];
		{[_x] joinsilent group _owner} forEach units group _owner;
		[group _owner, _owner] remoteExec ["selectLeader", _owner];
		"" remoteExec ["hint",_owner];
		waitUntil {!(isPlayer leader _group)};
	};

	AS_commander hcRemoveGroup _group;
	{deleteVehicle _x} forEach units _group;
	deleteVehicle _transport;
	deleteGroup _group;
	sleep 1;

	[_mrk,"roadblock"] call AS_fnc_location_add;
	[_mrk, "side", "NATO"] call AS_fnc_location_set;

	_task = [_mission,[side_blue,civilian],[format ["NATO successfully deployed a roadblock, They will hold their position until %1:%2.",numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_mrk],_position,"SUCCEEDED",5,true,true,"Move"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	waitUntil {sleep 60; dateToNumber date > _fechalimnum};
	_mrk call AS_fnc_location_remove;
} else {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskDesc,_mrk],_position,"FAILED",5,true,true,"Move"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
};

call _fnc_clean;
