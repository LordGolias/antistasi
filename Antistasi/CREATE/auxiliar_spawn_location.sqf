AS_spawn_fnc_FIAlocation_run = {
    params ["_location"];
    private _posicion = _location call AS_fnc_location_position;
    private _size = _location call AS_fnc_location_size;

    private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

    waitUntil {sleep 1;
    	(not (_location call AS_fnc_location_spawned)) or
    	(({not(vehicle _x isKindOf "Air")} count ([_size, _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance)) >
    	 3*(({alive _x} count _soldados) + count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance)))};

    if (_location call AS_fnc_location_spawned) then {
    	[_location] remoteExec ["AS_fnc_location_lose", 2];
    };
};

AS_spawn_fnc_FIAlocation_clean = {
    params ["_location"];
    private _posicion = _location call AS_fnc_location_position;
	private _size = _location call AS_fnc_location_size;

    private _soldadosFIA = [_location, "FIAsoldiers"] call AS_spawn_fnc_get;

    waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};

    private _buildings = nearestObjects [_posicion, AS_destroyable_buildings, _size*1.5];
	[_buildings] remoteExec ["AS_fnc_updateDestroyedBuildings", 2];

    {
        if (_location call AS_fnc_location_side == "FIA") then {
            ([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
            [caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
        };
        if (alive _x) then {
            deleteVehicle _x;
        };
    } forEach _soldadosFIA;

    ([_location, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
    [_groups, _vehicles, _markers] call AS_fnc_cleanResources;
};

AS_spawn_fnc_AAFwait_capture = {
    params ["_location"];
    private _posicion = _location call AS_fnc_location_position;
    private _size = _location call AS_fnc_location_size;

    private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

    waitUntil {sleep 1;
        (not (_location call AS_fnc_location_spawned)) or
        (({(not(vehicle _x isKindOf "Air"))} count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance)) >
         3*({(alive _x) and !(captive _x) and (_x distance _posicion < _size)} count _soldados))
    };

    if (_location call AS_fnc_location_spawned) then {
        [_location] remoteExec ["AS_fnc_location_win",2];
    };
};

AS_spawn_fnc_AAFlocation_clean = {
    params ["_location"];
	waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};

	private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

	{
		// store unit arsenal if location is FIA and unit is dead (store dead AAF units)
		if ((_location call AS_fnc_location_side == "FIA") and !alive _x) then {
			([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
			[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
		};
		if (alive _x) then {
			deleteVehicle _x;
		};
	} forEach _soldados;

	([_location, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
};
