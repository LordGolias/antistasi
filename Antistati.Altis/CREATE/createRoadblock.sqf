if (!isServer and hasInterface) exitWith{};

private ["_pos","_roadscon","_veh","_roads","_conquistado","_dirVeh","_marcador","_posicion","_vehiculos","_soldados","_tam","_bunker","_grupoE","_unit","_tipogrupo","_grupo","_tiempolim","_fechalim","_fechalimnum","_base","_perro"];

_marcador = _this select 0;

_posicion = getMarkerPos _marcador;

_vehiculos = [];
_soldados = [];

_tam = 20;
_conquistado = false;

while {true} do
	{
	_roads = _posicion nearRoads _tam;
	if (count _roads > 1) exitWith {};
	_tam = _tam + 5;
	};

_roadscon = roadsConnectedto (_roads select 0);

//if (count _roadscon == 0) then {player setpos position (_roads select 0)};

_dirveh = [_roads select 0, _roadscon select 0] call BIS_fnc_DirTo;
if ((isNull (_roads select 0)) or (isNull (_roadscon select 0))) then {diag_log format ["Antistasi Roadblock error report: %1 position is bad",_marcador]};
_pos = [getPos (_roads select 0), 7, _dirveh + 270] call BIS_Fnc_relPos;
_bunker = "Land_BagBunker_Small_F" createVehicle _pos;
_vehiculos = _vehiculos + [_bunker];
_bunker setDir _dirveh;
_pos = getPosATL _bunker;
_veh = statMG createVehicle _posicion;
_vehiculos = _vehiculos + [_veh];
_veh setPosATL _pos;
_veh setDir _dirVeh;

_grupoE = createGroup side_green;

_unit = ([_posicion, 0, infGunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
_unit moveInGunner _veh;
_soldados = _soldados + [_unit];
sleep 1;
_pos = [getPos (_roads select 0), 7, _dirveh + 90] call BIS_Fnc_relPos;
_bunker = "Land_BagBunker_Small_F" createVehicle _pos;
_vehiculos = _vehiculos + [_bunker];
_bunker setDir _dirveh + 180;
_pos = getPosATL _bunker;
_veh = statMG createVehicle _posicion;
_vehiculos = _vehiculos + [_veh];
_veh setPosATL _pos;
_veh setDir _dirVeh;
sleep 1;
_unit = ([_posicion, 0, infGunner, _grupoE] call bis_fnc_spawnvehicle) select 0;
_unit moveInGunner _veh;
_soldados = _soldados + [_unit];
sleep 1;
_pos = [getPos _bunker, 6, getDir _bunker] call BIS_fnc_relPos;
_veh = createVehicle [cFlag, _pos, [],0, "CAN_COLLIDE"];
_vehiculos = _vehiculos + [_veh];


{[_x] spawn genVEHinit} forEach _vehiculos;

_tipoGrupo = [infAT, side_green] call fnc_pickGroup;
_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
{[_x] join _grupo} forEach units _grupoE;
_soldier = ([_posicion, 0, sol_MED, _grupo] call bis_fnc_spawnvehicle) select 0;
_grupo selectLeader (units _grupo select 1);
deleteGroup _grupoE;
if (random 10 < 2.5) then
	{
	_perro = _grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"];
	[_perro,_grupo] spawn guardDog;
	};
[leader _grupo, _marcador, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
{[_x] spawn genInitBASES; _soldados = _soldados + [_x]} forEach units _grupo;

waitUntil {sleep 1;(not (spawner getVariable _marcador))  or ({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)};

if (({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)) then
	{
	[-5,0,_posicion] remoteExec ["citySupportChange",2];
	[["TaskSucceeded", ["", "Roadblock Cleansed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	[_posicion] remoteExec ["patrolCA",HCattack];
	_conquistado = true;
	mrkAAF = mrkAAF - [_marcador];
	mrkFIA = mrkFIA + [_marcador];
	publicVariable "mrkAAF";
	publicVariable "mrkFIA";
	if (hayBE) then {["cl_loc"] remoteExec ["fnc_BE_XP", 2]};
	};

waitUntil {sleep 1;not (spawner getVariable _marcador)};

{_veh = _x;
if (not(_veh in staticsToSave)) then
	{
	deleteVehicle _veh;
	};
} forEach _vehiculos;
{
if (alive _x) then {deleteVehicle _x}} forEach _soldados;
deleteGroup _grupo;

if (_conquistado) then
	{
	_tiempolim = 120;//120
	_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
	_fechalimnum = dateToNumber _fechalim;
	waitUntil {sleep 60;(dateToNumber date > _fechalimnum)};
	_base = [marcadores,_posicion] call BIS_fnc_nearestPosition;
	if (_base in mrkAAF) then
		{
		mrkAAF = mrkAAF + [_marcador];
		mrkFIA = mrkFIA - [_marcador];
		publicVariable "mrkAAF";
		publicVariable "mrkFIA";
		};
	};

