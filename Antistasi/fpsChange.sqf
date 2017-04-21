#include "macros.hpp"
AS_SERVER_ONLY("fpsChange.sqf");

_cambio = _this select 0;

_cambio = _cambio + AS_P("minimumFPS");

if (_cambio < 0) then {_cambio = 0};

_media = fpsTotal / fpsCuenta;
_texto = "";

if ((_cambio > _media * 0.6) and (_media > 24)) then
	{
	_cambio = round (_media * 0.6);
	_texto = format ["FPS limit set to %2.\n\nAverage FPS on server is %1, a higher limit may stop civilian spawning.",_media, _cambio];
	}
else
	{
	_texto = format ["FPS limit set to %2.\n\nAverage FPS on server is %1.",_media, _cambio];
	};
AS_Pset("minimumFPS", _cambio);

[[petros,"hint",_texto],"commsMP"] call BIS_fnc_MP;
