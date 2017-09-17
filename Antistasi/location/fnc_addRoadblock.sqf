#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_addRoadblock");
params ["_location", "_position"];
private _name = format ["roadblock_%1_%2", round (_position select 0), round (_position select 1)];
private _roadblock = createMarker [_name, _position];
[_roadblock, "roadblock"] call AS_location_fnc_add;
[_roadblock, "location", _location] call AS_location_fnc_set;
_roadblock
