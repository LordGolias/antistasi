#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};

_origen = _this select 0;
_destino = _this select 1;

_posOrigen = getMarkerPos _origen;
_posDestino = getMarkerPos _destino;

_nombredest = [_destino] call localizar;
_nombreorig = [_origen] call localizar;
_tiempolim = 60;
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_tsk = ["NATOArmor",[side_blue,civilian],[format ["Our Commander asked NATO for an armored column departing from %2 with destination %1. Help them in order to have success in this operation. They will stay on mission until %3:%4.",_nombredest,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],"NATO Armor",_destino],_posDestino,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";
_soldados = [];
_vehiculos = [];

_cuenta = AS_P("prestigeNATO");
_cuenta = round (_cuenta / 25);
[-20,0] remoteExec ["prestige",2];

_grupo = createGroup side_blue;
_grupo setVariable ["esNATO",true,true];
_tam = 10;
_roads = [];
_wp0 = _grupo addWaypoint [_posdestino, 0];
_wp0 setWaypointType "SAD";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";

while {true} do
	{
	_roads = _posOrigen nearRoads _tam;
	if (count _roads > _cuenta) exitWith {};
	_tam = _tam + 10;
	};

for "_i" from 1 to _cuenta do
	{
	_vehicle=[position (_roads select (_i - 1)), 0, selectRandom bluMBT, _grupo] call bis_fnc_spawnvehicle;
	_veh = _vehicle select 0;
	[_veh] spawn NATOVEHinit;
	[_veh,"NATO Armor"] spawn inmuneConvoy;
	_vehCrew = _vehicle select 1;
	{[_x] spawn NATOinitCA} forEach _vehCrew;
	_soldados = _soldados + _vehCrew;
	_vehiculos = _vehiculos + [_veh];
	_veh allowCrewInImmobile true;
	sleep 15;
	};

waitUntil {sleep 10; (dateToNumber date > _fechalimnum) or ({alive _x} count _soldados == 0) or ({(alive _x)} count _vehiculos == 0)};

if (({alive _x} count _soldados == 0) or ({(alive _x)} count _vehiculos == 0)) then
	{
	_tsk = ["NATOArmor",[side_blue,civilian],[format ["Our Commander asked NATO for an armored column departing from %2 with destination %1. Help them in order to have success in this operation. They will stay on mission until %3:%4.",_nombredest,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],"NATO Armor",_destino],_posDestino,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[-10,0] remoteExec ["prestige",2];
	};

sleep 15;

{
_soldado = _x;
waitUntil {sleep 1; {_x distance _soldado < distanciaSPWN} count (allPlayers - hcArray) == 0};
deleteVehicle _soldado;
} forEach _soldados;
deleteGroup _grupo;
{
_vehiculo = _x;
waitUntil {sleep 1; {_x distance _vehiculo < distanciaSPWN} count (allPlayers - hcArray) == 0};
deleteVehicle _x} forEach _vehiculos;

[0,_tsk] spawn borrarTask;