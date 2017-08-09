params ["_location", "_onoff"];

private _position = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;

private _damage = 0;
if (not _onoff) then {_damage = 0.95;};

for "_i" from 0 to ((count lamptypes) -1) do {
    private _lamps = _position nearObjects [lamptypes select _i,_size];
    {sleep 0.5; _x setDamage _damage} forEach _lamps;
};
