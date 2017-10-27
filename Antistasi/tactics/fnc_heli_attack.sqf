params ["_origin", "_destination", "_crew_group"];

private _wp1 = _crew_group addWaypoint [_destination, 1];
_wp1 setWaypointType "SAD";
_wp1 setWaypointBehaviour "COMBAT";
