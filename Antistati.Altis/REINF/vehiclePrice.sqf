private ["_tipo","_coste"];

_tipo = _this select 0;

if (isNil {_tipo}) exitWith {};

_coste = server getVariable _tipo;

if (isNil "_coste") then {
	call {
		if ((_tipo in vehTrucks) or (_tipo in vehPatrol) or (_tipo in vehSupply)) exitWith {_coste = 300};
		if (_tipoVeh in vehAPC) exitWith {_coste = 1000};
		if (_tipoVeh in vehIFV) exitWith {_coste = 2000};
		if (_tipoVeh in vehTank) exitWith {_coste = 5000};
		if (_tipoveh == "C_Van_01_fuel_F") exitWith {_coste = 50};
		if (_tipoVeh in arrayCivVeh) exitWith {_coste = 25};

		_coste = 0;
		diag_log format ["Antistasi: Error en vehicle prize con este: %1",_tipo];
		};
	}
else
	{
	//_coste = _coste + (_coste * ({_x in mrkAAF} count puertos));
	_coste = round (_coste - (_coste * (0.1 * ({_x in mrkFIA} count puertos))));
	};

_coste