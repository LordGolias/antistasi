/*
Converts a groupCfg to a list of 3 lists: [_types, _positions, _ranks]
*/
params ["_groupCfg"];

private _types = [];
private _positions = [];
private _ranks = [];
for "_i" from 0 to ((count _groupCfg) - 1) do {
    private _unit = _groupCfg select _i;

    if (isClass _unit) then {
        _types pushBack getText(_unit >> "vehicle");
        _ranks pushBack getText(_unit >> "rank");
        _positions pushBack getArray(_unit >> "position");
    };
};

[_types, _positions, _ranks]
