if (!isServer and hasInterface) exitWith{};

private ["_marcador","_vehiculos","_grupos","_soldados","_size","_grupo","_buildings","_listbld","__building","_veh","_unit","_ang","_nVeh","_pos","_cuenta","_tipoB","_prestigio","_soldadosFIA","_gruposFIA","_garrison","_tam","_grupoMort","_grupoEst","_grupoMed"];

_marcador = _this select 0;

_vehiculos = [];
_grupos = [];
_soldados = [];
_soldadosFIA = [];
_gruposFIA = [];

_posicion = getMarkerPos (_marcador);
_pos = [];
_prestigio = (server getVariable "prestigeNATO")/100;

_size = [_marcador] call sizeMarker;

_buildings = nearestObjects [_posicion, listMilBld, _size*1.5];
_estaticas = staticsToSave select {_x distance _posicion < _size};

_grupo = createGroup side_blue;
_grupos = _grupos + [_grupo];

for "_i" from 0 to (count _buildings) - 1 do
	{
	_building = _buildings select _i;
	_tipoB = typeOf _building;
	if 	((_tipoB == "Land_Cargo_HQ_V1_F") or (_tipoB == "Land_Cargo_HQ_V2_F") or (_tipoB == "Land_Cargo_HQ_V3_F")) then
		{
		_veh = createVehicle [selectRandom bluStatAA, (_building buildingPos 8), [],0, "CAN_COLLIDE"];
		_veh setPosATL [(getPos _building select 0),(getPos _building select 1),(getPosATL _veh select 2)];
		_veh setDir (getDir _building);
		_unit = ([_posicion, 0, bluGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		sleep 1;
		_vehiculos = _vehiculos + [_veh];
		};
	if 	((_tipoB == "Land_Cargo_Patrol_V1_F") or (_tipoB == "Land_Cargo_Patrol_V2_F") or (_tipoB == "Land_Cargo_Patrol_V3_F")) then
		{
		_veh = createVehicle [selectRandom bluStatHMG, (_building buildingPos 1), [], 0, "CAN_COLLIDE"];
		_ang = (getDir _building) - 180;
		_pos = [getPosATL _veh, 2.5, _ang] call BIS_Fnc_relPos;
		_veh setPosATL _pos;
		_veh setDir (getDir _building) - 180;
		_unit = ([_posicion, 0, bluGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		sleep 1;
		_vehiculos = _vehiculos + [_veh];
		};
	if 	(_tipoB in listbld) then
		{
		_veh = createVehicle [selectRandom bluStatHMG, (_building buildingPos 11), [], 0, "CAN_COLLIDE"];
		_unit = ([_posicion, 0, bluGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		sleep 1;
		_vehiculos = _vehiculos + [_veh];
		_veh = createVehicle [selectRandom bluStatHMG, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
		_unit = ([_posicion, 0, bluGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		sleep 1;
		_vehiculos = _vehiculos + [_veh];
		};
	};

_veh = createVehicle [bluFlag, _posicion, [],0, "CAN_COLLIDE"];
_veh allowDamage false;
[[_veh,"unit"],"flagaction"] call BIS_fnc_MP;
[[_veh,"vehicle"],"flagaction"] call BIS_fnc_MP;
[[_veh,"garage"],"flagaction"] call BIS_fnc_MP;
_vehiculos = _vehiculos + [_veh];

_nVeh = round ((_size / 30)*_prestigio);
if (_nVeh > 4) then {_nVeh = 4;};
if ( _nVeh > 0 ) then
	{
	_pos = [_posicion, random (_size / 2),random 360] call BIS_fnc_relPos;
	_cuenta = 0;
	while {(spawner getVariable _marcador) and (_cuenta < _nveh)} do
		{
		_pos = [_posicion] call mortarPos;
		_veh = selectRandom bluStatMortar createVehicle _pos;
		[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
		_unit = ([_posicion, 0, bluGunner, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _veh;
		_soldados = _soldados + [_unit];
		sleep 1;
		_vehiculos = _vehiculos + [_veh];
		_cuenta = _cuenta + 1;
		};
	};

{[_x] spawn NATOinit} forEach _soldados;
{[_x] spawn NATOVEHinit} forEach _vehiculos;

_tipoVeh = "";
_nVeh = round ((_size/30)*_prestigio);
if (_nVeh < 1) then {_nVeh = 1};
_pos = _posicion;
_cuenta = 0;
while {(spawner getVariable _marcador) and (_cuenta < _nveh)} do
	{
	if (diag_fps > minimoFPS) then
		{
		_tipoVeh = vehNATO call BIS_fnc_selectRandom;
		if (_size > 40) then {_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos} else {_pos = _pos findEmptyPosition [10,60,_tipoVeh]};
		_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
		_veh setDir random 360;
		_veh lock 3;
		_vehiculos = _vehiculos + [_veh];
		[_veh] spawn NATOVEHinit;
		sleep 1;
		};
	_cuenta = _cuenta + 1;
	};

_tipoGrupo = [bluSquad, side_blue] call fnc_pickGroup;
_grupo = [_posicion, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _marcador, "SAFE", "RANDOMUP","SPAWNED", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
_grupos = _grupos + [_grupo];
{[_x] spawn NATOinit; _soldados = _soldados + [_x]} forEach units _grupo;

_cuenta = 0;
while {(spawner getVariable _marcador) and (_cuenta < _nveh)} do
	{
	if (diag_fps > minimoFPS) then
		{
		while {true} do
			{
			_pos = [_posicion, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
			};
		_tipoGrupo = [bluSquad, side_blue] call fnc_pickGroup;
		_grupo = [_pos,side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		sleep 1;
		if (_cuenta == 0) then
			{
			[leader _grupo, _marcador, "SAFE","SPAWNED","FORTIFY","NOVEH","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
			}
		else
			{
			[leader _grupo, _marcador, "SAFE","SPAWNED", "RANDOM","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
			};
		_grupos = _grupos + [_grupo];
		{[_x] spawn NATOinit; _soldados = _soldados + [_x]} forEach units _grupo;
		};
	_cuenta = _cuenta + 1;
	};

_garrison = garrison getVariable [_marcador,[]];
_tam = count _garrison;
_cuenta = 0;
_grupo = createGroup side_blue;
_gruposFIA = _gruposFIA + [_grupo];

if (("b_g_soldier_unarmed_f" in _garrison) or ({typeOf _x in bluStatMortar} count _estaticas > 0)) then
	{
	_grupoMort = createGroup side_blue;
	};
_grupoEst = grpNull;
if (count _estaticas > 0) then
	{
	_grupoEst = createGroup side_blue;
	};

while {true} do
	{
	_pos = [_posicion, random _size,random 360] call BIS_fnc_relPos;
	if (!surfaceIsWater _pos) exitWith {};
	};

if (_tam > 0) then {
	while {(spawner getVariable _marcador) and (_cuenta < _tam)} do
	{
	_tipo = _garrison select _cuenta;
	if (_tipo == "b_g_soldier_unarmed_f") then
		{
		_unit = _grupoMort createUnit [_tipo, _posicion, [], 0, "NONE"];
		_pos = _posicion findEmptyPosition [1,30,"I_G_Mortar_01_F"];
		_veh = selectRandom bluStatMortar createVehicle _pos;
		_vehiculos = _vehiculos + [_veh];
		[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
		_unit moveInGunner _veh;
		[_veh] spawn VEHinit;
		}
	else
		{
		if ((_tipo == "B_G_Soldier_F") and (count _estaticas > 0)) then
			{
			_estatica = _estaticas select 0;
			if (typeOf _estatica in bluStatMortar) then
				{
				_unit = _grupoMort createUnit [_tipo, _posicion, [], 0, "NONE"];
				_unit moveInGunner _estatica;
				[_estatica] execVM "scripts\UPSMON\MON_artillery_add.sqf";
				}
			else
				{
				_unit = _grupoEst createUnit [_tipo, _posicion, [], 0, "NONE"];
				_unit moveInGunner _estatica;
				};
			_estaticas = _estaticas - [_estatica];
			}
		else
			{
			_unit = _grupo createUnit [_tipo, _posicion, [], 0, "NONE"];
			if (_tipo == "B_G_Soldier_SL_F") then {_grupo selectLeader _unit};
			};
		};
	[_unit,false,_marcador] call AS_fnc_initUnitFIA;
	_soldadosFIA = _soldadosFIA + [_unit];
	_cuenta = _cuenta + 1;
	sleep 0.5;
	if (count units _grupo == 8) then
		{
		_grupo = createGroup side_blue;
		_gruposFIA = _gruposFIA + [_grupo];
		while {true} do
			{
			_pos = [_posicion, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _pos) exitWith {};
			};
		};
	};
};

for "_i" from 0 to (count _gruposFIA) - 1 do
	{
	_grupo = _gruposFIA select _i;
	[leader _grupo, _marcador, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	};

if ("b_g_soldier_unarmed_f" in _garrison) then
	{
	_gruposFIA = _gruposFIA + [_grupoMort];
	};

_periodista = objNull;
if ((random 100 < (((server getVariable "prestigeNATO") + (server getVariable "prestigeCSAT")))) and (spawner getVariable _marcador)) then
	{
	_pos = [];
	_grupo = createGroup civilian;
	while {true} do
		{
		_pos = [_posicion, round (random _size), random 360] call BIS_Fnc_relPos;
		if (!surfaceIsWater _pos) exitWith {};
		};
	_periodista = _grupo createUnit ["C_journalist_F", _pos, [],0, "NONE"];
	[_periodista] spawn CIVinit;
	_grupos pushBack _grupo;
	[_periodista, _marcador, "SAFE", "SPAWNED","NOFOLLOW", "NOVEH2","NOSHARE","DoRelax"] execVM "scripts\UPSMON.sqf";
	};

// experimental

waitUntil {sleep 1; (not (spawner getVariable _marcador)) or (({not(vehicle _x isKindOf "Air")} count ([_size,0,_posicion,"OPFORSpawn"] call distanceUnits)) > 3*(({alive _x} count _soldados) + count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)))};


if (spawner getVariable _marcador) then
	{
	if (_marcador != "FIA_HQ") then {[_marcador] remoteExec ["mrkLOOSE",2]};
	};

// /experimental

waitUntil {sleep 1; not (spawner getVariable _marcador)};

{if ((!alive _x) and (not(_x in destroyedBuildings))) then {destroyedBuildings = destroyedBuildings + [position _x]; publicVariableServer "destroyedBuildings"}} forEach _buildings;

{
	if (_marcador in mrkFIA) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x
	};
} forEach _soldadosFIA;

if (!isNull _periodista) then {deleteVehicle _periodista};
{deleteGroup _x} forEach _gruposFIA;
{if (not(_x in staticsToSave)) then {deleteVehicle _x}} forEach _vehiculos;
{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteGroup _x} forEach _grupos;
deleteGroup _grupoEst;
