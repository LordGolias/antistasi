#include "macros.hpp"

private ["_objetivos","_base","_objetivo","_cuenta","_aeropuerto","_datos","_prestigeOPFOR","_scoreLand","_scoreAir","_analizado","_garrison","_size","_estaticas","_salir"];

_objetivos = [];
_cuentaFacil = 0;

private _FIAbases = [["base"], "FIA"] call AS_fnc_location_TS;

_hayCSAT = true;

cuentaCA = cuentaCA + 600;

private _validTypes = ["base", "airfield", "outpost", "city", "roadblock"];

// only CSAT can attack cities
if ((random 100 > AS_P("prestigeCSAT")) or
	(count _FIAbases == 0) or
	(server getVariable "blockCSAT")) then {
	_validTypes = _validTypes - ["city"];
	_hayCSAT = false;
};

private _marcadores = [_validTypes, "FIA"] call AS_fnc_location_TS;

if (count _marcadores == 0) exitWith {};

_scoreLand = ["apcs"] call AS_fnc_AAFarsenal_count + 5*(["tanks"] call AS_fnc_AAFarsenal_count);
_scoreAir = ["armedHelis"] call AS_fnc_AAFarsenal_count + 5*(["planes"] call AS_fnc_AAFarsenal_count);
if (_hayCSAT) then {_scoreLand = _scoreLand + 15; _scoreAir = _scoreAir + 15};
{  // forEach _marcadores
	_objetivo = _x;
	private _type = _x call AS_fnc_location_type;
	private _position = _x call AS_fnc_location_position;
	private _garrison = _x call AS_fnc_location_garrison;
	_esFacil = false;

if (_type == "_city") then {
	private _FIAsupport = [_objetivo, "FIAsupport"] call AS_fnc_location_get;
	private _AAFsupport = [_objetivo, "AAFsupport"] call AS_fnc_location_get;
	if ((_AAFsupport == 0) and (_FIAsupport > 0)) then {_objetivos pushBack _objetivo};
} else {
	_base = [_position,true] call findBasesForCA;
	_aeropuerto = [_position,true] call findAirportsForCA;
	if ((_base != "") or (_aeropuerto != "")) then {
		private _scoreNeededLand = 0;
		private _scoreNeededAir = 0;
		if (_base != "") then {
			private _wps = ["watchpost", "FIA"] call AS_fnc_location_TS;
			_wps = _wps select {(_x call AS_fnc_location_position) distance _posObjetivo < AS_P("spawnDistance")};
			_scoreNeededLand = _scoreNeededLand + 2 * (count _wps);
		};
		// compute the score needed to attack this objective
		{
			_analizado = _x;
			private _analizadoPos = _x call AS_fnc_location_position;
			if (_analizadoPos distance _position < AS_P("spawnDistance")) then {
				private _analizadoSize = _x call AS_fnc_location_size;
				private _analizadoType = _x call AS_fnc_location_type;
				private _analizadoGarrison = _x call AS_fnc_location_garrison;
				if (_base != "") then {
					_scoreNeededLand = _scoreNeededLand + (2*({(_x == "Ammo Bearer")} count _analizadoGarrison)) + (floor((count _analizadoGarrison)/8));
					if (_analizadoType in ["base", "airfield"]) then {
						_scoreNeededLand = _scoreNeededLand + 3
					};
				};
				if (_aeropuerto != "") then {
					_scoreNeededAir = _scoreNeededAir + (floor((count _garrison)/8));
					if (_analizadoType in ["base", "airfield"]) then {
						_scoreNeededAir = _scoreNeededAir + 3
					};
				};
				_estaticas = staticsToSave select {_x distance _analizadoPos < _analizadoSize};
				if (count _estaticas > 0) then {
					if (_base != "") then {_scoreNeededLand = _scoreNeededLand + ({typeOf _x in allStatMortars} count _estaticas) + (2*({typeOf _x in allStatATs} count _estaticas))};
					if (_aeropuerto != "") then {_scoreNeededAir = _scoreNeededAir + ({typeOf _x in allStatMGs} count _estaticas) + (5*({typeOf _x in allStatAAs} count _estaticas))}
				};
			};
		} forEach _marcadores;
		// decide to attack or not depending on the scores
		if (_scoreNeededLand > _scoreLand) then {
			_base = "";
		} else {  // if it is easy,
			if ((_base != "") and (_scoreNeededLand < 4) and
				(count _garrison < 4) and (_cuentaFacil < 4) and
				!(_type in ["base", "airfield"])) then {
				_esFacil = true;
				if !(_objetivo in smallCAmrk) then {
					_cuentaFacil = _cuentaFacil + 2;
					[_objetivo,_base] remoteExec ["patrolCA",HCattack];
					sleep 15;
				};
			};
		};
		if (_scoreNeededAir > _scoreAir) then {
			_aeropuerto = "";
		}
		else {
			if ((_aeropuerto != "") and (_base == "") and
			    (!_esFacil) and (_scoreNeededAir < 4) and
				(count _garrison < 4) and (_cuentaFacil < 4) and
				!(_type in ["base", "airfield"])) then {
				_esFacil = true;
				if !(_objetivo in smallCAmrk) then {
					_cuentaFacil = _cuentaFacil + 1;
					[_objetivo,_aeropuerto] remoteExec ["patrolCA",HCattack];
					sleep 15;
				};
			};
		};
		if (((_base != "") or (_aeropuerto != "")) and (!_esFacil)) then {
			_cuenta = 1;
			if (_type in ["resource"]) then {_cuenta = 3};
			if (_type in ["powerplant", "factory"]) then {_cuenta = 4};
			if (_type in ["base", "airfield"]) then {_cuenta = 5};
			if (_base != "") then {
				if (_aeropuerto != "") then {_cuenta = _cuenta*2};
				if (_objetivo == [_marcadores, _base] call bis_fnc_nearestPosition) then {_cuenta = _cuenta*2};
			};
			// make it more likely
			for "_i" from 1 to _cuenta do {
				_objetivos pushBack _objetivo;
			};
		};
	};
};
} forEach _marcadores;

if ((count _objetivos > 0) and (_cuentaFacil < 3)) then {
	_objetivo = selectRandom _objetivos;
	if (_objetivo call AS_fnc_location_type != "city") then {
		[_objetivo] remoteExec ["combinedCA",HCattack]
	} else {
		[_objetivo] remoteExec ["CSATpunish",HCattack]
	};
	cuentaCA = cuentaCA - 600;
};

if (not("CONVOY" in misiones)) then {
	if (count _objetivos == 0) then {
		{
			private _base = [_x call AS_fnc_location_position] call findBasesForConvoy;
			if (_base != "") then {
				private _FIAsupport = [_x, "FIAsupport"] call AS_fnc_location_get;
				private _AAFsupport = [_x, "AAFsupport"] call AS_fnc_location_get;
				if (_FIAsupport + _AAFsupport < 95) then {
					_objetivos pushBack [_x,_base];
				};
			};
		} forEach ([["city"], "FIA"] call AS_fnc_location_TS);
		if (count _objetivos > 0) then {
			_objetivo = selectRandom _objetivos;
			[(_objetivo select 0),(_objetivo select 1),"civ"] remoteExec ["CONVOY",HCattack];
		};
	};
};
