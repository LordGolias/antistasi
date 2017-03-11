_c = _this select 0;
_d = _this select 1;

if (count _this > 2) then {
	for [{_i=1},{_i<=_d},{_i=_i+1}] do {
		_cL = "Chemlight_green" createVehicle (position _c);
		_cL attachTo [_c, [0,0,0]];
		_cS = "SmokeShellGreen" createVehicle (position _c);
		_cS attachTo [_c, [0,0,0]];
		sleep 30;
	};
}
else {
	for [{_i=1},{_i<=_d},{_i=_i+1}] do {
	_cS = "SmokeShellGreen" createVehicle (position _c);
	_cS attachTo [_c, [0,0,0]];
	sleep 30;
	};
};