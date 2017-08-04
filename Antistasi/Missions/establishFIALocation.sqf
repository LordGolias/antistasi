#include "macros.hpp"
params ["_mission"];

private _locationType = [_mission, "locationType"] call AS_fnc_mission_get;
private _position = [_mission, "position"] call AS_fnc_mission_get;

if !(_locationType in ["watchpost","roadblock","camp"]) exitwith {
	diag_log format ["[AS] Error: establishFIALocation called with wrong type '%1'", _locationType];
};

private _locationName = "";
private _groupType = "";
private _vehType = "";
switch _locationType do {
	case "watchpost": {
		_locationName = "watchpost";
		_groupType = "Sniper Team";
		_vehType = "B_G_Quadbike_01_F";
	};
	case "roadblock": {
		_locationName = "roadblock";
		_groupType = "AT Team";
		_vehType = "B_G_Offroad_01_F";
	};
	case "camp": {
		_locationName = "camp";
		_groupType = "Sentry Team";
		_vehType = "B_G_Van_01_transport_F";
	};
};

private _taskTitle = format ["Establish %1", _locationName];
private _taskDesc = format ["The team to establish the %1 is ready. Send it to the destination.", _locationName];

// give 30m to complete mission
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 30];
private _fechalimnum = dateToNumber _fechalim;

// this is a hidden marker used by the task.
// If the mission is completed, it becomes owned by the new location
private _mrk = createMarker [format ["FIAlocation%1", random 1000], _position];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [50,50];
_mrk setMarkerAlpha 0;

private _task = [_mission,[side_blue,civilian],[_taskDesc,_taskTitle,_mrk],_position,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;

private _vehicles = [];
private _group = [getMarkerPos "FIA_HQ", side_blue, [_groupType] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
AS_commander hcSetGroup [_group];
_group setVariable ["isHCgroup", true, true];
{[_x] call AS_fnc_initUnitFIA} forEach units _group;

private _fnc_clean = {
	AS_commander hcRemoveGroup _group;
	{
		if (alive _x) then {
			([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
			[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
			deleteVehicle _x;
		};
	} forEach units _group;
	{deleteVehicle _x} forEach _vehicles;
	deleteGroup _group;

	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

// get a road close to the FIA_HQ
private _tam = 10;
private _roads = [];
while {count _roads == 0} do {
	_roads = getMarkerPos "FIA_HQ" nearRoads _tam;
	_tam = _tam + 10;
};
private _road = _roads select 0;
private _pos = (position _road) findEmptyPosition [1,30,_vehType];

// create vehicle
private _vehicle = _vehType createVehicle _pos;
[_vehicle, "FIA"] call AS_fnc_initVehicle;
_vehicles pushBack _vehicle;

if (_locationType == "camp") then {
	private _crate = "Box_FIA_Support_F" createVehicle _pos;
	_crate attachTo [_vehicle, [0.0,-1.2,0.5]];
	_vehicles pushBack _crate;
};

_group addVehicle _vehicle;
leader _group setBehaviour "SAFE";
[_group] call dismountFIA;

//// Wait for outcome

private _success = false;
waitUntil {sleep 5;
	_success = ({alive _x} count units _group > 0) and (_vehicle distance _position < 50);

	_success or ({alive _x} count units _group == 0) or (dateToNumber date > _fechalimnum)
};

if (_success) then {
	if (isPlayer leader _group) then {
		remoteExec ["AS_fnc_completeDropAIcontrol", leader _group];
		waitUntil {!(isPlayer leader _group)};
	};

	[_mrk,_locationType] call AS_fnc_location_add;
	// location took ownership of _mrk
	[_mrk,"side","FIA"] call AS_fnc_location_set;
	if (_locationType == "camp") then {
		private _name = selectRandom campNames;
		campNames = campNames - [_name];
		[_mrk, "name", _name] call AS_fnc_location_set;
	};

	// todo: add the vehicle to the location

	// add the team to the garrison
	private _garrison = [_mrk, "garrison"] call AS_fnc_location_get;
	{
		if (alive _x) then {
			_garrison pushBack (_x call AS_fnc_getFIAUnitType);
		};
	} forEach units _group;
	[_mrk, "garrison", _garrison] call AS_fnc_location_set;

	_task = [_mrk,[side_blue,civilian],[_taskDesc,_taskTitle,_mrk],_position,"SUCCEEDED",5,true,true,"Move"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
} else {
	_task = [_mrk,[side_blue,civilian],[_taskDesc,_taskTitle,_mrk],_position,"FAILED",5,true,true,"Move"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	deleteMarker _mrk;
};

call _fnc_clean;
