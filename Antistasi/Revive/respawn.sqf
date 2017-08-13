#include "../macros.hpp"
params ["_unit"];

if (!local _unit) exitWith {};
if (_unit getVariable "respawning") exitWith {};
if (!( _unit call AS_fnc_isUnconscious)) exitWith {};
if (_unit != _unit getVariable ["owner",_unit]) exitWith {};
if (!isPlayer _unit) exitWith {};
_unit setVariable ["respawning",true];

//_unit enableSimulation true;
["Respawning",0,0,3,0,0,4] spawn bis_fnc_dynamicText;
titleText ["", "BLACK IN", 0];

if isMultiplayer exitWith {
	if (!isNil "deadCam" and {!isNull deadCam}) then {
		deadCam camSetPos position player;
		deadCam camCommit 1;
		sleep 1;
		deadCam cameraEffect ["terminate", "BACK"];
		camDestroy deadCam;
	};
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", respawnMenu];
	_unit setCaptive false;
	[_unit, false] call AS_fnc_setUnconscious;
	_unit setVariable ["respawning",false];
	_unit setDamage 1;
};

[_unit, false] call AS_fnc_setUnconscious;
_unit setVariable ["ayudado",nil];
_unit setVariable ["ayudando",nil];
if hayACEMedical then {
	[_unit, _unit] call ace_medical_fnc_treatmentAdvanced_fullHeal;
} else {
	_unit setDamage 0;
};
_unit setVariable ["compromised",0];
[-1, 0] remoteExec ["resourcesFIA",2];

private _posicion = getMarkerPos "FIA_HQ";
{
	if (_x != vehicle _x) then {
		if (driver vehicle _x == _x) then {
			sleep 3;
			private _tam = 10;
			private _roads = [];
			while {count _roads == 0} do {
				_roads = _posicion nearRoads _tam;
				_tam = _tam + 10;
			};
			private _road = _roads select 0;
			private _pos = position _road findEmptyPosition [1,50,typeOf (vehicle _unit)];
			vehicle _x setPos _pos;
		};
	} else {
		// conscious and alive are respawned with the player with 50% chances
		if ((!(_x call AS_fnc_isUnconscious)) and (alive _x)) then {
			_x setPosATL _posicion;
			_x setVariable ["rearming",false];
			_x doWatch objNull;
			_x doFollow leader _x;
		} else {
			_x setDamage 1;
		};
	};
} forEach (units group _unit) + (units MIASquadUnits);

[_unit] call AS_fnc_emptyUnit;

_unit setCaptive false;
_unit setVariable ["respawning",false];
