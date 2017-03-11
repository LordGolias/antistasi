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
	if (_tipoVeh in (vehTrucks + vehPatrol + vehSupply)) exitWith {_coste = 300};
	if (_tipoVeh in vehAAFAT) then {
		if (_tipoVeh in vehTank) exitWith {
			[_veh] call AAFassets;
			_coste = 5000;
		};
		if (_tipoVeh in vehIFV) exitWith {
			[_veh] call AAFassets;
			_coste = 2000;
		};
		if (_tipoVeh in vehAPC) exitWith {
			[_veh] call AAFassets;
			_coste = 1000;
		};
	};
	if (_tipoVeh in planesAAF) then {
		if (_tipoVeh in heli_unarmed) exitWith {
			[_veh] call AAFassets;
			_coste = 1000;
		};
		if (_tipoVeh in heli_armed) exitWith {
			[_veh] call AAFassets;
			_coste = 5000;
		};
		if (_tipoVeh in planes) exitWith {
			[_veh] call AAFassets;
			_coste = 10000;
		};
	};
};

if (_coste == 0) exitWith {hint "The vehicle you are looking at is currently not in demand in our marketplace."};

_coste = _coste * (1-damage _veh);

[0,_coste] remoteExec ["resourcesFIA",2];

if (_veh in staticsToSave) then {staticsToSave = staticsToSave - [_veh]; publicVariable "staticsToSave"};
if (_veh in reportedVehs) then {reportedVehs = reportedVehs - [_veh]; publicVariable "reportedVehs"};

[_veh,true] call vaciar;

if (_veh isKindOf "StaticWeapon") then {deleteVehicle _veh};

hint "Vehicle Sold";



