#include "../macros.hpp"
params ["_marcador", "_grupos"];

private _size = [_marcador] call sizeMarker;

private _journalist = objNull;
if ((random 100 < ((AS_P("prestigeNATO") + AS_P("prestigeCSAT"))/10)) and (spawner getVariable _marcador)) then {
	_pos = [];
	_grupo = createGroup civilian;
	while {true} do {
		_pos = [getMarkerPos _marcador, round (random _size), random 360] call BIS_Fnc_relPos;
		if (!surfaceIsWater _pos) exitWith {};
	};
	_journalist = _grupo createUnit ["C_journalist_F", _pos, [],0, "NONE"];
	[_journalist] spawn CIVinit;
	_grupos pushBack _grupo;
	[_journalist, _marcador, "SAFE", "SPAWNED","NOFOLLOW", "NOVEH2","NOSHARE","DoRelax"] execVM "scripts\UPSMON.sqf";
};

_journalist
