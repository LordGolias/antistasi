// Returns [cost,HR] of the squad type.
params ["_type"];
private _config = [_type] call AS_fnc_getFIASquadConfig;

private _cost = 0;
private _hr = 0;
for "_i" from 0 to (count _config) - 1 do {
    private _item = _config select _i;
    if (isClass _item) then {
        private _unitName = [getText(_item >> "vehicle")] call AS_fnc_getFIAUnitNameType;
        _cost = _cost + (AS_data_allCosts getVariable _unitName);
        _hr = _hr + 1;
    };
};
[_cost, _hr]
