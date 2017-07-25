params ["_mission"];

private _airports = (["airfield", "FIA"] call AS_fnc_location_TS) + ["spawnNATO"];

private _origin = [_airports, AS_commander] call BIS_fnc_nearestPosition;
private _originPos = _origin call AS_fnc_location_position;

private _tiempolim = 30;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _nombreorig = "the NATO Carrier";
if (_origin != "spawnNATO") then {_nombreorig = [_origin] call localizar};

private _tskDesc = format ["NATO is providing a UAV from %1. It will be under our command in a few seconds and until %2:%3.",_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];
private _tskTitle = "NATO UAV";

private _task = [_mission,[side_blue,civilian],[_tskDesc,_tskTitle,_origin],_originPos,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;

private _groups = [];
private _vehicles = [];

private _fnc_clean = {
	{AS_commander hcRemoveGroup _x} forEach _groups;
	[_groups, _vehicles] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

private _grupoHeli = createGroup side_blue;
_groups pushBack _grupoHeli;
_grupoHeli setVariable ["esNATO",true,true];
_grupoHeli setGroupId ["UAV"];

private _helifn = [_originPos, 0, selectRandom bluUAV, side_blue] call bis_fnc_spawnvehicle;
private _heli = _helifn select 0;
_vehicles pushBack _heli;
createVehicleCrew _heli;
{[_x] call NATOinitCA; [_x] join _grupoHeli} forEach (crew _heli);
_heli setPosATL [getPosATL _heli select 0, getPosATL _heli select 1, 1000];
_heli flyInHeight 300;

sleep 5;

AS_commander hcSetGroup [_grupoHeli];
_grupoHeli setVariable ["isHCgroup", true, true];

waitUntil {sleep 1;
	(dateToNumber date > _fechalimnum) or
	({alive _x or canMove _x} count _vehicles == 0)
};

if (dateToNumber date > _fechalimnum) then {
	_task = [_mission, [side_blue,civilian],[_tskDesc,_tskTitle,_origin],_originPos,"SUCCEEDED",5,true,true,"Attack"] call BIS_fnc_setTask;
} else {
	_task = [_mission, [side_blue,civilian],[_tskDesc,_tskTitle,_origin],_originPos,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[-5,0] remoteExec ["prestige",2];
};

call _fnc_clean;
