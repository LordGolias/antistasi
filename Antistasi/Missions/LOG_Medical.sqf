#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;

private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _posHQ = "FIA_HQ" call AS_fnc_location_position;
private _fMarkers = "FIA" call AS_fnc_location_S;

// select list of valid bases
private _bases = [];
{
	private _posbase = _x call AS_fnc_location_position;
	if ((_position distance _posbase < 7500) and
		(_position distance _posbase > 1500) and
		(not (_x call AS_fnc_location_spawned))) then {_bases pushBack _x}
} forEach (["base", "AAF"] call AS_fnc_location_TS);

// select nearest base to
private _base = "";
private _posbase = [];
if (count _bases > 0) then {
	_base = [_bases,_position] call BIS_fnc_nearestPosition;
	_posbase = _base call AS_fnc_location_position;
};
if (_base == "") exitWith {
	hint "There are no supplies missing.";
};

private _nombreOrig = [_base] call localizar;

// find a suitable position for the medical supplies
// try 20 times, if fail, the mission does not start
private _poscrash = [];
for "_i" from 0 to 20 do {
	sleep 0.1;
	_poscrash = [_position,2000,random 360] call BIS_fnc_relPos;
	private _nfMarker = [_fMarkers,_poscrash] call BIS_fnc_nearestPosition;
	private _fposition = _nfMarker call AS_fnc_location_position;
	private _hposition = _nfMarker call AS_fnc_location_position;
	if ((!surfaceIsWater _poscrash) &&
	    (_poscrash distance _posHQ < 4000) &&
		(_fposition distance _poscrash > 500) &&
		(_hposition distance _poscrash > 800)) exitWith {};
};

if (_poscrash isEqualTo []) exitWith {
	hint "There are no supplies missing.";
};

private _tskTitle = _mission call AS_fnc_mission_title;
private _tskDesc = format [localize "STR_tskDesc_logMedical", [_location] call localizar,
	numberToDate [2035,_fechalimnum] select 3,
	numberToDate [2035,_fechalimnum] select 4,
	_nombreOrig, A3_STR_INDEP
];

private _tipoVeh = selectRandom AS_FIA_vans;

private _posCrashMrk = [_poscrash,random 200,random 360] call BIS_fnc_relPos;
_poscrash = _poscrash findEmptyPosition [0,100,_tipoVeh];
private _mrkfin = createMarker [format ["REC%1", random 100], _posCrashMrk];
_mrkfin setMarkerShape "ICON";

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posCrashMrk,"CREATED",5,true,true,"Heal"] call BIS_fnc_setTask;

private _vehiculos = [];
private _soldados = [];
private _grupos = [];

