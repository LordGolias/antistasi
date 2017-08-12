if (!isServer) exitWith{};
params ["_location"];

private _pos = _location call AS_fnc_location_position;
private _cuenta = 0;
while {({(_x distance _pos < 300) and (side _x == side_blue)} count allUnits == 0) and (_cuenta < 50) and (not(_location call AS_fnc_location_forced_spawned))} do {
	_cuenta = _cuenta + 1;
	sleep (5 + random 5);
	private _shell1 = "Sh_82mm_AMOS" createVehicle [_pos select 0 + (150 - (random 300)),_pos select 1 + (150 - (random 300)),200];
	_shell1 setVelocity [0,0,-50];
};
