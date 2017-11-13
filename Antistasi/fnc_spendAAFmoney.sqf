#include "macros.hpp"
AS_SERVER_ONLY("AS_fnc_spendAAFmoney.sqf");

waitUntil {isNil "AS_resourcesIsChanging"};
AS_resourcesIsChanging = true;

private _resourcesAAF = AS_P("resourcesAAF");

private _debug_prefix = "[AS] Debug AS_fnc_spendAAFmoney: ";
private _debug_message = format ["buying with %1", _resourcesAAF];
AS_ISDEBUG(_debug_prefix + _debug_message);

//////////////// try to restore cities ////////////////
if (_resourcesAAF > 5000) then {
	// todo: this only repairs cities. It should repair everything.
	private _destroyedCities = AS_P("destroyedLocations") arrayIntersect (call AS_location_fnc_cities);
	private _repaired = [];
	if (count _destroyedCities > 0) then {
		{
			private _destroyed = _x;
			if ((_resourcesAAF > 5000) and (not(_destroyed call AS_location_fnc_spawned))) then {
				_resourcesAAF = _resourcesAAF - 5000;
				_repaired pushBack _destroyed;
				private _type = _destroyed call AS_location_fnc_type;
				private _position = _destroyed call AS_location_fnc_position;
				private _nombre = [_destroyed] call AS_fnc_location_name;
				[50,0,_position] remoteExec ["AS_fnc_changeCitySupport",2];
				[-5,0] call AS_fnc_changeForeignSupport;
				if (_type == "powerplant") then {[_destroyed] call AS_fnc_recomputePowerGrid};
				[["TaskFailed", ["", format ["%1 rebuilt by %2",_nombre, AS_AAFname]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			};
		} forEach _destroyedCities;
		AS_Pset("destroyedLocations", _destroyedCities - _repaired);
	} else {
		private _fnc_isNotRepairing = {count ("repair_antenna" call AS_mission_fnc_active_missions) == 0};
		if (call _fnc_isnotRepairing) then {
			// try to rebuild one antenna.
			{
				private _location = _x call AS_location_fnc_nearest;
				if ((_resourcesAAF > 5000) and
				    {_location call AS_location_fnc_side == "AAF"} and
					{!(_location call AS_location_fnc_spawned)} and
					_fnc_isnotRepairing) exitWith {
						_resourcesAAF = _resourcesAAF - 5000;
						private _mission = ["repair_antenna", _location] call AS_mission_fnc_add;
						_mission call AS_mission_fnc_activate;
				};
			} forEach AS_P("antenasPos_dead");
		};
	};
};

//////////////// try to expand arsenal ////////////////

// extra conditions to avoid AAF being too strong.
// Categories without condition always buy if given enough money
private _FIAcontrolledLocations = count (
	[["watchpost", "factory", "powerplant", "resource"], "FIA"] call AS_location_fnc_TS);
private _FIAcontrolledBases = count (
	[["airfield", "base"], "FIA"] call AS_location_fnc_TS);

private _extra_conditions = createSimpleObject ["Static", [0, 0, 0]];
_extra_conditions setVariable ["transportHelis", _FIAcontrolledLocations >= 1];
_extra_conditions setVariable ["tanks", _FIAcontrolledLocations >= 3];
_extra_conditions setVariable ["armedHelis", _FIAcontrolledLocations >= 3];
_extra_conditions setVariable ["planes", _FIAcontrolledBases >= 1];

{
	private _debug_bought_count = 0;
	private _cost = _x call AS_AAFarsenal_fnc_cost;
	private _extra_condition = _extra_conditions getvariable [_x,true];

	while {_extra_condition and {_x call AS_AAFarsenal_fnc_canAdd} and {_resourcesAAF > _cost}} do {
		_x call AS_AAFarsenal_fnc_addVehicle;
		_resourcesAAF = _resourcesAAF - _cost;
		_debug_bought_count = _debug_bought_count + 1;
	};

	_debug_message = format ["bought %1 '%2' (%3,%4), remaining money: %5",
			_debug_bought_count, _x, _x call AS_AAFarsenal_fnc_canAdd, _extra_condition, _resourcesAAF];
	AS_ISDEBUG(_debug_prefix + _debug_message);
} forEach AS_AAFarsenal_buying_order;

deleteVehicle _extra_conditions;

//////////////// try to upgrade skills ////////////////
private _skillFIA = AS_P("skillFIA");
private _skillAAF = AS_P("skillAAF");
if ((_skillAAF < (_skillFIA + 4)) && (_skillAAF < AS_maxSkill)) then {
	private _coste = 1000 + (1.5*(_skillAAF *750));
	if (_coste < _resourcesAAF) then {
        AS_Pset("skillAAF", _skillAAF + 1);
        _skillAAF = _skillAAF + 1;
		_resourcesAAF = _resourcesAAF - _coste;
	};
};

//////////////// try to build a minefield ////////////////
if (_resourcesAAF > 2000 and count (["minefield","AAF"] call AS_location_fnc_TS) < 3) then {
	private _minefieldDeployed = call AS_fnc_deployAAFminefield;
	if (_minefieldDeployed) then {_resourcesAAF = _resourcesAAF - 2000};
};
AS_Pset("resourcesAAF",round _resourcesAAF);

AS_resourcesIsChanging = nil;
