params ["_squadType", "_position", "_group"];
{
    [_x, _position, _group] call AS_fnc_spawnFIAUnit;
} forEach (["FIA", _squadType] call AS_fnc_getEntity);
