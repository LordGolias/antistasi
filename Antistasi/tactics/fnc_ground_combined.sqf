params ["_origin", "_destination", "_crew_group", "_marker", ["_threat", 0]];

private _safePosition = [_destination, _origin, _threat] call AS_fnc_getSafeRoadToUnload;
private _wp1 = _crew_group addWaypoint [_safePosition, 0];
_wp1 setWaypointType "UNLOAD";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "CARELESS";

_crew_group setVariable ["AS_patrol_marker", _marker, true];
private _statement = {
    [this, group this getVariable "AS_patrol_marker", "COMBAT", "SPAWNED", "NOFOLLOW"] spawn UPSMON;
};

_wp1 setWaypointStatements ["true", str _statement];
