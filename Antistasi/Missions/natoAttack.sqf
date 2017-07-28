#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;
private _group_count = [_mission, "group_count"] call AS_fnc_object_get;

private _name = [_location] call localizar;

private _aeropuertos = ["airfield", "FIA"] call AS_fnc_location_TS;
_aeropuertos pushBack "spawnNATO";
private _origin = [_aeropuertos,_position] call BIS_fnc_nearestPosition;
private _origpos = _origin call AS_fnc_location_position;
private _origname = "the NATO Carrier";
if (_origin != "spawnNATO") then {
	_origname = [_origin] call localizar
};

private _tskTitle = "NATO Attack";
private _tskDesc = format ["Our Commander asked NATO for an attack on %1. Help them in order to have success in this operation. The attack will depart from %2 and will include artillery fire.",_name,_origname];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;

private _groups = [];
private _vehicles = [];

private _fnc_clean = {
	[_groups, _vehicles] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _threatEval = [_position] call AAthreatEval;

if ((_origin call AS_location_type) in ["base", "airfield"]) then {
	[_location] spawn artilleriaNATO;
};

for "_i" from 1 to _group_count do {
	private _tipoveh = planesNATOTrans call BIS_fnc_selectRandom;
	private _vehicle = [_origpos, 0, _tipoveh, side_blue] call bis_fnc_spawnvehicle;
	private _heli = _vehicle select 0;
	private _heliCrew = _vehicle select 1;
	private _groupheli = _vehicle select 2;
	{[_x] spawn NATOinitCA} forEach _heliCrew;
	[_heli, "NATO"] call AS_fnc_initVehicle;
	_groups pushBack _groupheli;
	_vehicles pushBack _heli;

	{_x setBehaviour "CARELESS";} forEach units _groupheli;
	[_heli,"NATO Air Transport"] spawn inmuneConvoy;

	if (_tipoveh in bluHeliDis) then {
		private _tipoGrupo = [bluSquadWeapons, side_blue] call fnc_pickGroup;
		private _group = [_origin, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] spawn NATOinitCA} forEach units _group;
		_groups pushBack _group;
		if ((_origin call AS_location_type == "airfield") or (random 10 < _threatEval)) then {
			[_heli,_group,_position,_threatEval] spawn airdrop;
		} else {
			if ((_location call AS_location_type) in ["base","watchpost"]) then {
				[_heli,_group,_position,_origpos,_groupheli] spawn fastropeNATO;
			};
			if ((_location call AS_location_type) in ["resource","factory", "powerplant"]) then {
				{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _groupheli;
				private _landpos = [];
				_landpos = [_position, 0, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
				_landPos set [2, 0];
				private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
				_vehicles = _vehicles + [_pad];
				private _wp0 = _groupheli addWaypoint [_landpos, 0];
				_wp0 setWaypointType "TR UNLOAD";
				_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
				[_groupheli,0] setWaypointBehaviour "CARELESS";
				private _wp3 = _group addWaypoint [_landpos, 0];
				_wp3 setWaypointType "GETOUT";
				_wp0 synchronizeWaypoint [_wp3];
				private _wp4 = _group addWaypoint [_position, 1];
				_wp4 setWaypointType "SAD";
				private _wp2 = _groupheli addWaypoint [_origpos, 1];
				_wp2 setWaypointType "MOVE";
				_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
				[_groupheli,1] setWaypointBehaviour "AWARE";
				[_heli,true] spawn puertasLand;
			};
		};
	};
	if (_tipoveh in bluHeliTS) then {
		{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _groupheli;
		private _tipoGrupo = [bluTeam, side_blue] call fnc_pickGroup;
		private _group = [_origpos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] call NATOinitCA} forEach units _group;
		_groups pushBack _group;
		private _landpos = [];
		_landpos = [_position, 0, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		_landPos set [2, 0];
		private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
		_vehicles pushBack _pad;
		private _wp0 = _groupheli addWaypoint [_landpos, 0];
		_wp0 setWaypointType "TR UNLOAD";
		_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
		[_groupheli,0] setWaypointBehaviour "CARELESS";
		private _wp3 = _group addWaypoint [_landpos, 0];
		_wp3 setWaypointType "GETOUT";
		_wp0 synchronizeWaypoint [_wp3];
		private _wp4 = _group addWaypoint [_position, 1];
		_wp4 setWaypointType "SAD";
		private _wp2 = _groupheli addWaypoint [_origpos, 1];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
		[_groupheli,1] setWaypointBehaviour "AWARE";
		[_heli,true] spawn puertasLand;
	};
	if (_tipoveh in bluHeliRope) then {
		{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _groupheli;
		private _tipoGrupo = [bluSquad, side_blue] call fnc_pickGroup;
		private _group = [_origpos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] call NATOinitCA} forEach units _group;
		_groups pushBack _group;
		if ((_location call AS_location_type) in ["airfield","base", "watchpost"] or (random 10 < _threatEval)) then {
			[_heli,_group,_position,_threatEval] spawn airdrop;
		} else {
			private _landpos = [];
			_landpos = [_position, 0, 300, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
			_landPos set [2, 0];
			private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
			_vehicles = _vehicles + [_pad];
			private _wp0 = _groupheli addWaypoint [_landpos, 0];
			_wp0 setWaypointType "TR UNLOAD";
			_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
			[_groupheli,0] setWaypointBehaviour "CARELESS";
			private _wp3 = _group addWaypoint [_landpos, 0];
			_wp3 setWaypointType "GETOUT";
			_wp0 synchronizeWaypoint [_wp3];
			private _wp4 = _group addWaypoint [_position, 1];
			_wp4 setWaypointType "SAD";
			private _wp2 = _groupheli addWaypoint [_origpos, 1];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
			[_groupheli,1] setWaypointBehaviour "AWARE";
			[_heli,true] spawn puertasLand;
		};
	};
	sleep 30;
};

private _soldiers = [];
{
	_soldiers append (units _x);
} forEach _groups;

private _fnc_missionFailedCondition = {
	({not alive _x or fleeing _x or captive _x} count _soldiers) >= 3./4*(count _soldiers)
};
private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
};
private _fnc_missionSuccessfulCondition = {_location call AS_fnc_location_side == "FIA"};
private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
