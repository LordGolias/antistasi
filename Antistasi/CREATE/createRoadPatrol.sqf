#include "../macros.hpp"
private _soldados = [];
private _vehiculos = [];
private _grupos = [];

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
	if (_base != "") exitWith {};
	// no suitable base => type is not suitable
	_validTypes = _validTypes - [_type]
};


if (count _validTypes == 0) exitWith {
	AS_ISDEBUG("[AS] debug: fnc_createRoadPatrol cancelled: no valid types");
};


private _groundDestinations = {
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

private _arraydestinos = call _groundDestinations;
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

if (count _arraydestinos < 1) exitWith {
	AS_ISDEBUG("[AS] debug: fnc_createRoadPatrol cancelled: no valid destinations");
};

///////////// CHECKS COMPLETED -> CREATE PATROL /////////////

AAFpatrols = AAFpatrols + 1;
publicVariable "AAFpatrols";

if not _isFlying then {
	if (_type == vehBoat) then {
		_posbase = [_posbase,50,150,10,2,0,0] call BIS_Fnc_findSafePos;
	} else {
		private _tam = 10;
		private _roads = [];
		while {count _roads == 0} do {
			_roads = _posbase nearRoads _tam;
			_tam = _tam + 10;
		};
		private _road = _roads select 0;
		_posbase = position _road;
	};
};

private _vehicle = [_posbase, 0,_type, side_red] call bis_fnc_spawnvehicle;
private _veh = _vehicle select 0;
[_veh, "AAF"] call AS_fnc_initVehicle;
[_veh,"Patrol"] spawn inmuneConvoy;
private _vehCrew = _vehicle select 1;
{_x call AS_fnc_initUnitAAF} forEach _vehCrew;
private _grupoVeh = _vehicle select 2;
_soldados append _vehCrew;
_grupos pushBack _grupoVeh;
_vehiculos pushBack _veh;


if (_type isKindOf "Car") then {
	sleep 1;
	private _tipoGrupo = [infGarrisonSmall, "AAF"] call fnc_pickGroup;
	private _grupo = [_posbase, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
	{
		_x assignAsCargo _veh;
		_x moveInCargo _veh;
		_soldados pushBack _x;
		[_x] join _grupoveh;
		_x call AS_fnc_initUnitAAF;
	} forEach units _grupo;
	deleteGroup _grupo;
	[_veh] spawn smokeCover;
};

private _continue_condition = {
	(canMove _veh) and {alive _veh} and {count _arraydestinos > 0} and {{alive _x} count _soldados != 0} and
	{{fleeing _x} count _soldados != {alive _x} count _soldados}
};

while _continue_condition do {
	private _destino = selectRandom _arraydestinos;
	private _posdestino = _destino call AS_fnc_location_position;
	private _Vwp0 = _grupoVeh addWaypoint [_posdestino, 0];
	_Vwp0 setWaypointType "MOVE";
	_Vwp0 setWaypointBehaviour "SAFE";
	_Vwp0 setWaypointSpeed "LIMITED";
	_veh setFuel 1;
	while {(_veh distance _posdestino > _distancia) and _continue_condition} do {
		sleep 20;
		{
			if (_x select 2 == side_blue) then {
				private _arevelar = _x select 4;
				private _nivel = (driver _veh) knowsAbout _arevelar;
				if (_nivel > 1.4) then {
					{
						if (leader _x distance _veh < AS_P("spawnDistance")) then {_x reveal [_arevelar,_nivel]};
					} forEach allGroups;
				};
			};
		} forEach (driver _veh nearTargets AS_P("spawnDistance"));
	};

	if _isFlying then {
		_arrayDestinos = "AAF" call AS_fnc_location_S;
	} else {
		if (_type == vehBoat) then {
			_arraydestinos = ([["searport"], "AAF"] call AS_fnc_location_TS) select {(_x call AS_fnc_location_position) distance (position _veh) < 2500};
		} else {
			_arraydestinos = call _groundDestinations;
		};
	};
};

[_grupos, _vehiculos, []] call AS_fnc_cleanResources;
AAFpatrols = AAFpatrols - 1;
publicVariable "AAFpatrols";
