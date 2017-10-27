private _veh = cursortarget;
if (isNull _veh) exitWith {hint "You are not looking at any vehicle"};

if (player call AS_fnc_controlsAI) exitWith {hint "You cannot do this while controlling an AI"};

if ({isPlayer _x} count crew _veh > 0) exitWith {hint "In order to unlock this vehicle, it must be empty."};

private _owner = _veh getVariable "AS_vehOwner";
private _isFIA = isNil "_owner";

if _isFIA exitWith {
	hint "vehicle is already unlocked";
};
if (_owner != getPlayerUID player) exitWith {
	hint "You do not own this vehicle";
};
_veh setVariable ["AS_vehOwner", nil, true];
hint "vehicle unlocked";
