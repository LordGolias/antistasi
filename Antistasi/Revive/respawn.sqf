#include "../macros.hpp"
params ["_unit"];

if (!local _unit) exitWith {};
if (_unit getVariable "respawning") exitWith {};
if (!( _unit call AS_fnc_isUnconscious)) exitWith {};
if (_unit != _unit getVariable ["owner",_unit]) exitWith {};
if (!isPlayer _unit) exitWith {};
_unit setVariable ["respawning",true];

if (!(isMultiplayer) and hayACEMedical) then {
	[player, player] call ace_medical_fnc_treatmentAdvanced_fullHeal;
};

//_unit enableSimulation true;
["Respawning",0,0,3,0,0,4] spawn bis_fnc_dynamicText;
titleText ["", "BLACK IN", 0];

if (isMultiplayer) exitWith {
	if (!isNil "deadCam") then {
		if (!isNull deadCam) then {
			deadCam camSetPos position player;
			deadCam camCommit 1;
			sleep 1;
			deadCam cameraEffect ["terminate", "BACK"];
			camDestroy deadCam;
		};
	};
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", respawnMenu];
	_unit setCaptive false;
	_unit setVariable ["inconsciente",false,true];
	_unit setVariable ["respawning",false];
	_unit setDamage 1;
};
private ["_posicion","_tam","_roads","_road","_pos"];
_posicion = getMarkerPos "FIA_HQ";
if (_unit call AS_fnc_isUnconscious) then {_unit setVariable ["inconsciente",false,true]};
_unit setVariable ["ayudado",nil];
_unit setVariable ["ayudando",nil];
_unit setDamage 0;
_unit setVariable ["compromised",0];
[0,-1,getPos _unit] remoteExec ["citySupportChange",2];

_hr = round (AS_P("hr") * 0.1);
_resourcesFIA = round (AS_P("resourcesFIA") * 0.05);

[- _hr, - _resourcesFIA] remoteExec ["resourcesFIA",2];

{
//_x hideObject true;
if (_x != vehicle _x) then
	{
	if (driver vehicle _x == _x) then
		{
		sleep 3;
		_tam = 10;
		while {true} do
			{
			_roads = _posicion nearRoads _tam;
			if (count _roads < 1) then {_tam = _tam + 10};
			if (count _roads > 0) exitWith {};
			};
		_road = _roads select 0;
		_pos = position _road findEmptyPosition [1,50,typeOf (vehicle _unit)];
		vehicle _x setPos _pos;
		};
	}
else
	{
	if ((!(_x call AS_fnc_isUnconscious)) and (alive _x)) then
		{
		_x setPosATL _posicion;
		_x setVariable ["rearming",false];
		_x doWatch objNull;
		_x doFollow leader _x;
		}
	else
		{
		_x setDamage 1;
		};
	};
//_x hideObject false;
} forEach (units group _unit) + (units MIASquadUnits);

[_unit] call AS_fnc_emptyUnit;

_unit setCaptive false;
_unit setVariable ["respawning",false];