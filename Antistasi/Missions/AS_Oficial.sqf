if (!isServer and hasInterface) exitWith {};
params ["_location", "_source"];

private _posicion = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;

private _tskTitle = localize "STR_tsk_ASOfficer";
private _tskDesc = localize "STR_tskDesc_ASOfficer";

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

_tiempolim = 30;//120
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_tsk = ["AS",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
	_tskTitle,_location],_posicion,"CREATED",5,true,true,"Kill"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
_grp = createGroup side_red;

_oficial = ([_posicion, 0, opI_OFF, _grp] call bis_fnc_spawnvehicle) select 0;
_piloto = ([_posicion, 0, opI_PIL, _grp] call bis_fnc_spawnvehicle) select 0;

_grp selectLeader _oficial;
sleep 1;
[leader _grp, _location, "SAFE", "SPAWNED", "NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

{[_x] spawn CSATinit; _x allowFleeing 0} forEach units _grp;

waitUntil {sleep 1; (dateToNumber date > _fechalimnum) or (not alive _oficial)};

if (not alive _oficial) then {
	_tsk = ["AS",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
		_tskTitle,_location],_posicion,"SUCCEEDED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[0,300] remoteExec ["resourcesFIA",2];
	[1800] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posicion,"BLUFORSpawn"] call distanceUnits);
	[5,AS_commander] call playerScoreAdd;
	[_location,30] call AS_fnc_location_increaseBusy;
	["mis"] remoteExec ["fnc_BE_XP", 2];
} else {
	_tsk = ["AS",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
		_tskTitle,_location],_posicion,"FAILED",5,true,true,"Kill"] call BIS_fnc_setTask;
	[-600] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];
	[-10,AS_commander] call playerScoreAdd;
	[_location,-30] call AS_fnc_location_increaseBusy;
};

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val - 1, true];
};

{deleteVehicle _x} forEach units _grp;
deleteGroup _grp;

[1200,_tsk] spawn borrarTask;
