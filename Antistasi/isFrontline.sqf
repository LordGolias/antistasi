#include "macros.hpp"
private ["_marcador","_isfrontier","_posicion"];

_marcador = _this select 0;
_isfrontier = false;

_mrkFIA = aeropuertos + bases + puestos - mrkAAF;

if (count _mrkFIA > 0) then
	{
	_posicion = getMarkerPos _marcador;
	{if (_posicion distance (getMarkerPos _x) < AS_P("spawnDistance")) exitWith {_isFrontier = true}} forEach _mrkFIA;
	};

_isfrontier