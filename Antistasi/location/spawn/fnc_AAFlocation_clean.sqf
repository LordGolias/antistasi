params ["_location"];
waitUntil {sleep 1; not (_location call AS_location_fnc_spawned)};

private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

{
    // store unit arsenal if location is FIA and unit is dead (store dead AAF units)
    if ((_location call AS_location_fnc_side == "FIA") and !alive _x) then {
        ([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
        [caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
    };
    if (alive _x) then {
        deleteVehicle _x;
    };
} forEach _soldados;

([_location, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
