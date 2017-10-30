/*
Spawns a group in a vehicle taking into account the number of seats available
*/
params ["_groupComposition", "_group", "_position", ["_maxUnits", 20]];

_groupComposition params ["_types", "_positions", "_ranks"];

for "_i" from 0 to ((count _types min _maxUnits) - 1) do {
    private _relPos = _positions select _i;
    private _unitPos = [(_position select 0) + (_relPos select 0), (_position select 1) + (_relPos select 1)];
    private _type = _types select _i;
    private _rank = _ranks select _i;

    private _unit = _group createUnit [_type, _unitPos, [], 0, "NONE"];
    [_unit, _rank] call bis_fnc_setRank;
    [_unit] joinsilent _group;
};

_group
