params ["_vehGroup", "_origin", "_dest"];

private _dist = _origin distance2d _dest;
private _div = (floor (_dist / 150)) - 1;

private _x1 = _origin select 0;
private _y1 = _origin select 1;
private _x2 = _dest select 0;
private _y2 = _dest select 1;

private _x3 = (_x1 + _div*_x2) / (_div + 1);
private _y3 = (_y1 + _div*_y2) / (_div + 1);
private _z3 = 50;

private _approachPos = [_x3, _y3, _z3];

private _wp100 = _vehGroup addWaypoint [_approachPos, 50];
_wp100 setWaypointSpeed "FULL";
_wp100 setWaypointBehaviour "CARELESS";
