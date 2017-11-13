[[petros,"hint","Deleting Garbage..."],"AS_fnc_localCommunication"] call BIS_fnc_MP;

private _toDelete = nearestObjects [markerPos "AS_base_4", ["WeaponHolderSimulated", "GroundWeaponHolder", "WeaponHolder"], 16000];
{
	deleteVehicle _x;
} forEach _toDelete;
{deleteVehicle _x} forEach allDead;

[[petros,"hint","Garbage deleted"],"AS_fnc_localCommunication"] call BIS_fnc_MP;
