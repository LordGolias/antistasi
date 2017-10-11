// Returns [cost,HR] of the squad type.
params ["_type"];
private _cost = 0;
private _hr = 0;
{
    _cost = _cost + (AS_data_allCosts getVariable _x);
    _hr = _hr + 1;
} forEach (["FIA", _type] call AS_fnc_getEntity);
[_cost, _hr]
