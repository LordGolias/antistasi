private ["_veh","_puertas"];
_veh = _this select 0;

if (!alive _veh) exitWith {};
_puertas = [];

if (count _puertas == 0) exitWith {};

if (count _this > 1) then
	{
	sleep 30;
	waitUntil {sleep 1; (!alive _veh) or (speed _veh < 5)};
	};


{
waitUntil {(!alive _veh) or (_veh doorPhase _x == 0) or (_veh doorPhase _x == 1)}
} forEach _puertas;

if (!alive _veh) exitWith {};

_fase = _veh doorPhase (_puertas select 0);

if (_fase == 0) then {_fase = 1} else {_fase = 0};

{
_veh animateDoor [_x,_fase,false];
} forEach _puertas;

{
waitUntil {(!alive _veh) or (_veh doorPhase _x == 0) or (_veh doorPhase _x == 1)}
} forEach _puertas;

if (count _this > 1) then
	{
	waitUntil {sleep 1; (!alive _veh) or (speed _veh > 5)};
	if (alive _veh) then
		{
		{
		waitUntil {(!alive _veh) or (_veh doorPhase _x == 0) or (_veh doorPhase _x == 1)}
		} forEach _puertas;

		if (!alive _veh) exitWith {};

		_fase = _veh doorPhase (_puertas select 0);

		if (_fase == 0) then {_fase = 1} else {_fase = 0};

		{
		_veh animateDoor [_x,_fase,false];
		} forEach _puertas;
		};
	};
