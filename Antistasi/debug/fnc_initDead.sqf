params ["_thing"];
if not AS_debug_flag exitWith {};

private _mrk = createMarker [format ["AS_debug_flag_%1", count AS_debug_flag_all], position _thing];
AS_debug_flag_all pushBack _mrk;
_mrk setMarkerShape "ICON";
_mrk setMarkerType "KIA";
_mrk setMarkerColor "ColorRed";

[_thing, _mrk] spawn {
    params ["_thing", "_mrk"];
    private _sleep = 2 + 2*(random 100)/100;
    while {AS_debug_flag and _thing != objNull} do {
        sleep _sleep;
    };
    deleteMarker _mrk;
};
