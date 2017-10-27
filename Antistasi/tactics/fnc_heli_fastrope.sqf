params ["_origin", "_destination", "_crew_group", "_patrol_marker", "_cargo_group", ["_threat", 0]];

private _safePosition = [_destination, (100 + 10*_threat) min 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
private _wp1 = _crew_group addWaypoint [_safePosition, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "CARELESS";

_crew_group setVariable ["AS_cargo_group", _cargo_group, true];
private _statement = {
    private _veh = vehicle this;
    if not alive _veh exitWith {};
    private _cargo_group = group this getVariable "AS_cargo_group";
    private _ropping = _cargo_group spawn SHK_Fastrope_fnc_AIs;
    waitUntil {scriptDone _ropping};
};
_wp1 setWaypointStatements ["true", str _statement];

private _wp2 = _cargo_group addWaypoint [_safePosition, 0];
_wp2 setWaypointType "MOVE";

_cargo_group setVariable ["AS_patrol_marker", _patrol_marker, true];
private _statement = {
    [this, group this getVariable "AS_patrol_marker", "COMBAT", "SPAWNED", "NOFOLLOW"] spawn UPSMON;
};
_wp2 setWaypointStatements ["true", str _statement];

// send the helicopter home
_crew_group addWaypoint [_origin, 0];
