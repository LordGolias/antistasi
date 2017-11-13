#include "../macros.hpp"
params ["_veh"];
if not AS_debug_flag exitWith {};

private _mrk = createMarker [format ["AS_debug_flag_%1", count AS_debug_flag_all], position _veh];
AS_debug_flag_all pushBack _mrk;

_mrk setMarkerSize [5, 10];
_mrk setMarkerShape "RECTANGLE";

[_veh, _mrk] spawn {
    params ["_veh", "_mrk"];
    private _sleep = 1 + (random 100)/100; // so it is not called at the same time to a whole group
    while {AS_debug_flag and alive _veh} do {
        private _color = "ColorGreen";
        if (_veh getVariable ["inDespawner", false]) then {
            _color = "ColorRed";
            if ((_veh in AS_P("vehicles")) or {_veh distance getMarkerPos "FIA_HQ" < 50}) then {
                _color = "ColorBlack";
            };
        };
        _mrk setMarkerColor _color;
        _mrk setMarkerDir (getDir _veh);
        _mrk setMarkerPos position _veh;
        sleep _sleep;
    };
    deleteMarker _mrk;
};
