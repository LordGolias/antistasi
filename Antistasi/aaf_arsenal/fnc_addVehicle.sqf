// Adds a vehicle to the arsenal.
// Returns whether it was added or not
#include "../macros.hpp"
AS_SERVER_ONLY("AS_AAFarsenal_fnc_addVehicle");
private _count = _this call AS_AAFarsenal_fnc_count;
[_this, "count", _count + 1] call AS_AAFarsenal_fnc_set;
