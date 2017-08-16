#include "macros.hpp"
AS_CLIENT_ONLY("garageVehicle.sqf");
params [["_toFIAgarage", false]];

private _veh = cursorTarget;

if isNull _veh exitWith {hint "You are not looking at a vehicle"};

private _type = typeOf _veh;

if not alive _veh exitWith {hint "You cannot add destroyed vehicles to your garage"};
if (_veh distance (getMarkerPos "FIA_HQ") > 50) exitWith {hint "The vehicle must be closer than 50 meters to the flag"};
if ({isPlayer _x} count crew _veh > 0) exitWith {hint "The vehicle must be crewless"};
if (_type in (vehNATO + planesNATO)) exitWith {hint "You cannot keep NATO vehicles"};
if (_veh isKindOf "Man") exitWith {hint "Are you kidding?"};

if (not(_veh isKindOf "AllVehicles")) exitWith {hint "The vehicle you are looking cannot be kept in our Garage"};

private _exit = false;
if not _toFIAgarage then {
	private _owner = _veh getVariable "duenyo";
	if ((not isNil "_owner") and {_owner isEqualType ""} and {getPlayerUID player != _owner}) then {
		_exit = true
	};
};
if _exit exitWith {hint "You do not own this vehicle"};

private _hasPermission = true;
private _checkText = "";
private _text = "Error in permission system, module garage.";
if (_toFIAgarage) then {
	_hasPermission = ["FIA_garage"] call fnc_BE_permission;
	_checkText = format ["first :%1 -- %2", _hasPermission, _checkText];
	_text = "There's not enough space in our garage...";
} else {
	_hasPermission = ["pers_garage"] call fnc_BE_permission;
	_checkText = format ["second :%1 -- %2", _hasPermission, _checkText];
	_text = "There's not enough space in your garage...";
};

if _hasPermission then {
	_hasPermission = ["vehicle", typeOf _veh, _veh] call fnc_BE_permission;
	_checkText = format ["third :%1 -- %2", _hasPermission, _checkText];
	_text = "We cannot maintain this type of vehicle.";
};

if not _hasPermission exitWith {hint _text};

//////////// Checks completed ////////////

if (_veh in reportedVehs) then {
	reportedVehs = reportedVehs - [_veh];
	publicVariable "reportedVehs"
};
[_veh, false] remoteExec ["AS_fnc_changePersistentVehicles", 2];
[_veh, caja] remoteExec ["AS_fnc_transferToBox", 2];
waitUntil {not AS_S("lockTransfer")};
deleteVehicle _veh;

if ((count FIA_texturedVehicles > 0) && !(_type in FIA_texturedVehicles)) then {
	for "_i" from 0 to (count FIA_texturedVehicleConfigs - 1) do {
		if ((_type == configName (inheritsFrom (FIA_texturedVehicleConfigs select _i))) ||
		    (configName (inheritsFrom (configFile >> "CfgVehicles" >> _type)) == configName (inheritsFrom (FIA_texturedVehicleConfigs select _i)))) exitWith {
			_type = configName (FIA_texturedVehicleConfigs select _i);
		};
	};
};

if _toFIAgarage then {
		AS_Pset("vehiclesInGarage", AS_P("vehiclesInGarage") + [_type]);
	hint "Vehicle added to FIA Garage";
} else {
	personalGarage = personalGarage + [_type];
	hint "Vehicle added to Personal Garage";
};
