#include "../macros.hpp"
private ["_tam","_road","_veh","_vehCrew","_grupoVeh","_grupo","_grupoP"];

private _soldados = [];
private _vehiculos = [];
private _grupos = [];
private _roads = [];

private _validTypes = vehPatrol + ["I_Boat_Armed_01_minigun_F"];

private _base = "";
private _type = "";
while {count _validTypes != 0} do {
	_type = selectRandom _validTypes;
	private _arrayBases = bases - mrkFIA;
	if (_type in (["armedHelis", "transportHelis"] call AS_fnc_AAFarsenal_all)) then {
		_arrayBases = aeropuertos - mrkFIA;
	};
	if (_type == "I_Boat_Armed_01_minigun_F") then {
		_arrayBases = puertos - mrkFIA;
	};

	// get a valid starting base
	while {count _arraybases != 0} do {
		private _potential_base = [_arraybases, getMarkerPos "respawn_west"] call BIS_fnc_nearestPosition;
		if !(spawner getVariable _potential_base) exitWith {
			_base = _potential_base;  // suitable base gound.
		};
		_arraybases = _arraybases - [_potential_base];
	};
	// if no suitable base was found, the type is not suitable
	if (count _arraybases == 0) then {
		_validTypes = _validTypes - [_type]
	};
};

if (count _validTypes == 0) exitWith {};

private _posbase = getMarkerPos _base;
private _category = [_type] call AS_fnc_AAFarsenal_category;

private _arraydestinos = [mrkAAF] call patrolDestinos;
private _distancia = 50;

private _isFlying = _category in ["armedHelis","transportHelis", "planes"];
if (_isFlying) then {
	_arrayDestinos = mrkAAF;
	_distancia = 200;
};
if (_type == "I_Boat_Armed_01_minigun_F") then {
	_arraydestinos = seaMarkers select {(getMarkerPos _x) distance _posbase < 2500};
	_distancia = 100;
};

if (count _arraydestinos < 1) exitWith {};

///////////// CHECKS COMPLETED -> CREATE PATROL /////////////

AAFpatrols = AAFpatrols + 1; publicVariableServer "AAFpatrols";

if (!_isFlying) then
	{
	if (_tipoCoche == "I_Boat_Armed_01_minigun_F") then
		{
		_posbase = [_posbase,50,150,10,2,0,0] call BIS_Fnc_findSafePos;
		}
	else
		{
		_tam = 10;
		while {true} do
			{
			_roads = _posbase nearRoads _tam;
			if (count _roads > 0) exitWith {};
			_tam = _tam + 10;
			};
		_road = _roads select 0;
		_posbase = position _road;
		};
	};

_vehicle=[_posbase, 0,_tipoCoche, side_green] call bis_fnc_spawnvehicle;
_veh = _vehicle select 0;
[_veh, "AAF"] call AS_fnc_initVehicle;
[_veh,"Patrol"] spawn inmuneConvoy;
_vehCrew = _vehicle select 1;
{[_x] spawn AS_fnc_initUnitAAF} forEach _vehCrew;
_grupoVeh = _vehicle select 2;
_soldados = _soldados + _vehCrew;
_grupos = _grupos + [_grupoVeh];
_vehiculos = _vehiculos + [_veh];


if (_tipoCoche isKindOf "Car") then
	{
	sleep 1;
	_tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
	_grupo = [_posbase, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
	{_x assignAsCargo _veh; _x moveInCargo _veh; _soldados = _soldados + [_x]; [_x] join _grupoveh; [_x] spawn AS_fnc_initUnitAAF} forEach units _grupo;
	deleteGroup _grupo;
	[_veh] spawn smokeCover;
	};

while {alive _veh} do
	{
	_destino = _arraydestinos call bis_Fnc_selectRandom;
	_posdestino = getMarkerPos _destino;
	_Vwp0 = _grupoVeh addWaypoint [_posdestino, 0];
	_Vwp0 setWaypointType "MOVE";
	_Vwp0 setWaypointBehaviour "SAFE";
	_Vwp0 setWaypointSpeed "LIMITED";
	_veh setFuel 1;
	while {true} do
		{
		sleep 20;
		{
		if (_x select 2 == side_blue) then
			{
			//hint format ["%1",_x];
			_arevelar = _x select 4;
			_nivel = (driver _veh) knowsAbout _arevelar;
			if (_nivel > 1.4) then
				{
				{
				_grupoP = _x;
				if (leader _grupoP distance _veh < AS_P("spawnDistance")) then {_grupoP reveal [_arevelar,_nivel]};
				} forEach allGroups;
				};
			};
		} forEach (driver _veh nearTargets AS_P("spawnDistance"));
		if ((_veh distance _posdestino < _distancia) or ({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados) or (!canMove _veh)) exitWith {};
		};

	if (({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados) or (!canMove _veh)) exitWith {};
	if (_isFlying) then
		{
		_arrayDestinos = mrkAAF;
		}
	else
		{
		if (_tipoCoche == "I_Boat_Armed_01_minigun_F") then
			{
			_arraydestinos = seaMarkers select {(getMarkerPos _x) distance position _veh < 2500};
			}
		else
			{
			_arraydestinos = [mrkAAF] call patrolDestinos;
			};
		};
	};


AAFpatrols = AAFpatrols - 1;publicVariableServer "AAFpatrols";
{_unit = _x;
waitUntil {sleep 1;!([AS_P("spawnDistance"),1,_unit,"BLUFORSpawn"] call distanceUnits)};deleteVehicle _unit} forEach _soldados;

{_veh = _x;
if !([AS_P("spawnDistance"),1,_veh,"BLUFORSpawn"] call distanceUnits) then {deleteVehicle _veh}} forEach _vehiculos;
{deleteGroup _x} forEach _grupos;
