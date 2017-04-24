#include "../macros.hpp"
AS_SERVER_ONLY("fnc_changePersistentVehicles.sqf");

waitUntil {isNil "AS_vehiclesChanging"};
AS_vehiclesChanging = true;
params ["_vehicle", ["_add", true]];

if (_add) then {
    AS_Pset("vehicles", AS_P("vehicles") + [_vehicle]);
} else {
    AS_Pset("vehicles", AS_P("vehicles") - [_vehicle]);
};

AS_vehiclesChanging = nil;
