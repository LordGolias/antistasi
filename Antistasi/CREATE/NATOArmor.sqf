#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};
params ["_origen", "_destino"];

private _posOrigen = getMarkerPos _origen;
private _posDestino = getMarkerPos _destino;

private _nombredest = [_destino] call localizar;
private _nombreorig = [_origen] call localizar;
private _tiempolim = 60;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

private _tsk = ["NATOArmor",
	[side_blue,civilian],
	[format ["Our Commander asked NATO for an armored column departing from %2 with destination %1. Help them in order to have success in this operation. They will stay on mission until %3:%4.",_nombredest,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
	"NATO Armor",_destino],_posDestino,
	"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

private _soldados = [];
private _vehiculos = [];

private _cuenta = round (AS_P("prestigeNATO") / 25);
[-20,0] remoteExec ["prestige",2];

private _grupo = createGroup side_blue;
_grupo setVariable ["esNATO",true,true];

private _wp0 = _grupo addWaypoint [_posdestino, 0];
_wp0 setWaypointType "SAD";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";

private _tam = 10;
private _roads = [];
while {true} do {
	_roads = _posOrigen nearRoads _tam;
	if (count _roads > _cuenta) exitWith {};
	_tam = _tam + 10;
};

for "_i" from 1 to _cuenta do {
	private _vehicle = [position (_roads select (_i - 1)), 0, selectRandom bluMBT, _grupo] call bis_fnc_spawnvehicle;
	private _veh = _vehicle select 0;
	[_veh, "NATO"] call AS_fnc_initVehicle;
	[_veh,"NATO Armor"] spawn inmuneConvoy;
	private _vehCrew = _vehicle select 1;
	{[_x] spawn NATOinitCA} forEach _vehCrew;
	_soldados append _vehCrew;
	_vehiculos pushBack _veh;
	_veh allowCrewInImmobile true;
	sleep 15;
};

waitUntil {sleep 10; (dateToNumber date > _fechalimnum) or ({alive _x} count _soldados == 0) or ({(alive _x)} count _vehiculos == 0)};

if (({alive _x} count _soldados == 0) or ({(alive _x)} count _vehiculos == 0)) then {
	_tsk = ["NATOArmor",
		[side_blue,civilian],
		[format ["Our Commander asked NATO for an armored column departing from %2 with destination %1. Help them in order to have success in this operation. They will stay on mission until %3:%4.",_nombredest,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],
		"NATO Armor",_destino],_posDestino,
		"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[-10,0] remoteExec ["prestige",2];
};

sleep 15;

{
private _soldado = _x;
waitUntil {sleep 1; {_x distance _soldado < AS_P("spawnDistance")} count (allPlayers - hcArray) == 0};
deleteVehicle _soldado;
} forEach _soldados;
deleteGroup _grupo;
{
private _vehiculo = _x;
waitUntil {sleep 1; {_x distance _vehiculo < AS_P("spawnDistance")} count (allPlayers - hcArray) == 0};
deleteVehicle _x} forEach _vehiculos;

[0,_tsk] spawn borrarTask;
