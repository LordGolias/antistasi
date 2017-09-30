#include "macros.hpp"
params ["_unit"];

if (!local _unit) exitWith {};
if (_unit getVariable "respawning") exitWith {};
if (!( _unit call AS_medical_fnc_isUnconscious)) exitWith {};
if (_unit != _unit getVariable ["owner",_unit]) exitWith {};
if (!isPlayer _unit) exitWith {};
_unit setVariable ["respawning",true];

//_unit enableSimulation true;
["Respawning",0,0,3,0,0,4] spawn bis_fnc_dynamicText;
titleText ["", "BLACK IN", 0];

if isMultiplayer exitWith {
	_unit setCaptive false;
	[_unit, false] call AS_medical_fnc_setUnconscious;
	_unit setVariable ["respawning",false];
	_unit setDamage 1;
};

// single player:
[_unit, false] call AS_medical_fnc_setUnconscious;
private _medic = _unit call AS_medical_fnc_getAssignedMedic;
if isNull _medic then {
	[_unit, _medic] call AS_medical_fnc_clearAssignedMedic;
};
if hayACEMedical then {
	[_unit, _unit] call ace_medical_fnc_treatmentAdvanced_fullHeal;
} else {
	_unit setDamage 0;
};
_unit setVariable ["compromised",0];
[-1, 0] remoteExec ["AS_fnc_changeFIAmoney",2];

_unit setPos ((getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle _unit)]);

[_unit] call AS_fnc_emptyUnit;

_unit setCaptive false;
_unit setVariable ["respawning",false];
