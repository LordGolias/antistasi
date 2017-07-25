#include "macros.hpp"
AS_SERVER_ONLY("AAFeconomics.sqf");
private ["_resourcesAAF","_coste","_destroyedCities","_destroyed","_nombre"];

waitUntil {isNil "AS_resourcesIsChanging"};
AS_resourcesIsChanging = true;

_resourcesAAF = AS_P("resourcesAAF");

private _debug_prefix = "AAFeconomics: ";
private _debug_message = format ["Starting to buy with %1", _resourcesAAF];
AS_ISDEBUG(_debug_prefix + _debug_message);

// This is needed only before AAF buys equipment.
call AS_fnc_updateAAFarsenal;

//////////////// try to restore cities ////////////////
if (_resourcesAAF > 5000) then {
	// todo: this only repairs cities. It should repair everything.
	_destroyedCities = AS_P("destroyedLocations") arrayIntersect (call AS_fnc_location_cities);
	private _repaired = [];
	if (count _destroyedCities > 0) then {
		{
			_destroyed = _x;
			if ((_resourcesAAF > 5000) and (not(_destroyed call AS_fnc_location_spawned))) then {
				_resourcesAAF = _resourcesAAF - 5000;
				_repaired pushBack _destroyed;
				private _type = _destroyed call AS_fnc_location_type;
				private _position = _destroyed call AS_fnc_location_position;
				private _nombre = [_destroyed] call localizar;
				[50,0,_position] remoteExec ["citySupportChange",2];
				[-5,0] remoteExec ["prestige",2];
				if (_type == "powerplant") then {[_destroyed] call powerReorg};
				[["TaskFailed", ["", format ["%1 rebuilt by AAF",_nombre]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			};
		} forEach _destroyedCities;
		AS_Pset("destroyedLocations", _destroyedCities - _repaired);
	} else {
		private _fnc_isNotRepairing = {"repair_antenna" call AS_fnc_active_missions == 0};
		if ((count antenasMuertas > 0) and _fnc_isnotRepairing) then {
			// try to rebuild one antenna.
			{
				private _location = _x call AS_fnc_location_nearest;
				if ((_resourcesAAF > 5000) and
				    {_location call AS_fnc_location_side == "AAF"} and
					{!(_location call AS_fnc_location_spawned)} and
					_fnc_isnotRepairing) exitWith {
						_resourcesAAF = _resourcesAAF - 5000;
						private _mission = ["repair_antenna", _location] call AS_fnc_mission_add;
						[_mission, "status", "available"] call AS_fnc_object_set;
						_mission call AS_fnc_mission_activate;
				};
			} forEach antenasMuertas;
		};
	};
};

//////////////// try to expand arsenal ////////////////

// extra conditions to avoid AAF being too strong.
// Categories without condition always buy if given enough money
private _FIAcontrolledLocations = count (
	[["watchpost", "factory", "powerplant", "resource"], "FIA"] call AS_fnc_location_TS);
private _FIAcontrolledBases = count (
	[["airfield", "base"], "FIA"] call AS_fnc_location_TS);

private _logicGroup = createGroup (createCenter sideLogic);
private _extra_conditions = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
_extra_conditions setVariable ["transportHelis", _FIAcontrolledLocations >= 1];
_extra_conditions setVariable ["tanks", _FIAcontrolledLocations >= 3];
_extra_conditions setVariable ["armedHelis", _FIAcontrolledLocations >= 3];
_extra_conditions setVariable ["planes", _FIAcontrolledBases >= 1];

{
	private _debug_bought_count = 0;
	private _cost = [_x] call AS_fnc_AAFarsenal_cost;
	private _extra_condition = _extra_conditions getvariable [_x,true];

	while {_extra_condition and ([_x] call AS_fnc_AAFarsenal_canAdd) and  _resourcesAAF > _cost} do {
		[_x] call AS_fnc_AAFarsenal_addVehicle;
		_resourcesAAF = _resourcesAAF - _cost;
		_debug_bought_count = _debug_bought_count + 1;
	};

	_debug_message = format ["bought %1 '%2' (%3,%4), remaining money: %5",
			_debug_bought_count, _x, [_x] call AS_fnc_AAFarsenal_canAdd, _extra_condition, _resourcesAAF];
	AS_ISDEBUG(_debug_prefix + _debug_message);
} forEach AS_AAFarsenal_categories;

deleteVehicle _extra_conditions;
deleteGroup _logicGroup;

//////////////// try to upgrade skills ////////////////
_skillFIA = AS_P("skillFIA");
_skillAAF = AS_P("skillAAF");
if ((_skillAAF < (_skillFIA + 4)) && (_skillAAF < AS_maxSkill)) then {
	_coste = 1000 + (1.5*(_skillAAF *750));
	if (_coste < _resourcesAAF) then {
        AS_Pset("skillAAF",_skillAAF + 1);
        _skillAAF = _skillAAF + 1;
		_resourcesAAF = _resourcesAAF - _coste;
	};
};

//////////////// try to build a minefield ////////////////
if (_resourcesAAF > 2000 and count (["minefield","AAF"] call AS_fnc_location_TS) < 3) then {
	private _minefieldDeployed = call AS_fnc_deployAAFminefield;
	if (_minefieldDeployed) then {_resourcesAAF = _resourcesAAF - 2000};
};
AS_Pset("resourcesAAF",round _resourcesAAF);

AS_resourcesIsChanging = nil;
