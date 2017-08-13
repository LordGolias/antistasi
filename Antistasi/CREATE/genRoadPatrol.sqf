#include "../macros.hpp"
private ["_tam","_road","_veh","_vehCrew","_grupoVeh","_grupo","_grupoP"];

private _soldados = [];
private _vehiculos = [];
private _grupos = [];
private _roads = [];

private _validTypes = vehPatrol + [vehBoat];

private _base = "";
private _type = "";
while {count _validTypes != 0} do {
	_type = selectRandom _validTypes;
	private _arrayBases = [["base"], "AAF"] call AS_fnc_location_TS;
	if (_type in (["armedHelis", "transportHelis"] call AS_fnc_AAFarsenal_all)) then {
		_arrayBases = [["airfield"], "AAF"] call AS_fnc_location_TS;
	};
	if (_type == vehBoat) then {
		_arrayBases = [["searport"], "AAF"] call AS_fnc_location_TS;
	};

	// get a valid starting base
	while {count _arraybases != 0} do {
		private _potential_base = [_arraybases, getMarkerPos "FIA_HQ"] call BIS_fnc_nearestPosition;
		if !(_potential_base call AS_fnc_location_spawned) exitWith {
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


private _groundDestinies = {
	private _posHQ = getMarkerPos "FIA_HQ";

	private _validLocations = [];
	private _allLocations = [
		["base", "airfield", "resource", "factory", "powerplant", "outpost", "outpostAA"],
		"AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		if (_posHQ distance _pos < 3000) then {_validLocations pushBack _x};
	} forEach _allLocations;
	_validLocations
};


private _posbase = _base call AS_fnc_location_position;
private _category = [_type] call AS_fnc_AAFarsenal_category;

private _arraydestinos = call _groundDestinies;
private _distancia = 50;

private _isFlying = _category in ["armedHelis","transportHelis", "planes"];
if (_isFlying) then {
	_arrayDestinos = "AAF" call AS_fnc_location_S;
	_distancia = 200;
};
if (_type == vehBoat) then {
	_arraydestinos = ([["searport"], "AAF"] call AS_fnc_location_TS) select {(_x call AS_fnc_location_position) distance _posbase < 2500};
	_distancia = 100;
};

if (count _arraydestinos < 1) exitWith {};

///////////// CHECKS COMPLETED -> CREATE PATROL /////////////

AAFpatrols = AAFpatrols + 1; publicVariableServer "AAFpatrols";

if (!_isFlying) then
	{
	if (_type == vehBoat) then
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

_vehicle=[_posbase, 0,_type, side_red] call bis_fnc_spawnvehicle;
_veh = _vehicle select 0;
[_veh, "AAF"] call AS_fnc_initVehicle;
[_veh,"Patrol"] spawn inmuneConvoy;
_vehCrew = _vehicle select 1;
{[_x] spawn AS_fnc_initUnitAAF} forEach _vehCrew;
_grupoVeh = _vehicle select 2;
_soldados = _soldados + _vehCrew;
_grupos = _grupos + [_grupoVeh];
_vehiculos = _vehiculos + [_veh];


if (_type isKindOf "Car") then
	{
	sleep 1;
	private _tipoGrupo = [infGarrisonSmall, "AAF"] call fnc_pickGroup;
	_grupo = [_posbase, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
	{_x assignAsCargo _veh; _x moveInCargo _veh; _soldados = _soldados + [_x]; [_x] join _grupoveh; [_x] spawn AS_fnc_initUnitAAF} forEach units _grupo;
	deleteGroup _grupo;
	[_veh] spawn smokeCover;
	};

while {alive _veh} do
	{
	_destino = _arraydestinos call bis_Fnc_selectRandom;
	_posdestino = _destino call AS_fnc_location_position;
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
		_arrayDestinos = "AAF" call AS_fnc_location_S;
		}
	else
		{
		if (_type == vehBoat) then
			{
			_arraydestinos = ([["searport"], "AAF"] call AS_fnc_location_TS) select {(_x call AS_fnc_location_position) distance (position _veh) < 2500};
			}
		else
			{
			_arraydestinos = call _groundDestinies;
			};
		};
	};


AAFpatrols = AAFpatrols - 1;publicVariableServer "AAFpatrols";
{_unit = _x;
waitUntil {sleep 1;!([AS_P("spawnDistance"), _unit, "BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance)};deleteVehicle _unit} forEach _soldados;

{_veh = _x;
if !([AS_P("spawnDistance"), _veh, "BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance) then {deleteVehicle _veh}} forEach _vehiculos;
{deleteGroup _x} forEach _grupos;
