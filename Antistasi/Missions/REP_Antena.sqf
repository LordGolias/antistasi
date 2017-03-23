if (!isServer and hasInterface) exitWith{};

_tskTitle = localize "STR_tsk_repAntenna";
_tskDesc = localize "STR_tskDesc_repAntenna";

private ["_marcador","_posicion","_fechalim","_fechalimnum","_nombredest","_camionCreado","_size","_pos","_veh","_grupo","_unit"];

_marcador = _this select 0;
_posicion = _this select 1;

_tiempolim = 60;
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;
_nombredest = [_marcador] call localizar;

_tsk = ["REP",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_marcador],_posicion,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
_camionCreado = false;

waitUntil {sleep 1;(dateToNumber date > _fechalimnum) or (spawner getVariable _marcador)};

if (spawner getVariable _marcador) then
	{
	_camionCreado = true;
	_size = [_marcador] call sizeMarker;
	_pos = [];
	_pos = _posicion findEmptyPosition [10,60,selectRandom vehTruckBox];
	_veh = createVehicle [selectRandom vehTruckBox, _pos, [], 0, "NONE"];
	_veh allowdamage false;
	_veh setDir random 360;
	[_veh] spawn genVEHinit;
	_grupo = createGroup side_green;

	sleep 5;
	_veh allowDamage true;

	for "_i" from 1 to 3 do
		{
		_unit = ([_pos, 0, sol_CREW, _grupo] call bis_fnc_spawnvehicle) select 0;
		[_unit] spawn AS_fnc_initUnitOPFOR;
		sleep 2;
		};

	waitUntil {sleep 1;(dateToNumber date > _fechalimnum) or (not alive _veh)};

	if (not alive _veh) then
		{
		_tsk = ["REP",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_marcador],_posicion,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		[2,0] remoteExec ["prestige",2];
		[1200] remoteExec ["timingCA",2];
		{if (_x distance _veh < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
		[5,stavros] call playerScoreAdd;
		};
	};
if (dateToNumber date > _fechalimnum) then
	{
	if (_marcador in mrkFIA) then
		{
		_tsk = ["REP",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_marcador],_posicion,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		[2,0] remoteExec ["prestige",2];
		[1200] remoteExec ["timingCA",2];
		{if (_x distance _veh < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
		[5,stavros] call playerScoreAdd;
		// BE module
		if (hayBE) then {
			["mis"] remoteExec ["fnc_BE_XP", 2];
		};
		// BE module
		}
	else
		{
		_tsk = ["REP",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_marcador],_posicion,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		//[5,0,_posicion] remoteExec ["citySupportChange",2];
		[-600] remoteExec ["timingCA",2];
		[-10,stavros] call playerScoreAdd;
		};
	antenasMuertas = antenasMuertas - [_posicion];
	_antena = nearestBuilding _posicion;
	if (isMultiplayer) then {_antena hideObjectGlobal true} else {_antena hideObject true};
	_antena = createVehicle ["Land_Communication_F", _posicion, [], 0, "NONE"];
	antenas = antenas + [_antena];
	publicVariable "antenas";
	_mrkfin = createMarker [format ["Ant%1", count antenas], _posicion];
	_mrkfin setMarkerShape "ICON";
	_mrkfin setMarkerType "loc_Transmitter";
	_mrkfin setMarkerColor "ColorBlack";
	_mrkfin setMarkerText "Radio Tower";
	mrkAntenas = mrkAntenas + [_mrkfin];
	_antena addEventHandler ["Killed",
		{
		_antena = _this select 0;
		_mrk = [mrkAntenas, _antena] call BIS_fnc_nearestPosition;
		antenas = antenas - [_antena]; antenasmuertas = antenasmuertas + [getPos _antena]; deleteMarker _mrk;
		[["TaskSucceeded", ["", "Radio Tower Destroyed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		}
		];
	};

_resourcesAAF = server getVariable "resourcesAAF";
_resourcesAAF = _resourcesAAF - 10000;
server setVariable ["resourcesAAF",_resourcesAAF,true];
[60,_tsk] spawn borrarTask;

waitUntil {sleep 1; not (spawner getVariable _marcador)};

if (_camionCreado) then
	{
	{deleteVehicle _x} forEach units _grupo;
	deleteGroup _grupo;
	if (!([distanciaSPWN,1,_veh,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _veh};
	};
