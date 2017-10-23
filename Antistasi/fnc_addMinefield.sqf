#include "macros.hpp"
AS_SERVER_ONLY("fnc_addMinefield.sqf");
params ["_position", "_side", ["_minesData", []]];

private _size = 100;

private _mrk = createMarker [format ["minefield%1", random 1000], _position];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [_size,_size];  // size of minefield
_mrk setMarkerAlpha 0;
[_mrk,"minefield", false] call AS_location_fnc_add;
[_mrk,"side",_side] call AS_location_fnc_set;

if (_minesData isEqualTo []) then {
    for "_i" from 1 to (30 + floor random 30) do {
        _minesData pushBack [selectRandom (["AAF", "ap_mines"] call AS_fnc_getEntity), ([_position, random _size, random 360] call BIS_Fnc_relPos), random 360];
    };
};
[_mrk,"mines",_minesData] call AS_location_fnc_set;
