#include "macros.hpp"
AS_SERVER_ONLY("AS_fnc_startGame.sqf");
params ["_side", "_guerrilla", "_pro_guerrilla", "_state", "_pro_state", "_civilians", "_position", "_difficulty"];

AS_Pset("faction_anti_state", _guerrilla);
AS_Pset("faction_pro_anti_state", _pro_guerrilla);
AS_Pset("faction_state", _state);
AS_Pset("faction_pro_state", _pro_state);
AS_Pset("faction_civilian", _civilians);

AS_Pset("player_side", _side);

[_position, true] call AS_fnc_HQplace;

if (_difficulty == "easy") then {
    [caja, 10] call AS_fnc_fillCrateNATO;
};

// populate garage with vehicles
private _validVehicles = (
    (["FIA", "land_vehicles"] call AS_fnc_getEntity) -
    (["FIA", "cars_armed"] call AS_fnc_getEntity)
);
private _garageVehicles = [];
for "_i" from 1 to (1 + floor random 3) do {
	_garageVehicles pushBack (selectRandom _validVehicles);
};
AS_Pset("vehiclesInGarage", _garageVehicles);

{
    [_x, "valid", ["AAF", _x] call AS_fnc_getEntity] call AS_AAFarsenal_fnc_set;
} forEach AS_AAFarsenal_buying_order;

AS_dataInitialized = true;
