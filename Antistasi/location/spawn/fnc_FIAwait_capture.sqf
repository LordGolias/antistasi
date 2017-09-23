params ["_location"];
private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;

private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

private _fnc_was_captured = {
    (({(not(vehicle _x isKindOf "Air"))} count ([_size, _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance)) >
     3*({(alive _x) and !(captive _x) and (_x distance _posicion < _size)} count _soldados))
};

private _was_captured = false;
waitUntil {sleep 1;
    _was_captured = call _fnc_was_captured;
    (not (_location call AS_location_fnc_spawned)) or _was_captured
};

if _was_captured then {
    [_location] remoteExec ["AS_fnc_lose_location", 2];
};
