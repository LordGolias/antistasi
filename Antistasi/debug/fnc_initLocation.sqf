params ["_location"];
if not AS_debug_flag exitWith {};

private _mrk = createMarker [format ["AS_debug_flag_%1", count AS_debug_flag_all], _location call AS_location_fnc_position];
AS_debug_flag_all pushBack _mrk;
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [50, 50];
_mrk setMarkerColor "ColorBlue";
_mrk setMarkerAlpha 0.8;

[_location, _mrk] spawn {
    params ["_location", "_mrk"];
    private _sleep = 2 + 2*(random 100)/100;
    while {AS_debug_flag} do {
        if (_location call AS_location_fnc_forced_spawned) then {
                _mrk setMarkerColor "ColorRed";
            } else {
                if (_location call AS_location_fnc_spawned) then {
                    _mrk setMarkerColor "ColorGreen";
                } else {
                    _mrk setMarkerColor "ColorBlue";
                };
            };
        sleep _sleep;
    };
    deleteMarker _mrk;
};
