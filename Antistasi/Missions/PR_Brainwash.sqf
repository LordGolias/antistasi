#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _targetName = [_location] call localizar;

// mission timer
private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = _mission call AS_fnc_mission_title;
private _tskDesc = localize "STR_tskDesc_PRBrain";
private _tskDesc_fail = format [localize "STR_tskDesc_PRBrain_fail",_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];
private _tskDesc_fail2 = format [localize "STR_tskDesc_PRBrain_fail2",_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];
private _tskDesc_hold = format [localize "STR_tskDesc_PRBrain_hold",_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];
private _tskDesc_success = format [localize "STR_tskDesc_PRBrain_success",_targetName,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"Heal"] call BIS_fnc_setTask;


// find bases and airports to serve as spawnpoints for reinforcements
private _bases = [];
{
	private _posbase = _x call AS_fnc_location_position;
	if ((_position distance _posbase < 7500) and
	    (_position distance _posbase > 1500) and !(_x call AS_fnc_location_spawned)) then {
		_bases pushBack _x;
	};
} forEach (["base", "AAF"] call AS_fnc_location_TS);

private _base = "";
if (count _bases > 0) then {
	_base = [_bases,_position] call BIS_fnc_nearestPosition;
};

private _airports = [];
{
	private _posAirport = _x call AS_fnc_location_position;
	if ((_position distance _posAirport < 7500) and
	    (_position distance _posAirport > 1500) and
		!(_x call AS_fnc_location_spawned)) then {
		_airports pushBack _x;
	};
} forEach (["airfield", "AAF"] call AS_fnc_location_TS);
private _airport = "";
if (count _airports > 0) then {
	_airport = [_airports, _position] call BIS_fnc_nearestPosition;
};

// spawn mission vehicle
propTruck = "";
propTruck = "C_Truck_02_box_F" createVehicle ((getMarkerPos "FIA_HQ") findEmptyPosition [10,50,"C_Truck_02_box_F"]);

// spawn eye candy
private _grafArray = [];
private _graf1 = "Land_Graffiti_02_F" createVehicle [0,0,0];
_graf1 attachTo [propTruck,[-1.32,-2.5,-0.15]];
_graf1 setDir (getDir propTruck + 90);
_grafArray pushBack _graf1;

private _graf2 = "Land_Graffiti_05_F" createVehicle [0,0,0];
_graf2 attachTo [propTruck,[-1.32,0.6,-0.5]];
_graf2 setDir (getDir propTruck + 90);
_grafArray pushBack _graf2;

private _graf3 = "Land_Graffiti_05_F" createVehicle [0,0,0];
_graf3 attachTo [propTruck,[1.32,0.6,-0.5]];
_graf3 setDir (getDir propTruck + 270);
_grafArray pushBack _graf3;

private _graf4 = "Land_Graffiti_03_F" createVehicle [0,0,0];
_graf4 attachTo [propTruck,[1.32,-2.5,-0.15]];
_graf4 setDir (getDir propTruck + 270);
_grafArray pushBack _graf4;

// initialize mission vehicle
[propTruck, "FIA"] call AS_fnc_initVehicle;
{_x reveal propTruck} forEach (allPlayers - hcArray);
propTruck setVariable ["destino", _targetName, true];
propTruck addEventHandler ["GetIn", {
	if (_this select 1 == "driver") then {
		private _texto = format ["Bring this gear to %1",(_this select 0) getVariable "destino"];
		_texto remoteExecCall ["hint",_this select 2];
	};
}];
private _truck = propTruck;
private _objectsToDelete = [];

[propTruck,"Mission Vehicle"] spawn inmuneConvoy;

// set the flags for active item and active broadcast
server setVariable ["activeItem", propTruck, true];
server setVariable ["BCactive", false, true];

// dispatch a small QRF
if !(_airport == "") then {
	[_airport, _position, _location, _tiempolim, "transport", "small"] remoteExec ["enemyQRF",HCattack];
}
else {
	[_base, _position, _location, _tiempolim, "transport", "small"] remoteExec ["enemyQRF",HCattack];
};

private _fnc_clean = {
	[[], _objectsToDelete + _grafArray + [propTruck]] call AS_fnc_cleanResources;

	// reset the flag for active attack-spawning objects
	server setVariable ["activeItem", nil, true];

	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or (not alive _truck)};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc_fail,_tskTitle,_location],_position,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	params ["_prestige"];
	_task = [_mission,[side_blue,civilian],[_tskDesc_success,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission, _prestige] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};


