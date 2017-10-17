params ["_origin", "_destination", "_crew_group", "_cargo_group"];

private _vehicles = [];

// between 300m and 500m from destination, 10x10, max 0.3 sloop
private _landing_position = [_destination, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
_landing_position set [2, 0];

private _pad = createVehicle ["Land_HelipadEmpty_F", _landing_position, [], 0, "NONE"];
_vehicles pushBack _pad;
private _wp0 = _crew_group addWaypoint [_landing_position, 0];
_wp0 setWaypointType "TR UNLOAD";
_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call AS_AI_fnc_activateSmokeCover"];
[_crew_group,0] setWaypointBehaviour "CARELESS";
private _wp3 = _cargo_group addWaypoint [_landing_position, 0];
_wp3 setWaypointType "GETOUT";
_wp0 synchronizeWaypoint [_wp3];
private _wp4 = _cargo_group addWaypoint [_destination, 1];
_wp4 setWaypointType "SAD";
private _wp2 = _crew_group addWaypoint [_origin, 1];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
[_crew_group,1] setWaypointBehaviour "AWARE";

_vehicles
