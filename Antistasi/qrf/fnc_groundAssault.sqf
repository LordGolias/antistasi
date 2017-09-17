params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroup", "_duration"];

if (typeName _infGroup == "STRING") then {
    _dest = [_dest, _origin, -20] call AS_fnc_getSafeRoadToUnload;
    private _wp200 = _vehGroup addWaypoint [_dest, 0];
    _wp200 setWaypointSpeed "FULL";
    _wp200 setWaypointBehaviour "CARELESS";
    _wp200 setWaypointType "TR UNLOAD";
    private _wp300 = _infGroup addWaypoint [_dest, 0];
    _wp300 setWaypointType "GETOUT";
    _wp300 synchronizeWaypoint [_wp200];
    private _wp301 = _infGroup addWaypoint [_mrk, 0];
    _wp301 setWaypointType "SAD";
    _wp301 setWaypointBehaviour "COMBAT";
    _infGroup setCombatMode "RED";
} else {
    private _wp300 = _vehGroup addWaypoint [_dest, 20];
    _wp300 setWaypointSpeed "FULL";
    _wp300 setWaypointBehaviour "CARELESS";
    _wp300 setWaypointType "SAD";

    waitUntil {sleep 5; ((units _vehGroup select 0) distance _dest < 50) || ({alive _x} count units _vehGroup == 0)};
};

[leader _vehGroup, _mrk, "COMBAT", "SPAWNED", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
sleep _duration;

[_vehGroup, _origin] spawn AS_QRF_fnc_RTB;
if (!isNil "_infGroup") then {
    [_infGroup, _origin] spawn AS_QRF_fnc_RTB;
};
