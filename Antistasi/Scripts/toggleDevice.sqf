#include "../macros.hpp"
if isNil AS_S("activeItem") exitWith {};

private _object = AS_S("activeItem");

if AS_S("BCdisabled") exitWith {
	{if (isPlayer _x) then {[petros,"hint","The device can only be activated once."] remoteExec ["commsMP",_x]}} forEach ([20, _object, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
};

if not AS_S("BCactive") then {
	{if (isPlayer _x) then {[petros,"hint","Device activated."] remoteExec ["commsMP",_x]}} forEach ([20, _object, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
	AS_Sset("BCactive", true);
	sleep 2700;
	AS_Sset("BCactive", false);
	{if (isPlayer _x) then {[petros,"hint","Device deactivated."] remoteExec ["commsMP",_x]}} forEach ([20, _object, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
} else {
	AS_Sset("BCactive", false);
	AS_Sset("BCdisabled", true);
	{if (isPlayer _x) then {[petros,"hint","Device turned off."] remoteExec ["commsMP",_x]}} forEach ([20, _object, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
	[[propTruck,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;
};
