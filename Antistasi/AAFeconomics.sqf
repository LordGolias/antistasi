#include "macros.hpp"
private ["_resourcesAAF","_prestigeCSAT","_coste","_destroyedCities","_destroyed","_nombre"];

_resourcesAAF = AS_P("resourcesAAF");

_prestigeCSAT = AS_P("prestigeCSAT");

waitUntil {!resourcesIsChanging};
resourcesIsChanging = true;

// This is needed only before AAF buys equipment.
call AS_fnc_updateAAFarsenal;

//////////////// try to restore cities ////////////////
if (_resourcesAAF > 5000) then
	{
	_destroyedCities = destroyedCities arrayIntersect (call AS_fnc_location_cities);
	if (count _destroyedCities > 0) then
		{
		{
		_destroyed = _x;
		if ((_resourcesAAF > 5000) and (not(_destroyed call AS_fnc_location_spawned))) then
			{
			_resourcesAAF = _resourcesAAF - 5000;
			destroyedCities = destroyedCities - [_destroyed];
			private _type = _destroyed call AS_fnc_location_type;
			private _position = _destroyed call AS_fnc_location_position;
			private _nombre = [_destroyed] call localizar;
			publicVariable "destroyedCities";
			[10,0,_position] remoteExec ["citySupportChange",2];
			[-5,0] remoteExec ["prestige",2];
			if (_type == "powerplant") then {[_destroyed] call powerReorg};
			[["TaskFailed", ["", format ["%1 rebuilt by AAF",_nombre]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			};
		} forEach _destroyedCities;
		}
	else
		{
		if ((count antenasMuertas > 0) and (not("REP" in misiones))) then
			{
			{
			if ((_resourcesAAF > 5000) and (not("REP" in misiones))) then {
				private _location = [call AS__fnc_location_all, _x] call BIS_fnc_nearestPosition;
				if ((_location call AS_fnc_location_side == "AAF") and !(_location call AS_fnc_location_spawned)) then {
					[_location,_x] remoteExec ["REP_Antena",HCattack];
					_resourcesAAF = _resourcesAAF - 5000;
				};
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
	private _cost = [_x] call AS_fnc_AAFarsenal_cost;
	private _extra_condition = _extra_conditions getvariable [_x,true];

	while {_extra_condition and ([_x] call AS_fnc_AAFarsenal_canAdd) and  _resourcesAAF > _cost} do {
		[_x] call AS_fnc_AAFarsenal_addVehicle;
		_resourcesAAF = _resourcesAAF - _cost;
	};
} forEach AS_AAFarsenal_categories;

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

//////////////// try to build minefields ////////////////
// todo: code inside this condition is broken (two opposing conditions)
if (_resourcesAAF > 2000) then
	{
	{
	if (_resourcesAAF < 2000) exitWith {};
	if ([_x] call isFrontline) then {
		_cercano = ["FIA" call AS_fnc_location_S, _x call AS_fnc_location_position] call BIS_fnc_nearestPosition;
		_minefieldDone = false;
		_minefieldDone = [_cercano,_x] call minefieldAAF;
		if (_minefieldDone) then {_resourcesAAF = _resourcesAAF - 2000};
	};
	} forEach (["base", "AAF"] call AS_fnc_location_TS);
	};
AS_Pset("resourcesAAF",round _resourcesAAF);

resourcesIsChanging = false;
