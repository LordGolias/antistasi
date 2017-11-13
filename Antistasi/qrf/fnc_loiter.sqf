params ["_vehGroup", "_origin", "_dest", "_radius", "_duration"];

private _wp101 = _vehGroup addWaypoint [_dest, 50];
_wp101 setWaypointType "LOITER";
_wp101 setWaypointLoiterType "CIRCLE";
_wp101 setWaypointLoiterRadius _radius;
_wp101 setWaypointCombatMode "YELLOW";
_wp101 setWaypointSpeed "LIMITED";

sleep _duration;
[_vehGroup, _origin] spawn AS_QRF_fnc_RTB;
