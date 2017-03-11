private ["_veh", "_coste"];

_pool = _this select 0;

_veh = cursortarget;

if (isNull _veh) exitWith {hint "You are not looking at any vehicle"};

if ({isPlayer _x} count crew _veh > 0) exitWith {hint "In order to unlock this vehicle, it must be empty."};

_owner = _veh getVariable "duenyo";
_exit = false;

if (!_pool) then {
	_owner = _veh getVariable "duenyo";
	if (!isNil "_owner") then {
		if (_owner isEqualType "") then {
			if (getPlayerUID player != _owner) then {_exit = true};
		};
	};
};

if (_exit) exitWith {hint "You are not owner of this vehicle and you cannot unlock it"};

if ((_pool) and (isNil "_owner")) exitWith {_veh setVariable ["duenyo",getPlayerUID player,true]; hint "Vehicle locked";};

_veh setVariable ["duenyo",nil,true];
hint "Vehicle unlocked.";