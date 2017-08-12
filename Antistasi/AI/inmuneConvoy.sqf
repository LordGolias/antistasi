params ["_veh","_text"];

waitUntil {sleep 5; (alive _veh) and !(isNull driver _veh)};
private _side = side (driver _veh);

while {(alive _veh) and (side (driver _veh) == _side)} do {
	private _pos = getPos _veh;
	sleep 60;
	private _newPos = getPos _veh;
	// in case it stopped, give vehicles a nodge to continue
	if (_newPos distance _pos < 5 and {{_x distance _newPos < 500} count (allPlayers - hcArray) == 0}) then {
		private _road = [_newPos,100] call BIS_fnc_nearestRoad;
		if (!isNull _road) then {
			_veh setPos getPos _road;
		};
	};
};
