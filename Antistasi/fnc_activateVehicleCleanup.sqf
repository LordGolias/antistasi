/*
Controlled way to despawn a vehicle. The vehicle is despawned when (AND):
* it is not a saved vehicle
* it is not close to FIA_HQ
* there is no BLUFOR around
*/
#include "macros.hpp"
params ["_vehicle"];

if (_vehicle getVariable ["inDespawner", false]) exitWith {};
_vehicle setVariable ["inDespawner", true, true];

waitUntil {
	sleep (5 + random 5);
	not (_vehicle in AS_P("vehicles")) and
	{_vehicle distance getMarkerPos "FIA_HQ" > 50} and
	{not ([AS_P("spawnDistance"), _vehicle, "BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance)}
};

if (_vehicle in AS_S("reportedVehs")) then {
	AS_Sset("reportedVehs", AS_S("reportedVehs") - [_vehicle]);
};
if (_vehicle in AS_P("vehicles")) then {
	[_vehicle, false] remoteExec ["AS_fnc_changePersistentVehicles", 2];
};
if (_vehicle isKindOf "test_EmptyObjectForSmoke") then {
	{deleteVehicle _x} forEach (_vehicle getVariable ["effects", []]);
};
deleteVehicle _vehicle;
