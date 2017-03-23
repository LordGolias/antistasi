private ["_soldados","_vehiculos","_grupos","_base","_posbase","_roads","_tipoCoche","_arrayBases","_arrayDestinos","_tam","_road","_veh","_vehCrew","_grupoVeh","_grupo","_grupoP","_distancia"];

_soldados = [];
_vehiculos = [];
_grupos = [];
_base = "";
_roads = [];

_tipos = vehPatrol + ["I_Boat_Armed_01_minigun_F"];

while {true} do
	{
	_tipoCoche = selectRandom _tipos;
	if (_tipoCoche in heli_unarmed) then
		{
		_arrayBases = aeropuertos - mrkFIA;
		}
	else
		{
		if (_tipoCoche == "I_Boat_Armed_01_minigun_F") then
			{
			_arrayBases = puertos - mrkFIA;
			}
		else
			{
			_arrayBases = bases - mrkFIA;
			};
		};
	if (count _arraybases == 0) then
		{
		_tipos = _tipos - [_tipoCoche];
		}
	else
		{
		while {true} do
			{
			_base = [_arraybases,getMarkerPos "respawn_west"] call BIS_fnc_nearestPosition;
			if (not (spawner getVariable _base)) exitWith {};
			if (spawner getVariable _base) then {_arraybases = _arraybases - [_base]};
			if (count _arraybases == 0) exitWith {};
			};
		if (count _arraybases == 0) then {_tipos = _tipos - [_tipoCoche]};
		};
	if (count _tipos == 0) exitWith {};
	if (not (spawner getVariable _base)) exitWith {};
	};

if (count _tipos == 0) exitWith {};

_posbase = getMarkerPos _base;

if (_tipoCoche in heli_unarmed) then
	{
	_arrayDestinos = mrkAAF;
	_distancia = 200;
	}
else
	{
	if (_tipoCoche == "I_Boat_Armed_01_minigun_F") then
		{
		_arraydestinos = seaMarkers select {(getMarkerPos _x) distance _posbase < 2500};
		_distancia = 100;
		}
	else
		{
		_arraydestinos = [mrkAAF] call patrolDestinos;
		_distancia = 50;
		};
	};

if (count _arraydestinos < 1) exitWith {};

AAFpatrols = AAFpatrols + 1; publicVariableServer "AAFpatrols";

if !(_tipoCoche in heli_unarmed) then
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
[_veh] spawn genVEHinit;
[_veh,"Patrol"] spawn inmuneConvoy;
_vehCrew = _vehicle select 1;
{[_x] spawn AS_fnc_initUnitOPFOR} forEach _vehCrew;
_grupoVeh = _vehicle select 2;
_soldados = _soldados + _vehCrew;
_grupos = _grupos + [_grupoVeh];
_vehiculos = _vehiculos + [_veh];


if (_tipoCoche isKindOf "Car") then
	{
	sleep 1;
	_tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
	_grupo = [_posbase, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
	{_x assignAsCargo _veh; _x moveInCargo _veh; _soldados = _soldados + [_x]; [_x] join _grupoveh; [_x] spawn AS_fnc_initUnitOPFOR} forEach units _grupo;
	deleteGroup _grupo;
	[_veh] spawn smokeCover;
	};

while {alive _veh} do
	{
	_destino = _arraydestinos call bis_Fnc_selectRandom;
	if (debug) then {player globalChat format ["Patrulla AAF generada. Origen: %2 Destino %1", _destino, _base]; sleep 3;};
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
				if (leader _grupoP distance _veh < distanciaSPWN) then {_grupoP reveal [_arevelar,_nivel]};
				} forEach allGroups;
				};
			};
		} forEach (driver _veh nearTargets distanciaSPWN);
		if ((_veh distance _posdestino < _distancia) or ({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados) or (!canMove _veh)) exitWith {};
		};

	if (({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados) or (!canMove _veh)) exitWith {};
	if (_tipoCoche in heli_unarmed) then
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
waitUntil {sleep 1;!([distanciaSPWN,1,_unit,"BLUFORSpawn"] call distanceUnits)};deleteVehicle _unit} forEach _soldados;

{_veh = _x;
if !([distanciaSPWN,1,_veh,"BLUFORSpawn"] call distanceUnits) then {deleteVehicle _veh}} forEach _vehiculos;
{deleteGroup _x} forEach _grupos;