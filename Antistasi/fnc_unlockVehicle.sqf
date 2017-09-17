params ["_pool"];

private _veh = cursortarget;
if (isNull _veh) exitWith {hint "You are not looking at any vehicle"};

if ({isPlayer _x} count crew _veh > 0) exitWith {hint "In order to unlock this vehicle, it must be empty."};

private _owner = _veh getVariable "AS_vehOwner";
private _hasOwner = not isNil "_owner";

if (not _pool and _hasOwner and {getPlayerUID player != _owner}) then {
	hint "You are not owner of this vehicle and you cannot unlock it";
};

if (_pool and not hasOwner) then {
	_veh setVariable ["AS_vehOwner", getPlayerUID player, true];
	hint "Vehicle locked";
} else {
	_veh setVariable ["AS_vehOwner", nil, true];
	hint "Vehicle unlocked";
};
