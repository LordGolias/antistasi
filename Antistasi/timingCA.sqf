if (!isServer) exitWith{};

_tiempo = _this select 0;

_fb = bases - mrkAAF;
diag_log format ["timingCA -- number of bases: %1", count _fb];


if (count _fb > 0) then {
	if (count _fb == 1) then {
		_tiempo = _tiempo * 0.9;
	}
	else {
		if (count _fb == 2) then {
			_tiempo = _tiempo * 0.75;
		}
		else {
			if ((count _fb == 3) && (skillAAF < 10)) then {
			_tiempo = _tiempo * 0.5;
			}
			else {
				if (count _fb > 3) then {
					_tiempo = _tiempo * 0.3;
				};
			};
		};
	};
};

diag_log format ["timingCA -- number: %1", _tiempo];

if (_tiempo < 0) then {_tiempo = 0};

cuentaCA = cuentaCA + round (random _tiempo);

publicVariable "cuentaCA";

diag_log format ["timer changed: %1", cuentaCA];



/*
_inc = lastIncome;
_em = server getVariable "easyMode";
if (_em) then {_inc = _inc / 2};
_tiempo = _tiempo - (_inc) - (50*(count (mrkFIA - puestosFIA)));
*/