private _fnc_clean = {
	[_grupos, _vehiculos, [_mrkfin]] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _truck = createVehicle [_tipoVeh, _poscrash, [], 0, "CAN_COLLIDE"];
[_truck,"Mission Vehicle"] spawn inmuneConvoy;
reportedVehs pushBack _truck; publicVariable "reportedVehs";
_vehiculos pushBack _truck;

private _crate1 = "Box_IND_Support_F" createVehicle _poscrash;
private _crate2 = "Box_IND_Support_F" createVehicle _poscrash;
private _crate3 = "Box_NATO_WpsSpecial_F" createVehicle _poscrash;
private _crate4 = "Box_NATO_WpsSpecial_F" createVehicle _poscrash;
_vehiculos append [_crate1, _crate2, _crate3, _crate4];

_crate1 setPos ([getPos _truck, 6, 185] call BIS_Fnc_relPos);
_crate2 setPos ([getPos _truck, 4, 167] call BIS_Fnc_relPos);
_crate3 setPos ([getPos _truck, 8, 105] call BIS_Fnc_relPos);
_crate4 setPos ([getPos _truck, 5, 215] call BIS_Fnc_relPos);
_crate1 setDir (getDir _truck + (floor random 180));
_crate2 setDir (getDir _truck + (floor random 180));
_crate3 setDir (getDir _truck + (floor random 180));
_crate4 setDir (getDir _truck + (floor random 180));

[_crate1] call emptyCrate;
[_crate2] call emptyCrate;
[_crate3] call emptyCrate;
[_crate4] call emptyCrate;

_crate1 addItemCargoGlobal ["FirstAidKit", 40];
_crate2 addItemCargoGlobal ["FirstAidKit", 40];
_crate3 addItemCargoGlobal ["Medikit", 10];
_crate4 addItemCargoGlobal ["Medikit", 10];

private _tipoGrupo = [infGarrisonSmall, "AAF"] call fnc_pickGroup;
private _grupo = [_poscrash, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
_grupos pushBack _grupo;

{[_x] call AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;

sleep 30;

private _tam = 100;
private _road = objNull;
while {true} do {
	private _roads = _posbase nearRoads _tam;
	if (count _roads > 0) exitWith {_road = _roads select 0;};
	_tam = _tam + 50;
};

private _vehicle = [position _road, 0, selectRandom (["trucks"] call AS_fnc_AAFarsenal_valid), side_red] call bis_fnc_spawnvehicle;
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

_tipoGrupo = [infSquad, "AAF"] call fnc_pickGroup;
_grupo = [_posbase, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;

{_x assignAsCargo _veh; _x moveInCargo _veh; _soldados pushBack _x; [_x] call AS_fnc_initUnitAAF} forEach units _grupo;
_grupos pushBack _grupo;

[_veh] spawn smokeCover;

private _Vwp0 = _grupoVeh addWaypoint [_poscrash, 0];
_Vwp0 setWaypointType "TR UNLOAD";
_Vwp0 setWaypointBehaviour "SAFE";
private _Gwp0 = _grupo addWaypoint [_poscrash, 0];
_Gwp0 setWaypointType "GETOUT";
_Vwp0 synchronizeWaypoint [_Gwp0];

private _fnc_missionFailedCondition = {(dateToNumber date > _fechalimnum) or (not alive _truck)};

private _fnc_missionFailed = {
	_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_posCrashMrk,"FAILED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];

	call _fnc_clean;
};

private _fnc_missionSuccessful = {
	_task = [_mission, [side_blue,civilian], [_tskDesc,_tskTitle,_mrkfin], _posCrashMrk,"SUCCEEDED",5,true,true,"Heal"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];

	call _fnc_clean;
};

// wait for any activity around the truck
waitUntil {sleep 1;
	({(side _x == side_blue) and (_x distance _truck < 50)} count allUnits > 0) or _fnc_missionFailedCondition
};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkfin],_poscrash,"AUTOASSIGNED",5,true,true,"Heal"] call BIS_fnc_setTask;

// make all FIA around the truck non-captive
{
	if (captive _x) then {
		[_x,false] remoteExec ["setCaptive",_x];
	};
} forEach ([300, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

// make all enemies rush to the truck
{
	_x doMove _posCrash;
} forEach _soldados;


private _fnc_loadCratesCondition = {
	// The condition to allow loading the crates into the truck
	(_truck distance _poscrash < 20) and {speed _truck < 1} and
	{{alive _x and not (_x call AS_fnc_isUnconscious)} count ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance) > 0} and
	{{(side _x == side_red) and {_x distance _truck < 80}} count allUnits == 0}
};

private _str_unloadStopped = "Stop the truck closeby, have someone close to the truck and no enemies around";

// wait for the truck to unload (2m) or the mission to fail
[_truck, 120, _fnc_loadCratesCondition, _fnc_missionFailedCondition, _str_unloadStopped] call AS_fnc_wait_or_fail;

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

private _formato = format ["Good to go. Deliver these supplies to %1 on the double.",[_location] call localizar];
{if (isPlayer _x) then {[petros,"hint",_formato] remoteExec ["commsMP",_x]}} forEach ([80, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
_crate1 attachTo [_truck, [0.3,-1.0,-0.4]];
_crate2 attachTo [_truck, [-0.3,-1.0,-0.4]];
_crate3 attachTo [_truck, [0,-1.6,-0.4]];
_crate4 attachTo [_truck, [0,-2.0,-0.4]];

private _mrkTarget = createMarker [format ["REC%1", random 100], _position];
_mrkTarget setMarkerShape "ICON";

_task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_mrkTarget],_position,"AUTOASSIGNED",5,true,true,"Heal"] call BIS_fnc_setTask;

waitUntil {sleep 1; (_truck distance _position < 40) or _fnc_missionFailedCondition};

if (call _fnc_missionFailedCondition) exitWith _fnc_missionFailed;

[[petros,"globalChat","Leave the vehicle here, they'll come pick it up."],"commsMP"] call BIS_fnc_MP;

// remove fuel, eject all and lock
_truck setFuel 0;
{
	_x action ["eject", _truck];
} forEach (crew _truck);
sleep 1;
_truck lock 2;
{if (isPlayer _x) then {[_truck,true] remoteExec ["fnc_lockVehicle",_x];}} forEach ([100, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

call _fnc_missionSuccessful;
