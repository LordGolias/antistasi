#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};
params ["_marcador"];

private ["_unit","_AAVeh","_crate","_vehiculos","_grupos","_soldados","_stcs"];

private _grupo = createGroup side_green;
private _grupoCSAT = createGroup side_red;
private _gns = [];
private _stcs = [];
private _vehiculos = [];
private _grupos = [];
private _soldados = [];

private _posicion = getMarkerPos (_marcador);

([_marcador] call fnc_selectCMPData) params ["_posCmp", "_cmp"];
private _objs = [_posCmp, 0, _cmp] call BIS_fnc_ObjectsMapper;

private _truck = objNull;
private _crate = objNull;
private _AAVeh = objNull;
{
	call {
		if (typeOf _x == opSPAA) exitWith {_AAVeh = _x; _vehiculos pushBack _x;};
		if (typeOf _x == opTruck) exitWith {[_x, "CSAT"] call AS_fnc_initVehicle; _truck = _x;};
		if (typeOf _x in [statMG, statAT, statAA, statAA2, statMGlow, statMGtower]) exitWith {_stcs pushBack _x;};
		if (typeOf _x == statMortar) exitWith {_stcs pushBack _x; [_x] execVM "scripts\UPSMON\MON_artillery_add.sqf";};
		if (typeOf _x == opCrate) exitWith {_crate = _x; _vehiculos pushBack _x;};
		if (typeOf _x == opFlag) exitWith {_vehiculos pushBack _x;};
	};
} forEach _objs;
// todo: because of the below, this truck will not be despawned.
// todo: make the truck independent of this code if someone enters it.
_objs = _objs - [_truck]; // remove truck so it is not despawned

// init the AA
if !(isNull _AAVeh) then {
	_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _AAVeh;
	_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
	_unit moveInCommander _AAVeh;
	_AAVeh lock 2;
};

{
	_vehiculos pushBack _x;
	private _unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _x;
	_gns pushBack _unit;
	if (str typeof _x find statAA > -1) then {
		_unit = ([_posicion, 0, opI_CREW, _grupoCSAT] call bis_fnc_spawnvehicle) select 0;
		_unit moveInCommander _x;
		_gns pushBack _unit;
	};
} forEach _stcs;

private _mrkfin = createMarkerLocal [format ["specops%1", random 100],_posCmp];
_mrkfin setMarkerShapeLocal "RECTANGLE";
_mrkfin setMarkerSizeLocal [500,500];
_mrkfin setMarkerTypeLocal "hd_warning";
_mrkfin setMarkerColorLocal "ColorRed";
_mrkfin setMarkerBrushLocal "DiagGrid";

private _grupoUAV = objNull;
if (!isNil opUAVsmall) then {
	private _uav = createVehicle [opUAVsmall, _posCmp, [], 0, "FLY"];
	[_uav,"CSAT"] call AS_fnc_initVehicle;
	createVehicleCrew _uav;
	_grupoUAV = group (crew _uav select 1);
	[leader _grupoUAV, _mrkfin, "SAFE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	[_uav,"CSAT"] call AS_fnc_initVehicle;
	{[_x] spawn CSATinit; _soldados pushBack _x} forEach units _grupoUAV;
	_grupos pushBack _grupoUAV;
};

{[_x,"CSAT"] call AS_fnc_initVehicle} forEach _vehiculos;

{[_x] spawn CSATinit; _soldados pushBack _x} forEach units _grup_grupoCSAToUAV;
_grupos pushBack _grupoCSAT;
[leader _grupoCSAT, _mrkfin, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";

// AAF teams
{
	_grupo = [_posicion, side_green, _x] call BIS_Fnc_spawnGroup;
	_grupos pushBack _grupo;
	{[_x, false] call AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;
	[leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH2"] execVM "scripts\UPSMON.sqf";
	sleep 1;
} forEach [
	[infTeamATAA, side_green] call fnc_pickGroup,
	[infAA, side_green] call fnc_pickGroup,
	[infTeam, side_green] call fnc_pickGroup
];

//////////////////////////////////////////////////////////////////
////////////////////////// END SPAWNING //////////////////////////
//////////////////////////////////////////////////////////////////

// 2/3 killed or fleeing and all gunners dead
private _maxSol = count _soldados;

private _fnc_isCleaned = {
	({!alive _x or fleeing _x} count _soldados > (2*_maxSol / 3)) and
	({alive _x} count _gns == 0)
};
// and AA destroyed
private _fnc_isAAdestroyed = {true};
if (!isNull _AAVeh) then {
	_fnc_AAdestroyed = {(not alive _AAVeh)};
};

waitUntil {sleep 1;
	!(spawner getVariable _marcador) or
	(call _fnc_isAADestroyed) and (call _fnc_isCleaned)};

if ((call _fnc_isAADestroyed) and (call _fnc_isCleaned)) then {
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

waitUntil {sleep 1; !(spawner getVariable _marcador)};

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteGroup _x} forEach _grupos;
{deleteVehicle _x} forEach units _grupoUAV;
deleteVehicle _uav;
deleteGroup _grupoUAV;
deleteMarker _mrkfin;
{if (!([AS_P("spawnDistance")-100,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x}} forEach _vehiculos;

{deleteVehicle _x} forEach _objs;
