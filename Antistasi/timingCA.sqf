#include "macros.hpp"
if (!isServer) exitWith{};

private _tiempo = _this select 0;

private _fb = ["base", "FIA"] call AS_fnc_location_TS;

if (count _fb > 0) then {
	if (count _fb == 1) then {
		_tiempo = _tiempo * 0.9;
	}
	else {
		if (count _fb == 2) then {
			_tiempo = _tiempo * 0.75;
		}
		else {
			if ((count _fb == 3) && (AS_P("skillAAF") < 10)) then {
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

if (_tiempo < 0) then {_tiempo = 0};

cuentaCA = cuentaCA + round (random _tiempo);

publicVariable "cuentaCA";
