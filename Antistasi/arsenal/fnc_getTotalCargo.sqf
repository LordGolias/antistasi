params ["_cargo"];

private _total = 0;
for "_i" from 0 to (count (_cargo select 0) - 1) do {
    _total = _total + ((_cargo select 1) select _i);
};
_total
