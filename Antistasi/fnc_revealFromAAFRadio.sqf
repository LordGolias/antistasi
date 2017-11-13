#include "macros.hpp"
AS_SERVER_ONLY("AS_fnc_revealFromAAFRadio.sqf");

private _chance = 5;
{
	private _location = [call AS_location_fnc_all, _x] call BIS_fnc_nearestPosition;
	if ((_location call AS_location_fnc_side == "FIA") and (alive nearestBuilding _x)) then {
		_chance = _chance + 2.25;
	};
} forEach AS_P("antenasPos_alive");

if (random 100 < _chance) then {
	if !(AS_S("revealFromRadio")) then {
		[["TaskSucceeded", ["", AS_AAFname + " Comms Intercepted"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		AS_Sset("revealFromRadio",true);
		[] remoteExec ["AS_fnc_revealToPlayer", [0,-2] select isDedicated];
	};
} else {
	if (AS_S("revealFromRadio")) then {
		[["TaskFailed", ["", AS_AAFname + " Comms Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		AS_Sset("revealFromRadio",false);
	};
};
