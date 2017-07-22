#include "macros.hpp"
AS_SERVER_ONLY("fnc_establishFIAlocation.sqf");
params ["_type","_position"];

if !(_type in ["watchpost","roadblock","camp"]) exitwith {
	diag_log format ["[AS] Error: establishLocation called with wrong type '%1'",_type];
};

private _vehicles = [];

private _locationName = "";
private _groupType = "";
private _vehType = "";
switch (_type) do {
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

private _taskDescription = format ["The team to establish the %1 is ready. Send it to the destination.", _locationName];
private _taskTitle = format ["Deploy %1", _locationName];

// give 30m to complete mission
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 30];
private _fechalimnum = dateToNumber _fechalim;

// this is a hidden marker used by the task for location
private _mrk = createMarker [format ["FIAlocation%1", random 1000], _position];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [50,50];  // sets the size of the patrol area
_mrk setMarkerAlpha 0;

private _tsk = [_mrk,[side_blue,civilian],
	[_taskDescription,_taskTitle,_mrk],
	_position,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;
misiones pushBackUnique _tsk; publicVariable "misiones";

private _group = [getMarkerPos "FIA_HQ", side_blue,
	[_groupType] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
{[_x] call AS_fnc_initUnitFIA} forEach units _group;

// get a road close to the FIA_HQ
private _tam = 10;
private _roads = [];
while {count _roads == 0} do {
	_roads = getMarkerPos "FIA_HQ" nearRoads _tam;
	if (count _roads < 1) then {_tam = _tam + 10};
};
private _road = _roads select 0;
_pos = position _road findEmptyPosition [1,30,_vehType];

// create vehicle
_vehicle = _vehType createVehicle _pos;
[_vehicle, "FIA"] call AS_fnc_initVehicle;
_vehicles pushBack _vehicle;

if (_type == "camp") then {
	_crate = "Box_FIA_Support_F" createVehicle _pos;
	_crate attachTo [_vehicle, [0.0,-1.2,0.5]];
	_vehicles pushBack _crate;
};

_group addVehicle _vehicle;
leader _group setBehaviour "SAFE";
[_group] spawn dismountFIA;

AS_commander hcSetGroup [_group];
_group setVariable ["isHCgroup", true, true];

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

	[_mrk,_type] call AS_fnc_location_add;
	[_mrk,"side","FIA"] call AS_fnc_location_set;
	if (_type == "camp") then {
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

	_mrk call AS_fnc_location_updateMarker; // creates the visible marker

	_tsk = [_mrk,[side_blue,civilian],
		[_taskDescription,_taskTitle,_mrk],
		_position,"SUCCEEDED",5,true,true,"Move"] call BIS_fnc_setTask;
	[-5,5,_position] remoteExec ["citySupportChange",2];
} else {
	_tsk = [_mrk,[side_blue,civilian],
		[_taskDescription,_taskTitle,_mrk],
		_position,"FAILED",5,true,true,"Move"] call BIS_fnc_setTask;
	deleteMarker _mrk;
};

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
sleep 15;

[0,_tsk] spawn borrarTask;
