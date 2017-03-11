private ["_pos","_rnd"];
_movido = false;
if (group petros != grupoPetros) then
	{
	_movido = true;
	[petros] join grupoPetros;
	};
[[petros,"remove"],"flagaction"] call BIS_fnc_MP;
petros forceSpeed 0;
"respawn_west" setMarkerPos getPos petros;
"FIA_HQ" setMarkerPos getPos petros;
posHQ = getMarkerPos "respawn_west"; publicVariable "posHQ";

if (isMultiplayer) then
	{
	caja hideObjectGlobal false;
	cajaVeh hideObjectGlobal false;
	mapa hideObjectGlobal false;
	fuego hideObjectGlobal false;
	bandera hideObjectGlobal false;
	}
else
	{
	if (_movido) then {hint "Please wait while moving HQ Assets to selected position"};
	//sleep 5
	caja hideObject false;
	cajaVeh hideObject false;
	mapa hideObject false;
	fuego hideObject false;
	bandera hideObject false;
	};
fuego inflame true;
"respawn_west" setMarkerAlpha 1;
_pos = [getPos petros, 3, getDir petros] call BIS_Fnc_relPos;
fuego setPos _pos;
_rnd = getdir Petros;
if (isMultiplayer) then {sleep 5};
_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
caja setPos _pos;
_rnd = _rnd + 45;
_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
mapa setPos _pos;
mapa setDir ([fuego, mapa] call BIS_fnc_dirTo);
_rnd = _rnd + 45;
_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
bandera setPos _pos;
_rnd = _rnd + 45;
_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
cajaVeh setPos _pos;
if (_movido) then {[] call vaciar};
placementDone = true; publicVariable "placementDone";
sleep 5;
[[Petros,"mission"],"flagaction"] call BIS_fnc_MP;
//[] remoteExec ["petrosAnimation", 2];