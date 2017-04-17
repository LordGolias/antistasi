params ["_location", "_onoff"];
private ["_damage","_lamps","_onoff","_posicion","_tam","_size"];

private _posicion = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;

private _damage = 0;
if (not _onoff) then {_damage = 0.95;};

for "_i" from 0 to ((count lamptypes) -1) do {
    _lamps = _posicion nearObjects [lamptypes select _i,_size];
    {sleep 0.3; _x setDamage _damage} forEach _lamps;
};
