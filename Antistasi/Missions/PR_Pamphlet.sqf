#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};

_tskTitle = localize "STR_tsk_PRPamphlet";
_tskDesc = localize "STR_tskDesc_PRPamphlet";
_tskDesc_fail = localize "STR_tskDesc_PRPamphlet_fail";
_tskDesc_drop = localize "STR_tskDesc_PRPamphlet_drop";
_tskDesc_success = localize "STR_tskDesc_PRPamphlet_success";

/*
parameters
0: target marker (marker)
*/
private _targetMarker = _this select 0;
private _targetPosition = _targetMarker call AS_fnc_location_position;
private _targetName = [_targetMarker] call localizar;
private _size = _targetMarker call AS_fnc_location_size;


// mission timer
_tiempolim = 60;
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_tsk = ["PR",[side_blue,civilian],[format [_tskDesc,_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_targetMarker],_targetPosition,"CREATED",5,true,true,"Heal"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

// spawn mission vehicle
_pos = (getMarkerPos "FIA_HQ") findEmptyPosition [5,50,"C_Van_01_transport_F"];
PRTruck = "C_Van_01_transport_F" createVehicle _pos;

// eye candy
_PRCrates = [];
_leafletDrops = [];

_crate3 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate3 attachTo [PRTruck,[0,-2.5,-0.25]];
_crate3 setDir (getDir PRTruck + 78);
_PRCrates pushBack _crate3;

_crate2 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate2 attachTo [PRTruck,[0.4,-1.1,-0.25]];
_crate2 setDir (getDir PRTruck);
_PRCrates pushBack _crate2;

_crate1 = "Land_WoodenCrate_01_F" createVehicle [0,0,0];
_crate1 attachTo [PRTruck,[-0.4,-1.1,-0.25]];
_crate1 setDir (getDir PRTruck);
_PRCrates pushBack _crate1;

// initialize mission vehicle
[PRTruck, "FIA"] call AS_fnc_initVehicle;
{_x reveal PRTruck} forEach (allPlayers - hcArray);
PRTruck setVariable ["destino",_targetName,true];
PRTruck addEventHandler ["GetIn",
	{
	if (_this select 1 == "driver") then
		{
		_texto = format ["This truck carries leaflets for %1.",(_this select 0) getVariable "destino"];
		_texto remoteExecCall ["hint",_this select 2];
		};
	}];

[PRTruck,"Mission Vehicle"] spawn inmuneConvoy;

// search for target positions
// _countBuildings: number of positions
_countBuildings = 3;
_targetBuildings = [];

_allBuildings = nearestObjects [_targetPosition, ["Building"], _size];
_usableBuildings = +_allBuildings;

_index = round (3* ((count _allBuildings) /4));
_perimeterBuildings = [_allBuildings, _index] call BIS_fnc_subSelect;

_currentBuilding = "";
_lastBuilding = "";

// first position on the perimeter of town
while {(count _targetBuildings < 1) && (count _perimeterBuildings > 0)} do {
	_currentBuilding = selectRandom _perimeterBuildings;
	_bPositions = [_currentBuilding] call BIS_fnc_buildingPositions;
	if (count _bPositions > 1) then {
		_targetBuildings pushBackUnique _currentBuilding;
		_lastBuilding = _currentBuilding;
	};
	_usableBuildings = _usableBuildings - [_currentBuilding];
	_perimeterBuildings = _perimeterBuildings - [_currentBuilding];
};

// rest somewhere in town, at least 100m from the previous one
while {(count _targetBuildings < _countBuildings) && (count _usableBuildings > 0)} do {
	_currentBuilding = selectRandom _usableBuildings;
	_bPositions = [_currentBuilding] call BIS_fnc_buildingPositions;
	if (((position _lastBuilding distance position _currentBuilding) > 100) && (count _bPositions > 1)) then {
		_targetBuildings pushBackUnique _currentBuilding;
		_lastBuilding = _currentBuilding;
	};
	_usableBuildings = _usableBuildings - [_currentBuilding];
};

// spawn two additional patrols with dogs
_grupos = [];
_soldados = [];
_tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
_params = [_targetPosition, side_green, _tipogrupo];

for "_i" from 0 to 1 do {
	_grupo = _params call BIS_Fnc_spawnGroup;
	sleep 1;
	_perro = _grupo createUnit ["Fin_random_F",_targetPosition,[],0,"FORM"];
	[_perro] spawn guardDog;
	[leader _grupo, _targetMarker, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	_grupos = _grupos + [_grupo];
};

{_grp = _x;
{[_x, false] spawn AS_fnc_initUnitAAF; _soldados = _soldados + [_x]} forEach units _grp;} forEach _grupos;

// wait until the vehicle enters the target area
waitUntil {sleep 1; (not alive PRTruck) or (dateToNumber date > _fechalimnum) or (PRTruck distance _targetPosition < 500)};


// vehicle destroyed or timer ran out
if !(PRTruck distance _targetPosition < 550) exitWith {
	_tsk = ["PR",[side_blue,civilian], [format [_tskDesc_fail, _targetName],_tskTitle,_targetMarker],_targetPosition,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
    [5,-5,_targetPosition] remoteExec ["citySupportChange",2];
	[-10,AS_commander] call playerScoreAdd;

    [1200,_tsk] spawn borrarTask;
	waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,PRTruck,"BLUFORSpawn"] call distanceUnits)) or ((PRTruck distance (getMarkerPos "FIA_HQ") < 60) && (speed PRTruck < 1))};
	if ((PRTruck distance (getMarkerPos "FIA_HQ") < 60) && (speed PRTruck < 1)) then {
		[PRTruck] call vaciar;
		deleteVehicle PRTruck;
	};
	{deleteVehicle _x} forEach _PRCrates;
	sleep 1;
	deleteVehicle PRTruck;

	waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,_targetPosition,"BLUFORSpawn"] call distanceUnits))};
	{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
	{deleteGroup _x} forEach _grupos;
	{deleteVehicle _x} forEach _leafletDrops;
};