// wait until the vehicle enters the target area
waitUntil {sleep 1; (_truck distance _position < 150) or _fnc_missionFailedCondition};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;


while {not ((server getVariable "BCactive") or _fnc_missionFailedCondition)} do {
	private _active = false;
	while {(_truck distance _position < 150) and
		not ((server getVariable "BCactive") or _fnc_missionFailedCondition)} do {
		// activate if it is not moving
		if (not _active and (speed _truck < 1)) then {
			_active = true;
			[[_truck,"toggle_device"],"AS_fnc_addAction"] call BIS_fnc_MP;
			server setVariable ["BCdisabled", false, true];
		};
		// deactivate if it moves
		if (_active and (speed _truck > 1)) then {
			_active = false;
			[[_truck,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;
			server setVariable ["BCdisabled", true, true];
		};
		sleep 1;
	};
	sleep 1;
};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

// create & spawn the propaganda site
private _PRsite = [
	["Land_BagFence_Round_F",[1.57227,1.87622,-0.00130129],99.7986,1,0,[0,-0],"","",true,false],
	["Land_Sacks_heap_F",[2.81982,-0.622803,0],323.257,1,0,[0,0],"","",true,false],
	["Land_Loudspeakers_F",[3.146,0.9729,0],0,1,0,[0,0],"","",true,false],
	["Land_PortableLight_single_F",[3.54053,-2.40137,0],228.698,1,0,[0,0],"","",true,false],
	["Land_Leaflet_02_F",[4.14307,-1.47192,0.688],183.52,1,0,[-90,-90],"","",true,false],
	["Land_Leaflet_02_F",[4.1499,-1.65796,0.688],180,1,0,[-90,-90],"","",true,false],
	["Land_WoodenBox_F",[4.52734,0.615967,4.76837e-007],152.102,1,0,[6.94714e-005,1.89471e-005],"","",true,false],
	["Land_Leaflet_02_F",[4.2959,-1.56104,0.688],198.517,1,0,[-90,-90],"","",true,false],
	["Land_Leaflet_02_F",[4.27979,-1.82007,0.688],216.361,1,0,[-90,-90],"","",true,false],
	["Land_Leaflet_02_F",[4.49463,-1.39014,0.688],156.16,1,0,[-90,-90],"","",true,false],
	["Land_WoodenCrate_01_F",[4.44775,-1.86304,4.76837e-007],0.000621233,1,0.0256633,[-5.14494e-005,-0.000126096],"","",true,false],
	["Land_WoodenBox_F",[4.82568,0.0627441,0],329.984,1,0,[-4.90935e-005,1.14739e-006],"","",true,false],
	["Land_BagFence_Round_F",[3.896,3.3252,-0.00130129],193.76,1,0,[0,0],"","",true,false],
	["Land_Leaflet_02_F",[4.58105,-1.7041,0.688],127.235,1,0,[-90,-90],"","",true,false],
	["Land_WoodenCrate_01_stack_x3_F",[3.84229,-3.79712,0],0,1,0,[0,0],"","",true,false],
	["Flag_FIA_F",[5.04297,-2.52319,0],0,1,0,[0,0],"","",true,false],
	["Land_Sacks_heap_F",[6.08154,1.64722,0],27.137,1,0,[0,0],"","",true,false],
	["Land_PortableLight_single_F",[5.90527,2.94946,0],18.0931,1,0,[0,0],"","",true,false],
	["Land_Graffiti_05_F",[6.84229,-0.0407715,2.28578],128.676,1,0,[0,-0],"","",true,false],
	["SignAd_SponsorS_F",[6.84619,-0.0651855,6.67572e-006],130.045,1,0,[0,-0],"","",true,false]
];

private _posSiteBackup = (position _truck) findEmptyPosition [1,25,typeOf _truck];
private _posSite = [position _truck, 0, 20, 2, 0, 0.3, 0, [], [_posSiteBackup,[]]] call BIS_Fnc_findSafePos;
_objectsToDelete = [_posSite, random 360, _PRsite] call BIS_fnc_ObjectsMapper;

// remove crew from the truck, lock it, turn off the engine
{
	_x action ["eject", _truck];
} forEach (crew (_truck));
_truck lock 2;
_truck engineOn false;

// reveal the truck's location to all nearby enemies, blow the cover of all nearby friendlies
{
	private _amigo = _x;
	if (captive _amigo) then {
		[_amigo,false] remoteExec ["setCaptive",_amigo];
	};
	{
		if ((side _x == side_red) and (_x distance _truck < AS_P("spawnDistance"))) then {
			if (_x distance _truck < 300) then {_x doMove position _truck} else {_x reveal [_amigo,4]};
		};
	} forEach allUnits;
} forEach ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

/*
trigger the attack waves
parameters:
_timing: launch of a specific wave, time in minutes after the activation of the device
_comp: type of wave, see attackWaves.sqf for details

default setting based on number of players online
*/
private _timing = [5,10,16];
private _comp = ["QRF_air_mixed_small", "QRF_land_mixed_small", "CSAT_small"];
if (isMultiplayer) then {
	_timing = [0,5,10,20];
	_comp = ["QRF_air_mixed_small", "QRF_land_mixed_large", "QRF_land_transport_large","CSAT_small"];
	if (count (allPlayers - entities "HeadlessClient_F") > 3) then {
		_timing = [0,1,4,8,15,16,25];
		_comp = ["QRF_land_mixed_large", "QRF_air_mixed_small", "QRF_land_transport_large", "QRF_air_transport_large", "QRF_land_mixed_large", "QRF_air_mixed_large","CSAT_large"];
	};
};

[_location, 30, _timing, _comp] spawn attackWaves;

_task = [_mission,[side_blue,civilian],[_tskDesc_hold,_tskTitle,_location],_truck,"ASSIGNED",5,true,true,"Heal"] call BIS_fnc_setTask;


_fnc_missionFailedCondition = {not (alive _truck)};

// counter stops forever when no player within 300m or car deactivated
private _fnc_continueCounterCondition = {
	(server getVariable "BCactive") and
	({(side _x isEqualTo side_blue) and (_x distance _truck < 300)} count allPlayers > 0) and {not call _fnc_missionFailedCondition}
};

// counter increases when no enemy within 50m and anyone conscious
private _fnc_increaseCounterCondition = {
	{_x call AS_fnc_isUnconscious} count ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) !=
	 count ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) and
	({(side _x == side_red) and (_x distance _truck < 50)} count allUnits == 0)
};

