params ["_origin", "_destination", "_crew_group", "_marker"];

private _wp300 = _crew_group addWaypoint [_destination, 20];
_wp300 setWaypointSpeed "FULL";
_wp300 setWaypointType "SAD";

[leader _crew_group, _marker, "COMBAT", "SPAWNED", "NOFOLLOW"] spawn UPSMON;
