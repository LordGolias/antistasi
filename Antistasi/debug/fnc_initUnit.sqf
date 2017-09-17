#include "../macros.hpp"
params ["_unit"];
if not AS_debug_flag exitWith {};

private _mrk = createMarker [format ["AS_debug_flag_%1", count AS_debug_flag_all], position _unit];
AS_debug_flag_all pushBack _mrk;

private _color = "ColorUNKNOWN";
private _type = "c_unknown";
switch (side _unit) do {
    case side_red: {
        _color = "ColorOPFOR";
        _type = "o_inf";
    };
    case side_blue: {
        _color = "ColorWEST";
        _type = "b_inf";
    };
    case civilian: {
        _color = "ColorCIV";
        _type = "c_unknown";
    }
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
