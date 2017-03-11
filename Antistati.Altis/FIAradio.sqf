private ["_chance","_pos","_marcador"];

_chance = 5;
{_pos = getPos _x;
_marcador = [marcadores,_pos] call BIS_fnc_nearestPosition;
if ((not(_marcador in mrkAAF)) and (alive _x)) then {_chance = _chance + 2.25};
} forEach antenas;

if (debug) then {_chance = 100};

if (random 100 < _chance) then
	{
	if (not revelar) then
		{
		[["TaskSucceeded", ["", "AAF Comms Intercepted"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		revelar = true; publicVariable "revelar";
		[[], "revealToPlayer.sqf"] remoteExec ["execVM", [0,-2] select isDedicated, true];
		};
	}
else
	{
	if (revelar) then
		{
		[["TaskFailed", ["", "AAF Comms Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		revelar = false; publicVariable "revelar";
		};
	};