#include "../macros.hpp"
params ["_unit"];
if not AS_debug_flag exitWith {};

private _mrk = createMarker [format ["AS_debug_flag_%1", count AS_debug_flag_all], position _unit];
AS_debug_flag_all pushBack _mrk;

private _color = "ColorUNKNOWN";
private _type = "c_unknown";
switch (_unit call AS_fnc_getSide) do {
    case "AAF": {
        _color = "ColorOPFOR";
        _type = "o_inf";
    };
    case "CSAT": {
        _color = "ColorOPFOR";
        _type = "o_inf";
    };
    case "FIA": {
        _color = "ColorGUER";
        _type = "o_inf";
    };
    case "NATO": {
        _color = "colorBLUFOR";
        _type = "b_inf";
    };
    case "CIV": {
        _color = "ColorCIV";
        _type = "c_unknown";
    };
};
_mrk setMarkerShape "ICON";
_mrk setMarkerType _type;
_mrk setMarkerColor _color;
_mrk setMarkerText (typeOf _unit);

[_unit, _mrk] spawn {
    params ["_unit", "_mrk"];
    private _sleep = 2 + 2*(random 100)/100; // so it is not called at the same time to a whole group
    while {AS_debug_flag and alive _unit} do {
        _mrk setMarkerPos position _unit;
        sleep _sleep;
    };
    deleteMarker _mrk;
};
