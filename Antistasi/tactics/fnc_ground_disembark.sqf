params ["_origin", "_destination", "_crew_group", "_marker", "_cargo_group"];

if (typeName _cargo_group == "STRING") then {
    _destination = [_destination, _origin, -20] call AS_fnc_getSafeRoadToUnload;
    private _wp200 = _crew_group addWaypoint [_destination, 0];
    _wp200 setWaypointSpeed "FULL";
    _wp200 setWaypointBehaviour "CARELESS";
    _wp200 setWaypointType "TR UNLOAD";
    private _wp300 = _cargo_group addWaypoint [_destination, 0];
    _wp300 setWaypointType "GETOUT";
    _wp300 synchronizeWaypoint [_wp200];
    private _wp301 = _cargo_group addWaypoint [_marker, 0];
    _wp301 setWaypointType "SAD";
    _wp301 setWaypointBehaviour "COMBAT";
    _cargo_group setCombatMode "RED";
} else {
    private _wp300 = _crew_group addWaypoint [_destination, 20];
    _wp300 setWaypointSpeed "FULL";
    _wp300 setWaypointBehaviour "CARELESS";
    _wp300 setWaypointType "SAD";

    waitUntil {sleep 5;
        ((units _crew_group select 0) distance _destination < 50) ||
        {{alive _x} count units _crew_group == 0}};
};

[leader _crew_group, _marker, "COMBAT", "SPAWNED", "NOFOLLOW"] spawn UPSMON;
