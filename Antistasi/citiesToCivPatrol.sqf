private _position = _this call AS_fnc_location_position;

private _cities = [];

{
	private _positionOther = _x call AS_fnc_location_position;
	if (_positionOther distance _position < 3000 and _x != _this) then {
		_cities pushBack _x;
	};
} forEach (call AS_fnc_location_cities);

_cities
