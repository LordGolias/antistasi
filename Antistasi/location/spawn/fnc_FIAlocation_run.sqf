params ["_location"];
private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;

private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

waitUntil {sleep 1;
    (not (_location call AS_location_fnc_spawned)) or
    (({not(vehicle _x isKindOf "Air")} count ([_size, _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance)) >
     3*(({alive _x} count _soldados) + count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance)))};

if (_location call AS_location_fnc_spawned) then {
    [_location] remoteExec ["AS_fnc_lose_location", 2];
};
