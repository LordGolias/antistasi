params ["_helicopter", "_group", "_position", "_threat"];

{
	_x disableAI "TARGET";
	_x disableAI "AUTOTARGET"
} foreach units group driver _helicopter;

private _distance = 400 + (10*_threat);

private _orig = [0,0,0];
if ((driver _helicopter call AS_fnc_getSide) == "CSAT") then {
	_orig = getMarkerPos "spawnCSAT";
} else {
	_orig = getMarkerPos "spawnNATO";
};

private _startDropPosition = [];
private _midDropPosition = [];

private _randang = random 360;

// find a position within distance from the target
private _midDropPosition = [_position, _distance, _randang] call BIS_Fnc_relPos;
while {surfaceIsWater _midDropPosition} do {
	_randang = random 360;
 	_midDropPosition = [_position, _distance, _randang] call BIS_Fnc_relPos;
};

_randang = _randang + 90;

private _endDropPosition = [_position, 400, _randang] call BIS_Fnc_relPos;
while {surfaceIsWater _endDropPosition or _endDropPosition distance _position < 300} do {
 	_endDropPosition = [_position, 400, _randang] call BIS_Fnc_relPos;
 	_randang = _randang + 5;
 	if ((!surfaceIsWater _endDropPosition) and (_endDropPosition distance _position > 300)) exitWith {};
};

_randang = ([_midDropPosition,_endDropPosition] call BIS_fnc_dirTo) - 180;

_startDropPosition = [_midDropPosition, 1000, _randang] call BIS_Fnc_relPos;

{_x setBehaviour "CARELESS"} forEach units _helicopter;
_helicopter flyInHeight (150+(20*_threat));

private _wp = _helicopter addWaypoint [_startDropPosition, 0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";

private _wp1 = _helicopter addWaypoint [_midDropPosition, 1];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "LIMITED";

private _wp2 = _helicopter addWaypoint [_endDropPosition, 2];
_wp2 setWaypointType "MOVE";

private _wp3 = _helicopter addWaypoint [_orig, 3];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];

waitUntil {sleep 1; (currentWaypoint _helicopter == 3) or {not alive _helicopter}};

if not alive _helicopter exitWith {};

[_helicopter] call AS_fnc_toggleVehicleDoors;
{
   unAssignVehicle _x;
   _x allowDamage false;
   moveOut _x;
   sleep 0.35;
   private _chute = createVehicle ["NonSteerable_Parachute_F", (getPos _x), [], 0, "NONE"];
   _chute setPos (getPos _x);
   _x moveinDriver _chute;
   _x allowDamage true;
   sleep 0.5;
} forEach units _group;
[_helicopter] call AS_fnc_toggleVehicleDoors;

private _wp4 = _group addWaypoint [_position, 0];
_wp4 setWaypointType "SAD";
