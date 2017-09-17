private _position = _this call AS_location_fnc_position;

private _cities = [];

{
	private _positionOther = _x call AS_location_fnc_position;
	if (_positionOther distance _position < 3000 and _x != _this) then {
		_cities pushBack _x;
	};
} forEach (call AS_location_fnc_cities);

_cities
