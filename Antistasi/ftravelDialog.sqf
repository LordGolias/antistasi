#include "macros.hpp"
private ["_tipo","_coste","_grupo","_unit","_tam","_roads","_road","_pos","_camion","_texto","_mrk","_hr","_exists","_posicionTel","_tipogrupo","_resourcesFIA","_hrFIA"];

if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};

_tipo = _this select 0;
_maxCamps = 3;

private _currentCamps = ["camp", "FIA"] call AS_fnc_location_TS;

// BE module
_permission = true;
_text = "Error in permission system, module ft.";
if ((hayBE) && (_tipo == "create")) then {
	_permission = ["camp"] call fnc_BE_permission;
	_text = "We cannot maintain any additional camps.";
	_maxCamps = 100;
};

if !(_permission) exitWith {hint _text};
// BE module

openMap true;
posicionTel = [];
if (_tipo == "create") then {hint "Click on the position you wish to establish the camp."};
if (_tipo == "delete") then {hint "Click on the camp to abandon a camp."};
if (_tipo == "rename") then {hint "Click on the camp to rename a camp."};

onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
onMapSingleClick "";

if (count posicionTel == 0) exitWith {};

if (getMarkerPos "FIA_HQ" distance posicionTel < 100) exitWith {hint "Location is too close to base"; openMap false;};

openMap false;
_posicionTel = posicionTel;
_pos = [];

if ((_tipo == "delete") and (count _currentCamps < 1)) exitWith {hint "No camps to abandon."};
if ((_tipo == "delete") and ({(alive _x) and (!captive _x) and ((side _x == side_green) or (side _x == side_red)) and (_x distance _posicionTel < 500)} count allUnits > 0)) exitWith {hint "You cannot delete a camp while enemies are near it."};

_coste = 500;
_hr = 0;

if ((_tipo == "create") && (count _currentCamps > _maxCamps)) exitWith {hint "You can only sustain a maximum of four camps."};

if (_tipo == "create") then {
	_tipogrupo = "Sniper Team";
	([_tipogrupo] call AS_fnc_getFIASquadCost) params ["_cost", "_hr1"];
	_coste = _coste + _cost;
	_hr = _hr + _hr1;
};

_txt = "";
_break = false;
if (_tipo == "delete") then {
	private _camp = [_currentCamps,_posicionTel] call BIS_fnc_nearestPosition;
	private _position = _camp call AS_fnc_location_position;
	if (_posicionTel distance _position > 50) exitWith {_break = true; _txt = "No camp nearby.";};
};

if (_tipo == "rename") then {
	private _camp = [_currentCamps,_posicionTel] call BIS_fnc_nearestPosition;
	private _position = _camp call AS_fnc_location_position;

	if (_posicionTel distance _position > 50) exitWith {_break = true; _txt = "No camp nearby.";};

	createDialog "rCamp_Dialog";

	private _oldName = [_camp,"name"] call AS_fnc_location_get;
	((uiNamespace getVariable "rCamp") displayCtrl 1400) ctrlSetText _oldName;

	waitUntil {dialog};
	waitUntil {!dialog};

	private _newName = ctrlText ((uiNamespace getVariable "rCamp") displayCtrl 1400);

	if (_newName == "") exitWith {_break = true; _txt = "No name entered...";};
	if (_newName != _oldName) then {
		[_camp, "name", _newName] call AS_fnc_location_set;
		hint "Camp renamed";
	};
};

if (_break) exitWith {openMap false; hint _txt;};

_resourcesFIA = AS_P("resourcesFIA");
_hrFIA = AS_P("hr");

if (((_resourcesFIA < _coste) or (_hrFIA < _hr)) and (_tipo == "create")) exitWith {hint format ["You lack of resources to build this camp. \n %1 HR and %2 € needed",_hr,_coste]};

if (_tipo == "create") then {
	[-_hr,-_coste] remoteExec ["resourcesFIA",2];
};

if (_tipo != "rename") then {
	[[_tipo,_posicionTel],"establishCamp"] call BIS_fnc_MP;
};
