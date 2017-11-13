#include "macros.hpp"
AS_SERVER_ONLY("fnc_hq_deletePad.sqf");

if not(isNil "vehiclePad") then {
    deleteVehicle vehiclePad;
    vehiclePad = nil;
    publicVariable "vehiclePad";
};
AS_Sset("AS_vehicleOrientation", 0);
