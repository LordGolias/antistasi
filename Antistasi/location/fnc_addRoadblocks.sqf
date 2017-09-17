#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_addRoadblocks");
params ["_location", ["_max", 3]];

private _type = _location call AS_location_fnc_type;
if not (_type in ["powerplant", "base", "airfield", "resource", "factory",
             "seaport", "outpost"]) exitWith {};

private _position = _location call AS_location_fnc_position;

private _count = 0;
private _controlPoints = ("roadblock" call AS_location_fnc_T);
{
    private _otherPosition = _x call AS_location_fnc_position;
    if (_otherPosition distance _position < 1000) then {
        _count = _count + 1;
    };
} forEach _controlPoints;

// iterates randomly through all roads within 500m to add roadblocks
// adds a roadblock to a road when it:
// 	- is between [400,500] meters
// 	- has no roadblocks within 500 meters
// 	- has two connected roads
// it stops when there are 3 roadblocks
private _roads = _position nearRoads 500;
while {count _roads > 0 and _count < _max} do {
    private _road = selectRandom _roads;
    _roads = _roads - [_road];
    private _posroad = getPos _road;

    if (_posroad distance _position > 400 and {count roadsConnectedto _road > 1}) then {
        private _otherLocation = [_controlPoints, _posroad] call BIS_fnc_nearestPosition;
        if (_otherLocation isEqualType "") then {
            private _otherPosition = _otherLocation call AS_location_fnc_position;
            if (_otherPosition distance _posroad > 500) then {
                private _marker = [_location, _posroad] call AS_location_fnc_addRoadblock;
                _count = _count + 1;
                _controlPoints pushBack _marker;
            };
        };
    };
};
