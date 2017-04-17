private _chance = 5;
{
	private _location = [call AS_fnc_location_all, getPos _x] call BIS_fnc_nearestPosition;
	if ((_location call AS_fnc_location_side == "FIA") and (alive _x)) then {
		_chance = _chance + 2.25;
	};
} forEach antenas;

if (random 100 < _chance) then {
	if (not revelar) then {
		[["TaskSucceeded", ["", "AAF Comms Intercepted"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		revelar = true; publicVariable "revelar";
		[[], "revealToPlayer.sqf"] remoteExec ["execVM", [0,-2] select isDedicated, true];
	};
} else {
	if (revelar) then {
		[["TaskFailed", ["", "AAF Comms Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		revelar = false; publicVariable "revelar";
	};
};