// eye candy
_leaflets =
[
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
_flagOne: proceeded to the next site
_flagTwo: timer running
_flagThree: unloading
_deploymentTime: time it takes to unload the gear (seconds)
_counter: running timer
_currentDropCount: number of sites done
_currentDrop: current site
_canUnload: flag to control unloading action

pr_unloading_pamphlets: active process
*/
_flagOne = false;
_flagTwo = false;
_flagThree = false;
_deploymentTime = 60;
_counter = 0;
_currentDropCount = 0;
_currentDrop = "";
_canUnload = false;

server setVariable ["pr_unloading_pamphlets", false, true];

// truck alive, mission running, sites to go
while {(alive PRTruck) && (dateToNumber date < _fechalimnum) && (_currentDropCount < 3)} do {

	// advance site, refresh task
	if !(_flagOne) then {
		_flagOne = true;
		_currentDrop = _targetBuildings select _currentDropCount;
		_tsk = ["PR",[side_blue,civilian],[format [_tskDesc_drop,_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_targetMarker], position _currentDrop,"ASSIGNED",5,true,true,"Heal"] call BIS_fnc_setTask;

		_patGroup = _grupos select 0;
		if (((leader _patGroup) distance2D (position _currentDrop)) > ((leader (_grupos select 1)) distance2D (position _currentDrop))) then {
			_patGroup = _grupos select 1;
		};
		if (alive leader _patGroup) then {
			_wp101 = _patGroup addWaypoint [position _currentDrop, 20];
			_wp101 setWaypointType "SAD";
			_wp101 setWaypointBehaviour "AWARE";
			_patGroup setCombatMode "RED";
			_patGroup setCurrentWaypoint _wp101;
		};
	};

	// truck close enough to unload
	while {(alive PRTruck) && (dateToNumber date < _fechalimnum) && (_currentDropCount < 3) && (_currentDrop distance PRTruck < 20)} do {

		// add unload action if truck is stationary
		if (!(_canUnload) && (speed PRTruck < 1)) then {
			_canUnload = true;
			[[PRTruck,"unload_pamphlets"],"flagaction"] call BIS_fnc_MP;
		};

		// stop unloading when enemies get too close
		while {(_counter < _deploymentTime) && (alive PRTruck) and !({_x getVariable ["inconsciente",false]} count ([80,0,PRTruck,"BLUFORSpawn"] call distanceUnits) == count ([80,0,PRTruck,"BLUFORSpawn"] call distanceUnits)) and ({((side _x == side_green) || (side _x == side_red)) and (_x distance PRTruck < 50)} count allUnits == 0) and (dateToNumber date < _fechalimnum) && (server getVariable "pr_unloading_pamphlets")} do {

			// spaw eye candy
			if !(_flagThree) then {
				_flagThree = true;
				_posUnload = (position PRTruck) findEmptyPosition [1,10,"C_Van_01_transport_F"];
				_drop = [_posUnload, random 360, _leaflets] call BIS_fnc_ObjectsMapper;
				_leafletDrops = _leafletDrops + _drop;
				[_PRCrates select _currentDropCount, {deleteVehicle _this}] remoteExec ["call", 0];
			};

			// start a progress bar, remove crew from truck, lock the truck
			if !(_flagTwo) then {
				{if (isPlayer _x) then {[(_deploymentTime - _counter),false] remoteExec ["pBarMP",_x]; [PRTruck,true] remoteExec ["fnc_lockVehicle",_x];}} forEach ([80,0,PRTruck,"BLUFORSpawn"] call distanceUnits);
				_flagTwo = true;
				[[petros,"globalChat","Guard the truck!"],"commsMP"] call BIS_fnc_MP;
				{
					_x action ["eject", PRTruck];
				} forEach (crew (PRTruck));
				PRTruck lock 2;
				PRTruck engineOn false;
			};

			_counter = _counter + 1;
  			sleep 1;
		};

		// if unloading wasn't finished, reset
		if ((_counter < _deploymentTime) && (server getVariable "pr_unloading_pamphlets")) then {
			_counter = 0;
			_flagTwo = false;
			PRTruck lock 0;
			{if (isPlayer _x) then {[0,true] remoteExec ["pBarMP",_x]; [PRTruck,false] remoteExec ["fnc_lockVehicle",_x];}} forEach ([100,0,PRTruck,"BLUFORSpawn"] call distanceUnits);

			if (((not([80,1,PRTruck,"BLUFORSpawn"] call distanceUnits)) or ({((side _x == side_green) || (side _x == side_red)) and (_x distance PRTruck < 50)} count allUnits != 0)) and (alive PRTruck)) then {
				{if (isPlayer _x) then {[petros,"hint","Stay near the truck, keep the perimeter clear of hostiles."] remoteExec ["commsMP",_x]}} forEach ([150,0,PRTruck,"BLUFORSpawn"] call distanceUnits);
			};
			waitUntil {sleep 1; (!alive PRTruck) or (([80,1,PRTruck,"BLUFORSpawn"] call distanceUnits) and ({((side _x == side_green) || (side _x == side_red)) and (_x distance PRTruck < 50)} count allUnits == 0)) or (dateToNumber date > _fechalimnum)};
		};

		// if unloading was finished, reset all respective flags, escape to the outer loop
		if ((alive PRTruck) and !(_counter < _deploymentTime)) exitWith {
			_info = "";
			server setVariable ["pr_unloading_pamphlets", false, true];
			_canUnload = false;
			[[PRTruck,"remove"],"flagaction"] call BIS_fnc_MP;
			_counter = 0;
			PRTruck lock 0;
			{if (isPlayer _x) then {[PRTruck,false] remoteExec ["fnc_lockVehicle",_x];}} forEach ([100,0,PRTruck,"BLUFORSpawn"] call distanceUnits);
			_flagOne = false;
			_flagTwo = false;
			_flagThree = false;
			_currentDropCount = _currentDropCount + 1;

			// if there are sites to go, inform player
			if (_currentDropCount < 3) then {
				_info = "Head to the next location.";
				{if (isPlayer _x) then {[petros,"hint",_info] remoteExec ["commsMP",_x]}} forEach ([150,0,PRTruck,"BLUFORSpawn"] call distanceUnits);
			};
		};
		sleep 1;
	};

	// remove unload action if truck isn't close enough to current site
	if (_canUnload) then {
		_canUnload = false;
		[[PRTruck,"remove"],"flagaction"] call BIS_fnc_MP;
	};
	sleep 1;
};

// fail if the truck is destroyed or the timer runs out
if ((not alive PRTruck) or (dateToNumber date > _fechalimnum)) then {
	_tsk = ["PR",[side_blue,civilian], [format [_tskDesc_fail, _targetName],_tskTitle,_targetMarker],_targetPosition,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[0,-2,_targetMarker] remoteExec ["citySupportChange",2];
	[-10,AS_commander] call playerScoreAdd;
}
else {
	_tsk = ["PR",[side_blue,civilian], [format [_tskDesc_success,_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_targetMarker],_targetPosition,"SUCCEEDED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[-15,5,_targetMarker] remoteExec ["citySupportChange",2];
	[5,0] remoteExec ["prestige",2];
	{if (_x distance _targetPosition < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[5,AS_commander] call playerScoreAdd;
	["mis"] remoteExec ["fnc_BE_XP", 2];
};

[1200,_tsk] spawn borrarTask;
waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,PRTruck,"BLUFORSpawn"] call distanceUnits)) or ((PRTruck distance (getMarkerPos "FIA_HQ") < 60) && (speed PRTruck < 1))};
if ((PRTruck distance (getMarkerPos "FIA_HQ") < 60) && (speed PRTruck < 1)) then {
	[PRTruck] call vaciar;
	deleteVehicle PRTruck;
};
{deleteVehicle _x} forEach _PRCrates;
sleep 1;
deleteVehicle PRTruck;

waitUntil {sleep 1; (not([AS_P("spawnDistance"),1,_targetPosition,"BLUFORSpawn"] call distanceUnits))};
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteGroup _x} forEach _grupos;
{deleteVehicle _x} forEach _leafletDrops;
