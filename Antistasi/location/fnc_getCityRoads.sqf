params ["_position", "_size"];

private _roads = [];
{
    private _roadcon = roadsConnectedto _x;
    if (count _roadcon == 2) then {
        _roads pushBack _x;
    };
} forEach (_position nearRoads _size);
_roads
