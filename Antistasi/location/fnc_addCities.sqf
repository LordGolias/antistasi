// Add cities from CfgWorld. Paramaters:
// - _excludeBelow: meters below which the city is ignored
// - _minSize: every city has at least this size by expanding it.
// - _excluded: list of city names to exclude
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_addCities");
params ["_excludeBelow", "_minSize", ["_excluded", []]];
{
    private _city = text _x;
    private _position = getPos _x;
    private _size = [_city, _minSize] call AS_location_fnc_getNameSize;
    if (_city != "" and !(_city in _excluded) and _size >= _excludeBelow) then {
        private _roads = [_position, _size] call AS_location_fnc_getCityRoads;

        if (count _roads != 0) then {
            // get population
            private _population = (count (nearestObjects [_position, ["house"], _size]));

            // adjust position to be in a road
            private _sortedRoads = [_roads, [], {_position distance _x}, "ASCEND"] call BIS_fnc_sortBy;
            _position = getPos (_sortedRoads select 0);

            // creates hidden marker
            private _mrk = createmarker [_city, _position];
            _mrk setMarkerSize [_size, _size];
            _mrk setMarkerShape "ELLIPSE";
            _mrk setMarkerBrush "SOLID";
            _mrk setMarkerColor "ColorGUER";
            [_mrk, "city"] call AS_location_fnc_add;

            // stores everything
            [_city, "population", _population] call AS_location_fnc_set;
            [_city, "roads", _roads] call AS_location_fnc_set;
        };
    };
} forEach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"),
    ["NameCityCapital","NameCity","NameVillage","CityCenter"], 25000]);
