params ["_position", "_marker"];

private _vehicles = [];
private _groups = [];

if (count (["CSAT", "uavs_small"] call AS_fnc_getEntity) != 0) then {
    private _uavType = selectRandom (["CSAT", "uavs_small"] call AS_fnc_getEntity);
    private _uav = createVehicle [_uavType, _position, [], 0, "FLY"];
    [_uav, "CSAT"] call AS_fnc_initVehicle;
    _vehicles pushBack _uav;
    createVehicleCrew _uav;
    private _grupoUAV = group (crew _uav select 1);
    [leader _grupoUAV, _marker, "SAFE", "SPAWNED","NOVEH", "NOFOLLOW"] spawn UPSMON;
    [_uav,"CSAT"] call AS_fnc_initVehicle;
    {_x call AS_fnc_initUnitCSAT;} forEach units _grupoUAV;
    _groups pushBack _grupoUAV;
};

[_groups, _vehicles]
