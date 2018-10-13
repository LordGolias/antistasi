params ["_location"];

private _pos = _location call AS_location_fnc_position;
private _cuenta = 0;
while {({(_x distance _pos < 300) and (side _x == ("NATO" call AS_fnc_getFactionSide))} count allUnits == 0) and (_cuenta < 50)} do {
	_cuenta = _cuenta + 1;
	sleep (5 + random 5);

	// drop a shell
	private _shell1 = "Sh_82mm_AMOS" createVehicle [_pos select 0 + (150 - (random 300)),_pos select 1 + (150 - (random 300)),200];
	_shell1 setVelocity [0,0,-50];
};
