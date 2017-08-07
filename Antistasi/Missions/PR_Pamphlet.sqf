#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _locationName = [_location] call localizar;
private _size = _location call AS_fnc_location_size;

// mission timer
private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = localize "STR_tsk_PRPamphlet";
private _tskDesc = format [localize "STR_tskDesc_PRPamphlet",_locationName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];
private _tskDesc_fail = format [localize "STR_tskDesc_PRPamphlet_fail", _locationName];
private _tskDesc_drop = format [localize "STR_tskDesc_PRPamphlet_drop",_locationName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];
private _tskDesc_success = format [localize "STR_tskDesc_PRPamphlet_success",_locationName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Heal"] call BIS_fnc_setTask;

// spawn two additional patrols with dogs
private _grupos = [];
private _vehicles = [];

// spawn mission vehicle
private _truck = "C_Van_01_transport_F" createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [5,50,"C_Van_01_transport_F"]);

private _totalDropCounts = 3;
private _crate3 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate3 attachTo [_truck,[0,-2.5,-0.25]];
_crate3 setDir (getDir _truck + 78);
_vehicles pushBack _crate3;

private _crate2 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate2 attachTo [_truck,[0.4,-1.1,-0.25]];
_crate2 setDir (getDir _truck);
_vehicles pushBack _crate2;

private _crate1 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate1 attachTo [_truck,[-0.4,-1.1,-0.25]];
_crate1 setDir (getDir _truck);
_vehicles pushBack _crate1;

// initialize mission vehicle
[_truck, "FIA"] call AS_fnc_initVehicle;
{_x reveal _truck} forEach (allPlayers - hcArray);
_truck setVariable ["destino",_locationName,true];
_truck addEventHandler ["GetIn",
	{
	if (_this select 1 == "driver") then
		{
		private _texto = format ["This truck carries leaflets for %1.",(_this select 0) getVariable "destino"];
		_texto remoteExecCall ["hint",_this select 2];
		};
	}];

[_truck,"Mission Vehicle"] spawn inmuneConvoy;

private _allBuildings = nearestObjects [_position, ["Building"], _size];
_allBuildings = _allBuildings call AS_fnc_shuffle;

for "_i" from 0 to 1 do {
	private _tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
	private _grupo = [_position, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
	private _perro = _grupo createUnit ["Fin_random_F",_position,[],0,"FORM"];
	[_perro] call guardDog;
	[leader _grupo, _location, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	_grupos pushBack _grupo;
};

{
	private _grp = _x;
	{
		[_x, false] call AS_fnc_initUnitAAF;
	} forEach units _grp;
} forEach _grupos;

private _fnc_clean = {
	[_grupos, _vehicles] call AS_fnc_cleanResources;

	sleep 30;
	[_task] call BIS_fnc_deleteTask;
	_mission call AS_fnc_mission_completed;

	waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,_truck,"BLUFORSpawn"] call distanceUnits)) or ((_truck distance (getMarkerPos "FIA_HQ") < 60) and (speed _truck < 1))};
	if ((_truck distance (getMarkerPos "FIA_HQ") < 60) and (speed _truck < 1)) then {
		[_truck] call vaciar;
	};
	deleteVehicle _truck;
};


private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or (not alive _truck)};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian], [_tskDesc_fail,_tskTitle,_location],_position,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	_task = [_mission,[side_blue,civilian], [_tskDesc_success,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

// wait until the vehicle enters the target area
waitUntil {sleep 1; (_truck distance _position < 500) or _fnc_missionFailedCondition};


if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// eye candy
private _leaflets = [
	["Land_Garbage_square3_F",[2.92334,0.0529785,0],360,1,0.0128296,[-0.000179055,0.000127677],"","",true,false],
	["Land_Leaflet_02_F",[2.66357,0.573486,0.688],36.0001,1,0,[-89.388,90],"","",true,false],
	["Land_Leaflet_02_F",[2.76953,0.0114746,0.688],152,1,0,[-88.513,-90],"","",true,false],
	["Land_Leaflet_02_F",[2.81738,-0.317627,0.688],8.00002,1,0,[-89.19,90],"","",true,false],
	["Land_WoodenCrate_01_F",[2.92334,0.0529785,0],360,1,0.0128296,[-0.000179055,0.000127677],"","",true,false],
	["Land_Leaflet_02_F",[2.91455,0.409424,0.688],0.999995,1,0,[-86.6,90],"","",true,false],
	["Land_Leaflet_02_F",[3.06543,0.0744629,0.688],309,1,0,[-89.19,90],"","",true,false],
	["Land_Leaflet_02_F",[3.1377,0.481445,0.688],312,1,0,[-89.19,90],"","",true,false]
];

/*
_currentDropCount: number of sites done
_currentDrop: current site (building)
pr_unloading_pamphlets: active process
*/
private _currentDropCount = 0;
private _currentDrop = _allBuildings select 0;

private _fnc_loadCratesCondition = {
	// The condition to allow loading the crates into the truck
	(_truck distance _currentDrop < 20) and {speed _truck < 1} and
	{{alive _x and not (_x call AS_fnc_isUnconscious)} count ([80,0,_truck,"BLUFORSpawn"] call distanceUnits) > 0} and
	{{(side _x == side_green) or (side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
};

private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";

// keep the mission running until all sites are visited
while {(_currentDropCount < _totalDropCounts) and {not call _fnc_missionFailedCondition}} do {

	// advance site, refresh task
	_currentDrop = _allBuildings select _currentDropCount;
	_task = [_mission, [side_blue,civilian], [_tskDesc_drop,_tskTitle,_location], position _currentDrop,"ASSIGNED",5,true,true,"Heal"] call BIS_fnc_setTask;

	// send patrol to the location
	{
		if (alive leader _x) then {
			private _wp101 = _x addWaypoint [position _currentDrop, 20];
			_wp101 setWaypointType "SAD";
			_wp101 setWaypointBehaviour "AWARE";
			_x setCombatMode "RED";
			_x setCurrentWaypoint _wp101;
		};
	} forEach _grupos;

	// wait 1m to unload the truck
	[_truck, 60, _fnc_loadCratesCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

	if (call _fnc_missionFailedCondition) exitWith {};  // exits the while loop, not the mission

	private _posUnload = (position _truck) findEmptyPosition [1,10,"C_Van_01_transport_F"];
	private _drop = [_posUnload, random 360, _leaflets] call BIS_fnc_ObjectsMapper;
	_vehicles append _drop;

	// next location
	_currentDropCount = _currentDropCount + 1;

	// if there are sites to go, inform player
	if (_currentDropCount < _totalDropCounts) then {
		{
			if (isPlayer _x) then {[petros,"hint","Head to the next location."] remoteExec ["commsMP",_x]};
		} forEach ([150,0,_truck, "BLUFORSpawn"] call distanceUnits);
	};
	sleep 1;
};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

call _fnc_missionSuccessful;
