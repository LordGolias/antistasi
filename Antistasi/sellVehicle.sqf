private ["_veh", "_coste"];
_veh = cursortarget;

if (isNull _veh) exitWith {hint "You are not looking to any vehicle"};

if (_veh distance getMarkerPos "respawn_west" > 50) exitWith {hint "Vehicle must be closer than 50 meters to the flag"};

if ({isPlayer _x} count crew _veh > 0) exitWith {hint "In order to sell, vehicle must be empty."};

_owner = _veh getVariable "duenyo";
_exit = false;
if (!isNil "_owner") then
	{
	if (_owner isEqualType "") then
		{
		if (getPlayerUID player != _owner) then {_exit = true};
		};
	};

if (_exit) exitWith {hint "You are not owner of this vehicle and you cannot sell it"};

_tipoVeh = typeOf _veh;
_coste = 0;

call {
	if (_tipoVeh in vehNATO) exitWith {hint "You cannot sell NATO vehicles"};
	if (_tipoVeh in vehFIA) exitWith {_coste = round (([_tipoVeh] call vehiclePrice)/2)};
	if (_tipoveh == "C_Van_01_fuel_F") exitWith {_coste = 50};
	if (_tipoVeh in arrayCivVeh) exitWith {_coste = 25};

	private _category = [_tipoVeh] call AS_fnc_AAFarsenal_category;
	if (_category in AS_AAFarsenal_categories) then {
		[typeOf _veh] call AS_fnc_AAFarsenal_deleteVehicle;
		_coste = [_category] call AS_fnc_AAFarsenal_value;
	};
};

if (_coste == 0) exitWith {hint "The vehicle you are looking at is currently not in demand in our marketplace."};

_coste = _coste * (1-damage _veh);

[0,_coste] remoteExec ["resourcesFIA",2];

if (_veh in staticsToSave) then {staticsToSave = staticsToSave - [_veh]; publicVariable "staticsToSave"};
if (_veh in reportedVehs) then {reportedVehs = reportedVehs - [_veh]; publicVariable "reportedVehs"};

[_veh] call vaciar;
deleteVehicle _veh;

if (_veh isKindOf "StaticWeapon") then {deleteVehicle _veh};

hint "Vehicle Sold";
