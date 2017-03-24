if (!isServer and hasInterface) exitWith{};

_marcador = _this select 0;

_vehiculos = [];
_grupos = [];
_soldados = [];

_posicion = getMarkerPos (_marcador);
_pos = [];

_size = [_marcador] call sizeMarker;


_buildings = nearestObjects [_posicion, listMilBld, _size*1.5];

_grupo = createGroup side_green;
_grupos = _grupos + [_grupo];

for "_i" from 0 to (count _buildings) - 1 do {
	_building = _buildings select _i;
	_tipoB = typeOf _building;
	if 	((_tipoB == "Land_Cargo_HQ_V1_F") or (_tipoB == "Land_Cargo_HQ_V2_F") or (_tipoB == "Land_Cargo_HQ_V3_F")) then {
		_veh = createVehicle [statAA, (_building buildingPos 8), [],0, "CAN_COLLIDE"];
		_veh setPosATL [(getPos _building select 0),(getPos _building select 1),(getPosATL _veh select 2)];
		_veh setDir (getDir _building);
		_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		sleep 1;
		_vehiculos = _vehiculos + [_veh];
	}
	else {
		if 	((_tipoB == "Land_Cargo_Patrol_V1_F") or (_tipoB == "Land_Cargo_Patrol_V2_F") or (_tipoB == "Land_Cargo_Patrol_V3_F")) then {
			_veh = createVehicle [statMGtower, (_building buildingPos 1), [], 0, "CAN_COLLIDE"];
			//_veh = createVehicle [statMG, (_building buildingPos 1), [], 0, "CAN_COLLIDE"];
			_ang = (getDir _building) - 180;
			_pos = [getPosATL _veh, 2.5, _ang] call BIS_Fnc_relPos;
			_veh setPosATL _pos;
			_veh setDir (getDir _building) - 180;
			_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
			_unit moveInGunner _veh;
			_soldados = _soldados + [_unit];
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
			sleep 1;
			_vehiculos = _vehiculos + [_veh];
		}
			else {
				if 	(_tipoB in listbld) then {
					//_veh = createVehicle [statMG, (_building buildingPos 11), [], 0, "CAN_COLLIDE"];
					_veh = createVehicle [statMGtower, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
					_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
					_unit moveInGunner _veh;
					_soldados = _soldados + [_unit];
					[_unit, false] spawn AS_fnc_initUnitOPFOR;
					sleep 1;
					_vehiculos = _vehiculos + [_veh];
					//_veh = createVehicle [statMG, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
					_veh = createVehicle [statMGtower, (_building buildingPos 17), [], 0, "CAN_COLLIDE"];
					_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
					_unit moveInGunner _veh;
					_soldados = _soldados + [_unit];
					[_unit, false] spawn AS_fnc_initUnitOPFOR;
					sleep 1;
					_vehiculos = _vehiculos + [_veh];
				};
			};
		//};
	};
};

_bandera = createVehicle [cFlag, _posicion, [],0, "CAN_COLLIDE"];
_bandera allowDamage false;
[[_bandera,"take"],"flagaction"] call BIS_fnc_MP;
_vehiculos = _vehiculos + [_bandera];
_caja = "I_supplyCrate_F" createVehicle _posicion;
_vehiculos = _vehiculos + [_caja];

{[_x] spawn genVEHinit;} forEach _vehiculos;
_frontera = [_marcador] call isFrontline;

if (_marcador in puertos) then
	{
	_pos = [_posicion,_size,_size*3,10,2,0,0] call BIS_Fnc_findSafePos;
	_vehicle=[_pos, 0,"I_Boat_Armed_01_minigun_F", side_green] call bis_fnc_spawnvehicle;
	_veh = _vehicle select 0;
	[_veh] spawn genVEHinit;
	_vehCrew = _vehicle select 1;
	{[_x, false] spawn AS_fnc_initUnitOPFOR} forEach _vehCrew;
	_grupoVeh = _vehicle select 2;
	_soldados = _soldados + _vehCrew;
	_grupos = _grupos + [_grupoVeh];
	_vehiculos = _vehiculos + [_veh];
	sleep 1;
	}
else
	{
	if (_frontera) then
		{
		_base = [bases,_posicion] call BIS_fnc_nearestPosition;
		if ((_base in mrkFIA) or ((getMarkerPos _base) distance _posicion > 1000)) then
			{
			_pos = [_posicion] call mortarPos;
			_veh = statMortar createVehicle _pos;
			[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
			_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
			[_veh] spawn genVEHinit;
			_unit moveInGunner _veh;
			_soldados = _soldados + [_unit];
			_vehiculos = _vehiculos + [_veh];
			sleep 1;
			};
		_roads = _posicion nearRoads _size;
		if (count _roads != 0) then
			{
			_dist = 0;
			_road = objNull;
			{if ((position _x) distance _posicion > _dist) then {_road = _x;_dist = position _x distance _posicion}} forEach _roads;
			_roadscon = roadsConnectedto _road;
			_roadcon = objNull;
			{if ((position _x) distance _posicion > _dist) then {_roadcon = _x}} forEach _roadscon;
			_dirveh = [_roadcon, _road] call BIS_fnc_DirTo;
			_pos = [getPos _road, 7, _dirveh + 270] call BIS_Fnc_relPos;
			_bunker = "Land_BagBunker_Small_F" createVehicle _pos;
			_vehiculos = _vehiculos + [_bunker];
			_bunker setDir _dirveh;
			_pos = getPosATL _bunker;
			_veh = statAT createVehicle _posicion;
			_vehiculos = _vehiculos + [_veh];
			_veh setPos _pos;
			_veh setDir _dirVeh + 180;
			_unit = ([_posicion, 0, infGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
			[_veh] spawn genVEHinit;
			_unit moveInGunner _veh;
			};
		};
	};

_pos = _posicion findEmptyPosition [5,_size,"I_Truck_02_covered_F"];//donde pone 5 antes ponía 10
_veh = createVehicle [selectRandom vehTrucks, _pos, [], 0, "NONE"];
_veh setDir random 360;
_vehiculos = _vehiculos + [_veh];
[_veh] spawn genVEHinit;
sleep 1;

_tam = round (_size/50);

if (_tam == 0) then {_tam = 1};

_cuenta = 0;

if (_frontera) then {_tam = _tam * 2};
while {(spawner getVariable _marcador) and (_cuenta < _tam)} do
	{
	if ((diag_fps > minimoFPS) or (_cuenta == 0)) then {
		_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		if (hayRHS) then {_grupo = [_grupo, _posicion] call expandGroup};
		sleep 1;
		_stance = "RANDOM";
		if (_cuenta == 0) then {_stance = "RANDOMUP"};
		[leader _grupo, _marcador, "SAFE","SPAWNED",_stance,"NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_grupos = _grupos + [_grupo];
		if (_cuenta == 0) then {
			{[_x, false] spawn AS_fnc_initUnitOPFOR; _soldados = _soldados + [_x]; _x setUnitPos "MIDDLE";} forEach units _grupo;
		}
		else {
			{[_x, false] spawn AS_fnc_initUnitOPFOR; _soldados = _soldados + [_x]} forEach units _grupo;
		};
	};
	_cuenta = _cuenta + 1;
	};

if (_marcador in puertos) then
	{
	_caja addItemCargo ["V_RebreatherIA",round random 5];
	_caja addItemCargo ["G_I_Diving",round random 5];
	};

private _journalist = [_marcador, _grupos] call AS_fnc_createJournalist;

waitUntil {sleep 1; (not (spawner getVariable _marcador)) or (({(not(vehicle _x isKindOf "Air"))} count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)) > 3*({(alive _x) and (!(captive _x)) and (_x distance _posicion < _size)} count _soldados))};
if ((spawner getVariable _marcador) and (not(_marcador in mrkFIA))) then
	{
	//[_bandera] spawn mrkWIN;
	[_bandera] remoteExec ["mrkWIN",2];
	};

waitUntil {sleep 1; (not (spawner getVariable _marcador))};

{if ((!alive _x) and (not(_x in destroyedBuildings))) then {destroyedBuildings = destroyedBuildings + [position _x]; publicVariableServer "destroyedBuildings"}} forEach _buildings;
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
if (!isNull _journalist) then {deleteVehicle _journalist};
{deleteGroup _x} forEach _grupos;
{
if (not(_x in staticsToSave)) then
	{
	if (!([distanciaSPWN-_size,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
	};
} forEach _vehiculos;