/*
_minTimer: duration before the mission is not a failure
_counter: counts current duration
_active: flag for running counter
*/
private _minTimer = 600;
private _counter = 0;
private _active = false;
while _fnc_continueCounterCondition do {
	while {True and _fnc_continueCounterCondition and _fnc_increaseCounterCondition} do {

		// activate the timer
		if !(_active) then {
			_active = true;
			[[petros,"globalChat","Hold this position for as long as you can! They will throw a lot at you, so be prepared!"],"commsMP"] call BIS_fnc_MP;
		};

		{
			// warn players at the edge of the area to not stray too far
			private _distance = _x distance _truck;
			if (_distance > 250 and _distance < 350) then {
				[petros,"hint", "stay within 250m of the station!"] remoteExec ["commsMP", _x];
			};
		} forEach (allPlayers - hcArray);

		_counter = _counter + 1;
		sleep 1;
	};

	// suspend the counter
	if (not call _fnc_increaseCounterCondition) then {
		_active = false;

		if (not call _fnc_missionFailedCondition) then {
			[[petros,"globalChat","Hostile forces near the position"],"commsMP"] call BIS_fnc_MP
		};

		waitUntil {sleep 1; call _fnc_increaseCounterCondition or {not call _fnc_continueCounterCondition}};
	};
};

// stop the attack script from spawning additional waves
server setVariable ["waves_active", false, true];


// 10 city support for 10 minutes plus 1 for every additional 60 seconds
private _prestige = 0;
if (_counter >= _minTimer) then {
	_prestige = 10 + floor ((_counter - _minTimer) / 60);
};

// inform players about timer at the end of the mission
private _info = format ["You held the area clear for %1 minutes and %2 seconds.", floor (_counter / 60), _counter mod 60];
if (_prestige == 0) then {
	_info = format ["You only held the area for %1 minutes and %2 seconds. That is unacceptable.", floor (_counter / 60), _counter mod 60];
};
{if (isPlayer _x) then {[petros,"globalChat", _info] remoteExec ["commsMP",_x]}} forEach ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);


// failure if you held out for less than 10 minutes
if (_prestige == 0) exitWith {
	_task = [_mission,[side_blue,civilian],[_tskDesc_fail2,_tskTitle,_location],_position,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
};

[_prestige] call _fnc_missionSuccessful;
