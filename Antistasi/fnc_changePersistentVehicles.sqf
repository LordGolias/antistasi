#include "macros.hpp"
AS_SERVER_ONLY("fnc_changePersistentVehicles.sqf");

waitUntil {isNil "AS_vehiclesChanging"};
AS_vehiclesChanging = true;
params ["_vehicles", ["_add", true]];

if (typeName _vehicles != "ARRAY") then {
    _vehicles = [_vehicles];
};

if (_add) then {
    AS_Pset("vehicles", AS_P("vehicles") + _vehicles);
} else {
    AS_Pset("vehicles", AS_P("vehicles") - _vehicles);
    // set the vehicles back to the despawner
    {
        [_x] spawn AS_fnc_activateVehicleCleanup;
    } forEach _vehicles;
};

AS_vehiclesChanging = nil;
