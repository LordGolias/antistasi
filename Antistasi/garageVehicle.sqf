private ["_pool","_veh","_tipoVeh"];
_pool = false;
if (_this select 0) then {_pool = true};
_veh = cursorTarget;

if (isNull _veh) exitWith {hint "You are not looking at a vehicle"};

if (!alive _veh) exitWith {hint "You cannot add destroyed vehicles to your garage"};

if (_veh distance getMarkerPos "FIA_HQ" > 50) exitWith {hint "Vehicle must be closer than 50 meters to the flag"};

if ({isPlayer _x} count crew _veh > 0) exitWith {hint "In order to store vehicle, its crew must disembark."};

_tipoVeh = typeOf _veh;

if ((_tipoVeh in vehNATO) or (_tipoVeh in planesNATO)) exitWith {hint "You cannot keep NATO vehicles"};

if (_veh isKindOf "Man") exitWith {hint "Are you kidding?"};

if (not(_veh isKindOf "AllVehicles")) exitWith {hint "The vehicle you are looking cannot be kept in our Garage"};

_exit = false;
if (!_pool) then
	{
	_owner = _veh getVariable "duenyo";
	if (!isNil "_owner") then
		{
		if (_owner isEqualType "") then
			{
			if (getPlayerUID player != _owner) then {_exit = true};
			};
		};
	};

if (_exit) exitWith {hint "You are not owner of this vehicle and you cannot garage it"};

_permission = true;
_checkText = "";
_text = "Error in permission system, module garage.";
if (_pool) then {
	_permission = ["FIA_garage"] call fnc_BE_permission;
	_checkText = format ["first :%1 -- %2", _permission, _checkText];
	_text = "There's not enough space in our garage...";
} else {
	_permission = ["pers_garage"] call fnc_BE_permission;
	_checkText = format ["second :%1 -- %2", _permission, _checkText];
	_text = "There's not enough space in your garage...";
};

if (_permission) then {
	_permission = ["vehicle", _tipoVeh, _veh] call fnc_BE_permission;
	_checkText = format ["third :%1 -- %2", _permission, _checkText];
	_text = "We cannot maintain this type of vehicle.";
};

//[petros,"hint",_checkText] remoteExec ["commsMP",AS_commander];

if !(_permission) exitWith {hint _text};

if (_veh in staticsToSave) then {staticsToSave = staticsToSave - [_veh]; publicVariable "staticsToSave"};

if (server getVariable "lockTransfer") exitWith {
	{
		if (_x distance caja < 20) then {
			[petros,"hint","Currently unloading another ammobox. Please wait a few seconds."] remoteExec ["commsMP",_x];
		};
	} forEach playableUnits;
};

if (!(_veh isKindOf "StaticWeapon")) then {
	[_veh] call vaciar;
};
deleteVehicle _veh;
if (_veh in reportedVehs) then {reportedVehs = reportedVehs - [_veh]; publicVariable "reportedVehs"};

if ((count FIA_texturedVehicles > 0) && !(_tipoVeh in FIA_texturedVehicles)) then {
	for "_i" from 0 to (count FIA_texturedVehicleConfigs - 1) do {
		if ((_tipoVeh == configName (inheritsFrom (FIA_texturedVehicleConfigs select _i))) || (configName (inheritsFrom (configFile >> "CfgVehicles" >> _tipoVeh)) == configName (inheritsFrom (FIA_texturedVehicleConfigs select _i)))) exitWith {
			_tipoVeh = configName (FIA_texturedVehicleConfigs select _i);
		};
	};
};

if (_pool) then
	{
	vehInGarage = vehInGarage + [_tipoVeh];
	publicVariable "vehInGarage";
	hint "Vehicle added to FIA Garage";
	}
else
	{
	personalGarage = personalGarage + [_tipoVeh];
	hint "Vehicle added to Personal Garage";
	};