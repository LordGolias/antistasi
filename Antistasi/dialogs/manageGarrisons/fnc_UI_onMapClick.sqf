private _location = _this call AS_location_fnc_nearest;
private _side = _location call AS_location_fnc_side;
private _position = _location call AS_location_fnc_position;
if (_side != "FIA") exitWith {hint "This zone does not belong to FIA";};
if (_position distance _this > 200) exitWith {hint "You must click near a marked zone";};
map_location = _location;
