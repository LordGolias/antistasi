params ["_origin", "_destination", "_crew_group", "_cargo_group", "_threat"];

{
	_x disableAI "TARGET";
	_x disableAI "AUTOTARGET"
} foreach units group driver _crew_group;

private _distance = 400 + (10*_threat);

private _startDropPosition = [];
private _midDropPosition = [];

private _randang = random 360;

// find a position within distance from the target
private _midDropPosition = [_destination, _distance, _randang] call BIS_Fnc_relPos;
while {surfaceIsWater _midDropPosition} do {
	_randang = random 360;
 	_midDropPosition = [_destination, _distance, _randang] call BIS_Fnc_relPos;
};

_randang = _randang + 90;

private _endDropPosition = [_destination, 400, _randang] call BIS_Fnc_relPos;
while {surfaceIsWater _endDropPosition or _endDropPosition distance _destination < 300} do {
 	_endDropPosition = [_destination, 400, _randang] call BIS_Fnc_relPos;
 	_randang = _randang + 5;
 	if ((!surfaceIsWater _endDropPosition) and (_endDropPosition distance _destination > 300)) exitWith {};
};

_randang = ([_midDropPosition,_endDropPosition] call BIS_fnc_dirTo) - 180;

_startDropPosition = [_midDropPosition, 1000, _randang] call BIS_Fnc_relPos;

{_x setBehaviour "CARELESS"} forEach units _crew_group;
_crew_group flyInHeight (150+(20*_threat));

private _wp = _crew_group addWaypoint [_startDropPosition, 0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";

private _wp1 = _crew_group addWaypoint [_midDropPosition, 1];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "LIMITED";

private _wp2 = _crew_group addWaypoint [_endDropPosition, 2];
_wp2 setWaypointType "MOVE";

private _wp3 = _crew_group addWaypoint [_origin, 3];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];

waitUntil {sleep 1; (currentWaypoint _crew_group == 3) or {not alive _crew_group}};

if not alive _crew_group exitWith {};

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
} forEach units _cargo_group;

private _wp4 = _cargo_group addWaypoint [_destination, 0];
_wp4 setWaypointType "SAD";
