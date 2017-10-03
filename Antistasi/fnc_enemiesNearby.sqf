params ["_position", "_distance"];

private _enemiesNearby = false;
{
	if (((_x call AS_fnc_getSide) in ["AAF", "CSAT"]) and
        {_x distance _position < _distance} and
        {not(captive _x)}) exitWith {_enemiesNearby = true};
} forEach allUnits;

_enemiesNearby
