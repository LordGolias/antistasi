#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};
params ["_banco"];

_tskTitle = localize "STR_tsk_logBank";
_tskDesc = localize "STR_tskDesc_logBank";

private _posicion = getPos _banco;
private _posbase = getMarkerPos "FIA_HQ";

_tiempolim = 120;
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_ciudad = [call AS_fnc_location_cities, _posicion] call BIS_fnc_nearestPosition;
_mrkfin = createMarker [format ["LOG%1", random 100], _posicion];
_nombredest = [_ciudad] call localizar;
_mrkfin setMarkerShape "ICON";

_pos = (getMarkerPos "FIA_HQ") findEmptyPosition [1,50,"C_Van_01_box_F"];

_camion = "C_Van_01_box_F" createVehicle _pos;
{_x reveal _camion} forEach (allPlayers - hcArray);
[_camion] spawn vehInit;
_camion setVariable ["destino",_nombredest,true];
_camion addEventHandler ["GetIn",
	{
	if (_this select 1 == "driver") then
		{
		_texto = format ["Bring this truck to %1 Bank and park it in the main entrance",(_this select 0) getVariable "destino"];
		_texto remoteExecCall ["hint",_this select 2];
		};
	}];

[_camion,"Mission Vehicle"] spawn inmuneConvoy;

_tsk = ["LOG",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_mrkfin],_posicion,"CREATED",5,true,true,"Interact"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
_mrk = createMarkerLocal [format ["%1patrolarea", floor random 100], _posicion];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [30,30];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerAlphaLocal 0;

_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _mrk, "SAFE","SPAWNED", "NOVEH2", "FORTIFY"] execVM "scripts\UPSMON.sqf";
{[_x, false] spawn AS_fnc_initUnitAAF} forEach units _grupo;

_posicion = _banco buildingPos 1;

waitUntil {sleep 1; (dateToNumber date > _fechalimnum) or (!alive _camion) or (_camion distance _posicion < 7)};

if ((dateToNumber date > _fechalimnum) or (!alive _camion)) then
	{
	_tsk = ["LOG",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_mrkfin],_posicion,"FAILED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[5000] remoteExec ["resourcesAAF",2];
	[-1800] remoteExec ["timingCA",2];
	[-10,AS_commander] call playerScoreAdd;
	}
else
	{
	_cuenta = 120;//120
	[_posicion] remoteExec ["patrolCA",HCattack];
	{_amigo = _x;
	if (_amigo distance _camion < 300) then
		{
		if ((captive _amigo) and (isPlayer _amigo)) then {[player,false] remoteExec ["setCaptive",_amigo]};
		{if (side _x == side_green) then {_x reveal [_amigo,4]};
		} forEach allUnits;
		};
	} forEach ([AS_P("spawnDistance"),0,_posicion,"BLUFORSpawn"] call distanceUnits);
	while {(_cuenta > 0) or (_camion distance _posicion < 7) and (alive _camion) and (dateToNumber date < _fechalimnum)} do
		{
		while {(_cuenta > 0) and (_camion distance _posicion < 7) and (alive _camion)} do
			{
			_formato = format ["%1", _cuenta];
			{if (isPlayer _x) then {[petros,"countdown",_formato] remoteExec ["commsMP",_x]}} forEach ([80,0,_camion,"BLUFORSpawn"] call distanceUnits);
			sleep 1;
			_cuenta = _cuenta - 1;
			};
		if (_cuenta > 0) then
			{
			_cuenta = 120;//120
			if (_camion distance _posicion > 6) then {[[petros,"hint","Don't get the truck far from the bank or count will restart"],"commsMP"] call BIS_fnc_MP};
			waitUntil {sleep 1; (!alive _camion) or (_camion distance _posicion < 7) or (dateToNumber date < _fechalimnum)};
			}
		else
			{
			if (alive _camion) then
				{
				{if (isPlayer _x) then {[petros,"hint","Drive the Truck back to base to finish this mission"] remoteExec ["commsMP",_x]}} forEach ([80,0,_camion,"BLUFORSpawn"] call distanceUnits);
				};
			};
		};
	};


waitUntil {sleep 1; (dateToNumber date > _fechalimnum) or (!alive _camion) or (_camion distance _posbase < 50)};
if ((_camion distance _posbase < 50) and (dateToNumber date < _fechalimnum)) then
	{
	_tsk = ["LOG",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_mrkfin],_posicion,"SUCCEEDED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[0,5000] remoteExec ["resourcesFIA",2];
	[-2,0] remoteExec ["prestige",2];
	[1800] remoteExec ["timingCA",2];
	{if (_x distance _camion < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[5,AS_commander] call playerScoreAdd;
	// BE module
	if (hayBE) then {
		["mis"] remoteExec ["fnc_BE_XP", 2];
	};
	// BE module
	};
if (!alive _camion) then
	{
	_tsk = ["LOG",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4, A3_STR_INDEP],_tskTitle,_mrkfin],_posicion,"FAILED",5,true,true,"Interact"] call BIS_fnc_setTask;
	[1800] remoteExec ["timingCA",2];
	[-10,AS_commander] call playerScoreAdd;
	};

waitUntil {sleep 1; speed _camion == 0};

[_camion] call vaciar;
deleteVehicle _camion;

[1200,_tsk] spawn borrarTask;

waitUntil {sleep 1; !([AS_P("spawnDistance"),1,_posicion,"BLUFORSpawn"] call distanceUnits)};

{deleteVehicle _x} forEach units _grupo;
deleteGroup _grupo;

deleteMarker _mrk;
deleteMarker _mrkfin;
