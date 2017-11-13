params ["_position", ["_ignoreRadio", false]];

// get closest airfield within some conditions
private _airfield = "";
private _closestDistance = 10000;
{
    private _busy = _x call AS_location_fnc_busy;
    private _pos = _x call AS_location_fnc_position;
    private _radio = true;
    if (!_ignoreRadio) then {_radio = _pos call AS_fnc_hasRadioCoverage};
    if (_position distance _pos < _closestDistance and
        _position distance _pos > 2000 and
        !(_x call AS_location_fnc_spawned) and !_busy and _radio) then {
            _airfield = _x;
            _closestDistance = _position distance _pos;
    };
} forEach (["airfield", "AAF"] call AS_location_fnc_TS);

_airfield
