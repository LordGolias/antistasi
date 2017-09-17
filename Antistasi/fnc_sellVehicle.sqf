#include "macros.hpp"
private ["_veh", "_cost"];
_veh = cursortarget;

if (isNull _veh) exitWith {hint "You are not looking to any vehicle"};

if (_veh distance getMarkerPos "FIA_HQ" > 50) exitWith {hint "Vehicle must be closer than 50 meters to the flag"};

if ({isPlayer _x} count crew _veh > 0) exitWith {hint "Vehicle must be empty (people)."};

private _owner = _veh getVariable "AS_vehOwner";
if ((!isNil "_owner") and {_owner isEqualType ""} and {getPlayerUID player != _owner}) exitWith {
	hint "You do not own this vehicle";
};

private _tipoVeh = typeOf _veh;
_cost = 0;

call {
	if (_tipoVeh in vehNATO) exitWith {};
	if (_tipoVeh in AS_FIArecruitment_all) exitWith {
		_cost = [_tipoVeh, true] call AS_fnc_getFIAvehiclePrice};
	if (_tipoVeh in arrayCivVeh) exitWith {_cost = 25};

	private _category = [_tipoVeh] call AS_AAFarsenal_fnc_category;
	if (_category != "") then {
		[typeOf _veh] call AS_AAFarsenal_fnc_deleteVehicle;
		_cost = [_category] call AS_AAFarsenal_fnc_value;
	};
};

if (_cost == 0) exitWith {hint "The vehicle you are looking at is not sellable."};

_cost = _cost * (1 - damage _veh);

[0,_cost] remoteExec ["AS_fnc_changeFIAmoney", 2];

if (_veh in AS_S("reportedVehs")) then {
	AS_Sset("reportedVehs", AS_S("reportedVehs") - [_veh]);
};
[_veh, false] remoteExec ["AS_fnc_changePersistentVehicles", 2];
[_veh, caja] call AS_fnc_transferToBox;
deleteVehicle _veh;

hint "Vehicle Sold";
