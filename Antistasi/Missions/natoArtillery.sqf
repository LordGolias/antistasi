#include "../macros.hpp"
params ["_mission"];
private _location = _mission call AS_fnc_mission_location;
private _position = _location call AS_fnc_location_position;
private _power = [_mission, "power"] call AS_fnc_object_get;

private _tiempolim = _power;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tskTitle = "NATO Artillery support";
private _tskDesc = format ["We have NATO Artillery support from %1. They will be under our command until %2:%3.",[_location] call localizar,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4];

private _task = [_mission,[west,civilian],[_tskDesc,_tskTitle,_location],_position,"CREATED",5,true,true,"target"] call BIS_fnc_setTask;

private _group = createGroup WEST;
private _vehicles = [];

private _fnc_clean = {
	AS_commander hcRemoveGroup _group;
	[[_group], _vehicles] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

_group setVariable ["esNATO",true,true];
_group setGroupOwner (owner AS_commander);
_group setGroupId ["N.Arty"];
AS_commander hcSetGroup [_group];
_group setVariable ["isHCgroup", true, true];

private _tipoVeh = selectRandom bluStatMortar;
private _units = 1;
private _spread = 0;
if (_power < 33) then {
	_units = 4;
	_spread = 15;
} else {
	if (_power < 66) then {
		_tipoVeh = selectRandom bluArty;
	} else {
		_units = 2;
		_spread = 20;
		_tipoVeh = selectRandom bluMLRS;
	};
};

for "_i" from 1 to _units do {
	private _unit = ([_position, 0, bluGunner, _group] call bis_fnc_spawnvehicle) select 0;
	[_unit] call NATOinitCA;
	private _pos = [_position] call fnc_findSpawnSpots;
	private _veh = createVehicle [_tipoVeh, _pos, [], _spread, "NONE"];
	[_veh] call NATOvehInit;
	_unit moveInGunner _veh;
	_vehicles pushBack _veh;
};

waitUntil {sleep 10; (dateToNumber date > _fechalimnum) or ({alive _x} count _vehicles == 0)};

if ({alive _x} count _vehicles == 0) then {
	_task = [_mission,[west,civilian],[_tskDesc,_tskTitle,_location],_position,"FAILED",5,true,true,"target"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_fail", 2];
} else {
	_task = [_mission,[west,civilian],[_tskDesc,_tskTitle,_location],_position,"SUCCEEDED",5,true,true,"target"] call BIS_fnc_setTask;
	[_mission] remoteExec ["AS_fnc_mission_success", 2];
};

call _fnc_clean;
