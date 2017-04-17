#include "macros.hpp"
if (!isServer) exitWith{};

private ["_tiempo","_marcadores","_marcador","_posicionMRK"];

_tiempo = time;

while {true} do {
	// maintain a rate of checks of "AS_spawnLoopTime" seconds.
	if (time - _tiempo >= AS_spawnLoopTime) then {sleep AS_spawnLoopTime/5} else {sleep AS_spawnLoopTime - (time - _tiempo)};
	_tiempo = time;
	_puestos = puestos - puestosAA;
	_colinas = colinas - colinasAA;

	waitUntil {!isNil "AS_commander"};

	_amigos = [];
	_enemigos = [];
	{
	if (_x getVariable ["BLUFORSpawn",false]) then
		{
		_amigos pushBack _x;
		if (isPlayer _x) then
			{
			if (!isNull (getConnectedUAV _x)) then
				{
				_amigos pushBack (getConnectedUAV _x);
				};
			};
		}
	else
		{
		if (_x getVariable ["OPFORSpawn",false]) then
			{
			_enemigos pushBack _x;
			};
		}
	} forEach allUnits;

	{ // forEach marcadores
	_marcador = _x;

	_posicionMRK = getMarkerPos (_marcador);

	_isSpawned = spawner getVariable _marcador;
	if (_marcador in mrkAAF) then {
		_spawnCondition = ({(_x distance _posicionMRK < AS_P("spawnDistance"))} count _amigos > 0) or (_marcador in forcedSpawn);
		if (!_isSpawned) then {
			if (_spawnCondition) then {
				spawner setVariable [_marcador,true,true];
				call {
					if (_marcador in _colinas) exitWith {[_marcador] remoteExec ["createWatchpost",HCGarrisons]};
					if (_marcador in colinasAA) exitWith {[_marcador] remoteExec ["createAAsite",HCGarrisons]};
					if (_marcador in ciudades) exitWith {[_marcador] remoteExec ["createCIV",HCciviles]; [_marcador] remoteExec ["createCity",HCGarrisons]};
					if (_marcador in power) exitWith {[_marcador] remoteExec ["createPower",HCGarrisons]};
					if (_marcador in bases) exitWith {[_marcador] remoteExec ["createBase",HCGarrisons]};
					if (_marcador in controles) exitWith {[_marcador] remoteExec ["createRoadblock",HCGarrisons]};
					if (_marcador in aeropuertos) exitWith {[_marcador] remoteExec ["createAirbase",HCGarrisons]};
					if ((_marcador in recursos) or (_marcador in fabricas)) exitWith {[_marcador] remoteExec ["createResources",HCGarrisons]};
					if ((_marcador in _puestos) or (_marcador in puertos)) exitWith {[_marcador] remoteExec ["createOutpost",HCGarrisons]};
					if (_marcador in puestosAA) exitWith {[_marcador] remoteExec ["createOutpostAA",HCGarrisons]};
				};
			};
		} else {
			if (!_spawnCondition) then {
				spawner setVariable [_marcador,false,true];
			};
		};
	} else { // not mkrAAF
		// not clear what this is doing. owner is about who controls it, not something else.
		_playerIsClose = (_marcador in forcedSpawn) or
						 ({((_x getVariable ["owner", objNull]) == _x) and
						   (_x distance _posicionMRK < AS_P("spawnDistance"))} count _amigos > 0);
		// enemies are close.
		_spawnCondition = (_playerIsClose or
						   ({_x distance _posicionMRK < AS_P("spawnDistance")} count _enemigos > 0));
		if (!_isSpawned) then {
			if (_spawnCondition) then {
				spawner setVariable [_marcador,true,true];
				if (_marcador in ciudades) then {
					if (_playerIsClose) then {
						[_marcador] remoteExec ["createCIV",HCciviles];
					};
					[_marcador] remoteExec ["createCity",HCGarrisons];
				} else {
					call {
						if (_marcador in (recursos + fabricas + power + puestos + ["FIA_HQ"])) exitWith {[_marcador] remoteExec ["AS_fnc_createFIAgeneric",HCGarrisons]};
						if (_marcador in aeropuertos) exitWith {[_marcador] remoteExec ["createNATOaerop",HCGarrisons]};
						if (_marcador in bases) exitWith {[_marcador] remoteExec ["createNATObases",HCGarrisons]};
						if (_marcador in puestosFIA) exitWith {[_marcador] remoteExec ["AS_fnc_createFIAroadblock",HCGarrisons]};
						if (_marcador in campsFIA) exitWith {[_marcador] remoteExec ["AS_fnc_createFIACamp",HCGarrisons]};
						if (_marcador in puestosNATO) exitWith {[_marcador] remoteExec ["createNATOpuesto",HCGarrisons]};
					};
				};
			};
		} else {
			if (!_spawnCondition) then {
				spawner setVariable [_marcador,false,true];
			};
		};
	};
	} forEach marcadores;
};
