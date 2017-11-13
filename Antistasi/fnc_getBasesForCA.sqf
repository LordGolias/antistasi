params ["_position", ["_ignoreRadio", false]];

// get closest airfield within some conditions
private _base = "";
private _closestDistance = 5000;
{
    private _busy = _x call AS_location_fnc_busy;
    private _pos = _x call AS_location_fnc_position;
    private _radio = true;
    if (!_ignoreRadio) then {_radio = _pos call AS_fnc_hasRadioCoverage};
    if ((_radio and _position distance _pos < _closestDistance or
		_position distance _pos < 2000) and
        !(_x call AS_location_fnc_spawned) and !_busy) then {
        _base = _x;
        _closestDistance = _position distance _pos;
    };
} forEach (["base", "AAF"] call AS_location_fnc_TS);

_base
