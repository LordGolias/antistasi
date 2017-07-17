#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};

params ["_location"];
private _position = _location call AS_fnc_location_position;
private _position = _location call AS_fnc_location_population;
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

private _tsk = ["PR",[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Heal"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

// spawn mission vehicle
private _truck = "C_Van_01_transport_F" createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [5,50,"C_Van_01_transport_F"]);

// eye candy
private _PRCrates = [];
private _leafletDrops = [];

private _totalDropCounts = 3;
private _crate3 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate3 attachTo [_truck,[0,-2.5,-0.25]];
_crate3 setDir (getDir _truck + 78);
_PRCrates pushBack _crate3;

private _crate2 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate2 attachTo [_truck,[0.4,-1.1,-0.25]];
_crate2 setDir (getDir _truck);
_PRCrates pushBack _crate2;

private _crate1 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate1 attachTo [_truck,[-0.4,-1.1,-0.25]];
_crate1 setDir (getDir _truck);
_PRCrates pushBack _crate1;

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

// search for target positions
private _targetBuildings = [];

private _allBuildings = nearestObjects [_position, ["Building"], _size];
private _usableBuildings = +_allBuildings;

private _index = round (3* ((count _allBuildings) /4));
private _perimeterBuildings = [_allBuildings, _index] call BIS_fnc_subSelect;

private _currentBuilding = "";
private _lastBuilding = "";

// first position on the perimeter of town
while {(count _targetBuildings < 1) && (count _perimeterBuildings > 0)} do {
	_currentBuilding = selectRandom _perimeterBuildings;
	private _bPositions = [_currentBuilding] call BIS_fnc_buildingPositions;
	if (count _bPositions > 1) then {
		_targetBuildings pushBackUnique _currentBuilding;
		_lastBuilding = _currentBuilding;
	};
	_usableBuildings = _usableBuildings - [_currentBuilding];
	_perimeterBuildings = _perimeterBuildings - [_currentBuilding];
};

// rest somewhere in town, at least 100m from the previous one
while {(count _targetBuildings < _totalDropCounts) && (count _usableBuildings > 0)} do {
	_currentBuilding = selectRandom _usableBuildings;
	private _bPositions = [_currentBuilding] call BIS_fnc_buildingPositions;
	if (((position _lastBuilding distance position _currentBuilding) > 100) && (count _bPositions > 1)) then {
		_targetBuildings pushBackUnique _currentBuilding;
		_lastBuilding = _currentBuilding;
	};
	_usableBuildings = _usableBuildings - [_currentBuilding];
};

// spawn two additional patrols with dogs
private _grupos = [];
private _soldados = [];

private _tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
private _params = [_position, side_green, _tipogrupo];

for "_i" from 0 to 1 do {
	private _grupo = _params call BIS_Fnc_spawnGroup;
	private _perro = _grupo createUnit ["Fin_random_F",_position,[],0,"FORM"];
	[_perro] call guardDog;
	[leader _grupo, _location, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	_grupos pushBack _grupo;
};

{
	private _grp = _x;
	{
		[_x, false] call AS_fnc_initUnitAAF;
	 	_soldados pushBack _x
	} forEach units _grp;
} forEach _grupos;

private _fnc_clean = {
	[1200,_tsk] spawn borrarTask;

	[_grupos, _leafletDrops + _PRCrates] call AS_fnc_cleanResources;

	waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,_truck,"BLUFORSpawn"] call distanceUnits)) or ((_truck distance (getMarkerPos "FIA_HQ") < 60) and (speed _truck < 1))};
	if ((_truck distance (getMarkerPos "FIA_HQ") < 60) and (speed _truck < 1)) then {
		[_truck] call vaciar;
	};
	deleteVehicle _truck;
};


private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or (not alive _truck)};

private _fnc_missionFailed = {
	_tsk = ["PR",[side_blue,civilian], [_tskDesc_fail,_tskTitle,_location],_position,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[0,-2,_location] remoteExec ["citySupportChange",2];
	[-10,AS_commander] call playerScoreAdd;

	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	_tsk = ["PR",[side_blue,civilian], [_tskDesc_success,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[-15,5,_location] remoteExec ["citySupportChange",2];
	[5,0] remoteExec ["prestige",2];
	{if (_x distance _position < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];

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
private _currentDrop = objNull;

private _fnc_loadCratesCondition = {
	// The condition to allow loading the crates into the truck
	(_currentDrop distance _truck < 20) and
	(speed _truck < 1) and
	({_x getVariable ["inconsciente",false]} count ([80,0,_truck,"BLUFORSpawn"] call distanceUnits) !=
	  count ([80,0,_truck,"BLUFORSpawn"] call distanceUnits)) and
	({(_x distance _truck < 50)} count _soldados == 0)
};


// keep the mission running until all sites are visited
while {(_currentDropCount < _totalDropCounts) and {not call _fnc_missionFailedCondition}} do {

	// advance site, refresh task
	_currentDrop = _targetBuildings select _currentDropCount;
	_tsk = ["PR",[side_blue,civilian],[_tskDesc_drop,_tskTitle,_location], position _currentDrop,"ASSIGNED",5,true,true,"Heal"] call BIS_fnc_setTask;

	// send patrol to the location
	private _patGroup = _grupos select 0;
	if (((leader _patGroup) distance2D (position _currentDrop)) > ((leader (_grupos select 1)) distance2D (position _currentDrop))) then {
		_patGroup = _grupos select 1;
	};
	if (alive leader _patGroup) then {
		private _wp101 = _patGroup addWaypoint [position _currentDrop, 20];
		_wp101 setWaypointType "SAD";
		_wp101 setWaypointBehaviour "AWARE";
		_patGroup setCombatMode "RED";
		_patGroup setCurrentWaypoint _wp101;
	};

	// wait 1m to unload the truck
	[_truck, 60, _fnc_loadCratesCondition, _fnc_missionFailedCondition] call AS_fnc_wait_or_fail;

	if (call _fnc_missionFailedCondition) exitWith {};  // exits the while loop, not the mission

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
