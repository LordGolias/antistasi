#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};
params ["_marcador"];

private ["_unit","_AAVeh","_crate","_vehiculos","_grupos","_soldados","_stcs"];

private _grupo = createGroup side_green;
private _grupoCSAT = createGroup side_red;
private _av = false;
private _gns = [];
private _stcs = [];
private _vehiculos = [];
private _grupos = [];
private _soldados = [];
private _truck = [];

_posicion = getMarkerPos (_marcador);

_cmpInfo = [_marcador] call fnc_selectCMPData;
_posCmp = _cmpInfo select 0;
_cmp = _cmpInfo select 1;

_objs = [_posCmp, 0, _cmp] call BIS_fnc_ObjectsMapper;

{
	call {
		if (typeOf _x == opSPAA) exitWith {_AAVeh = _x; _vehiculos = _vehiculos + [_x]; _av = true;};
		if (typeOf _x == opTruck) exitWith {[_x, "CSAT"] call AS_fnc_initVehicle; _truck = [_x]};
		if (typeOf _x in [statMG, statAT, statAA, statAA2, statMGlow, statMGtower]) exitWith {_stcs pushBack _x;};
		if (typeOf _x == statMortar) exitWith {_stcs pushBack _x; [_x] execVM "scripts\UPSMON\MON_artillery_add.sqf";};
		if (typeOf _x == opCrate) exitWith {_crate = _x; _vehiculos = _vehiculos + [_x];};
		if (typeOf _x == opFlag) exitWith {_vehiculos = _vehiculos + [_x];};
	};
} forEach _objs;
_objs = _objs - _truck;

if (_av) then {
	_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _AAVeh;
	_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
	_unit moveInCommander _AAVeh;
	_AAVeh lock 2;
};

{
	_vehiculos = _vehiculos + [_x];
	_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _x;
	_gns pushBack _unit;
	if (str typeof _x find statAA > -1) then {
		_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInCommander _x;
		_gns pushBack _unit;
	};
} forEach _stcs;

_mrkfin = createMarkerLocal [format ["specops%1", random 100],_posCmp];
_mrkfin setMarkerShapeLocal "RECTANGLE";
_mrkfin setMarkerSizeLocal [500,500];
_mrkfin setMarkerTypeLocal "hd_warning";
_mrkfin setMarkerColorLocal "ColorRed";
_mrkfin setMarkerBrushLocal "DiagGrid";

[leader _grupoCSAT, _mrkfin, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

_uav = createVehicle [opUAVsmall, _posCmp, [], 0, "FLY"];
createVehicleCrew _uav;

_grupoUAV = group (crew _uav select 1);
[leader _grupoUAV, _mrkfin, "SAFE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

{[_x,"CSAT"] call AS_fnc_initVehicle} forEach _vehiculos;

{[_x] spawn CSATinit; _soldados = _soldados + [_x]} forEach units _grupoCSAT;
_grupos = _grupos + [_grupoCSAT];

_tipoGrupo = [infTeamATAA, side_green] call fnc_pickGroup;
_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] execVM "scripts\UPSMON.sqf";
_grupos = _grupos + [_grupo];
{[_x, false] spawn AS_fnc_initUnitAAF; _soldados = _soldados + [_x]} forEach units _grupo;

_tipoGrupo = [infAA, side_green] call fnc_pickGroup;
_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] execVM "scripts\UPSMON.sqf";
_grupos = _grupos + [_grupo];
{[_x, false] spawn AS_fnc_initUnitAAF; _soldados = _soldados + [_x]} forEach units _grupo;

_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
_grupo = [_posicion, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] execVM "scripts\UPSMON.sqf";
_grupos = _grupos + [_grupo];
{[_x, false] spawn AS_fnc_initUnitAAF; _soldados = _soldados + [_x]} forEach units _grupo;

_maxSol = count _soldados;


if (_av) then {
	waitUntil {sleep 1; (not (spawner getVariable _marcador)) or ((({alive _x} count _soldados < (_maxSol / 3)) || ({fleeing _x} count _soldados == {alive _x} count _soldados)) && (not alive _AAVeh) && ({alive _x} count _gns == 0))};


	if ((({alive _x} count _soldados < (_maxSol / 3)) or ({fleeing _x} count _soldados == {alive _x} count _soldados)) && (not alive _AAVeh) && ({alive _x} count _gns == 0)) then {
		[-5,0,_posicion] remoteExec ["citySupportChange",2];
		[0,-20] remoteExec ["prestige",2];
		[["TaskSucceeded", ["", "Outpost Cleansed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		_mrk = format ["Dum%1",_marcador];
		deleteMarker _mrk;
		mrkAAF = mrkAAF - [_marcador];
		mrkFIA = mrkFIA + [_marcador];
		publicVariable "mrkAAF";
		publicVariable "mrkFIA";
		[_posicion] remoteExec ["patrolCA",HCattack];
		if (hayBE) then {["cl_loc"] remoteExec ["fnc_BE_XP", 2]};
	};
}
else {
	waitUntil {sleep 1; (not (spawner getVariable _marcador)) or ((({alive _x} count _soldados < (_maxSol / 3)) || ({fleeing _x} count _soldados == {alive _x} count _soldados)) && ({alive _x} count _gns == 0))};

	if (({alive _x} count _soldados < (_maxSol / 3)) or ({fleeing _x} count _soldados == {alive _x} count _soldados)) then {
		[-5,0,_posicion] remoteExec ["citySupportChange",2];
		[0,-10] remoteExec ["prestige",2];
		[["TaskSucceeded", ["", "Outpost Cleansed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		_mrk = format ["Dum%1",_marcador];
		deleteMarker _mrk;
		mrkAAF = mrkAAF - [_marcador];
		mrkFIA = mrkFIA + [_marcador];
		publicVariable "mrkAAF";
		publicVariable "mrkFIA";
		[_posicion] remoteExec ["patrolCA",HCattack];
		if (hayBE) then {["cl_loc"] remoteExec ["fnc_BE_XP", 2]};
	};
};

waitUntil {sleep 1; not (spawner getVariable _marcador)};

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteGroup _x} forEach _grupos;
{deleteVehicle _x} forEach units _grupoUAV;
deleteVehicle _uav;
deleteGroup _grupoUAV;
{if (!([AS_P("spawnDistance")-100,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x}} forEach _vehiculos;

{deleteVehicle _x} forEach _objs;
