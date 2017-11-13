params ["_location"];
private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;

private _soldadosFIA = [_location, "FIAsoldiers"] call AS_spawn_fnc_get;

waitUntil {sleep 1; not (_location call AS_location_fnc_spawned)};

private _buildings = nearestObjects [_posicion, AS_destroyable_buildings, _size*1.5];
[_buildings] remoteExec ["AS_fnc_updateDestroyedBuildings", 2];

{
    if (_location call AS_location_fnc_side == "FIA") then {
        ([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
        [caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
    };
    if (alive _x) then {
        deleteVehicle _x;
    };
} forEach _soldadosFIA;

([_location, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
