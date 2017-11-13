// Initializes hills from CfgWorlds.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_addHills");
params ["_minSize", ["_excluded", []], ["_hillsAA", []]];
{
    private _hill = text _x;
    private _position = getPos _x;
    private _size = [_hill, _minSize] call AS_location_fnc_getNameSize;
    if !((_hill in _excluded) or {_position in _excluded}) then {
        // creates hidden marker
        private _name = _hill;
        if (_hill == "") then {
            _name = format ["hill_%1", _position];
        };
        private _mrk = createmarker [_name, _position];
        _mrk setMarkerSize [_size, _size];
        _mrk setMarkerShape "ELLIPSE";
        _mrk setMarkerBrush "SOLID";
        _mrk setMarkerColor "ColorRed";
        if (_hill in _hillsAA) then {
            [_mrk, "hillAA"] call AS_location_fnc_add;
        } else {
            [_mrk, "hill"] call AS_location_fnc_add;
        };
    };
} foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"),
    ["Hill"], 25000]);
