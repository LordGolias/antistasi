#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQdeploy.sqf");

private _basePos = [position petros, 3, getDir petros] call BIS_Fnc_relPos;
private _pos = +_basePos;
fuego setPos _pos;
private _rnd = getdir Petros;
_pos = [_basePos, 3, _rnd] call BIS_Fnc_relPos;
caja setPos _pos;
_rnd = _rnd + 45;
_pos = [_basePos, 3, _rnd] call BIS_Fnc_relPos;
mapa setPos _pos;
mapa setDir ([fuego, mapa] call BIS_fnc_dirTo);
_rnd = _rnd + 45;
_pos = [_basePos, 3, _rnd] call BIS_Fnc_relPos;
bandera setPos _pos;
_rnd = _rnd + 45;
_pos = [_basePos, 3, _rnd] call BIS_Fnc_relPos;
cajaVeh setPos _pos;
