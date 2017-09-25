/*
	Given an origin, destination and a threat level, it computes the closest road's position
	from the origin that is close to the destination (threat increases how close it is)
*/
params ["_destination", "_origin", "_threat"];

private _tam = 400 + (10*_threat);
private _dif = (_destination select 2) - (_origin select 2);

// if going uphill, increase the max distance
if (_dif > 0) then {
	_tam = _tam + (_dif * 2);
};

private _roads = [];
while {count _roads != 0} do {
	_roads = _destination nearRoads _tam;
	_tam = _tam + 50;
};

// compute road closest to origin
private _road = objNull;
private _minDistance = 1000000; // simulate infinity
{
	private _distance = _origin distance (position _x);
	if (_distance < _minDistance) then {
		_minDistance = _distance;
		_road = _x;
	};
} forEach _roads;

position _road
