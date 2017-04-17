#include "macros.hpp"
private ["_tipo","_coste","_grupo","_unit","_tam","_roads","_road","_pos","_camion","_texto","_mrk","_hr","_exists","_posicionTel","_isRoadblock","_tipogrupo"];

if ("PuestosFIA" in misiones) exitWith {hint "We can only deploy / delete one Post or Roadblock at a time."};
if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};

_tipo = _this select 0;

openMap true;
posicionTel = [];
if (_tipo != "delete") then {
	hint "Click on the position you wish to build the Observation Post or Roadblock. \n Remember: to build Roadblocks you must click exactly on a road map section"
} else {
	hint "Click on the Observation Post or Roadblock to delete."
};

onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
onMapSingleClick "";

if (count posicionTel == 0) exitWith {};

_posicionTel = posicionTel;
_pos = [];

private _location = _posicionTel call AS_fnc_location_nearest;
if (_tipo == "delete" and (_location call AS_fnc_location_type != _type)) exitWith {
	hint "That is not a watchpost or roadblock";
};

if ((_tipo == "delete") and ({(alive _x) and (!captive _x) and ((side _x == side_green) or (side _x == side_red)) and (_x distance _posicionTel < 500)} count allUnits > 0)) exitWith {
	hint "You cannot delete a Post while enemies are near it";
};

_coste = 0;
_hr = 0;

private _type = "watchpost";
if (isOnRoad _posicionTel) then {
	_type = "roadblock";
};

if (_tipo != "delete") then {
	// BE module
	private _permission = true;
	private _text = "Error in permission system, module rb/wp.";
	if (hayBE) then {
		if (_type == "roadblock") then {
			_permission = ["RB"] call fnc_BE_permission;
			_text = "We cannot maintain any additional roadblocks.";
		} else {
			_permission = ["WP"] call fnc_BE_permission;
			_text = "We cannot maintain any additional watchposts.";
		};
	};
	if !(_permission) exitWith {hint _text; openMap false;};

	_tipogrupo = "Sniper Squad";
	if (_type == "roadblock") then {
		_tipogrupo = "AT Team";
		_coste = _coste + (["B_G_Offroad_01_armed_F"] call FIAvehiclePrice) + (AS_data_allCosts getVariable "Crew");
		_hr = _hr + 1;
	};

	([_tipogrupo] call AS_fnc_getFIASquadCost) params ["_cost1", "_hr1"];
	_coste = _coste + _cost1;
	_hr = _hr + _hr1;
};

if (((AS_P("resourcesFIA") < _coste) or (AS_P("hr") < _hr)) and
	(_tipo != "delete")) exitWith {
		hint format ["You lack of resources to build this Watchpost or Roadblock \n %1 HR and %2 € needed",_hr,_coste]
};

if (_tipo != "delete") then {
	[-_hr,-_coste] remoteExec ["resourcesFIA",2];
};

[[_tipo,_posicionTel],"crearPuestosFIA"] call BIS_fnc_MP
