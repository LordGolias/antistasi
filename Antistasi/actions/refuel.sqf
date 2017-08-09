params ["_pos"];

{
	if (_x distance _pos < 30) then {
		_x setFuel 0.8;
	};
} forEach vehicles;
