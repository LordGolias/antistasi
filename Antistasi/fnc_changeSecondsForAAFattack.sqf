#include "macros.hpp"
AS_SERVER_ONLY("fnc_changeSecondsforAAFattack.sqf");

params ["_time", ["_multiply", true]];

if (_multiply) then {
	private _FIAbases = ["base", "FIA"] call AS_location_fnc_TS;
	private _allBases = "base" call AS_location_fnc_T;

	if (count _allBases == 0) then {
		_allBases = [0];  // avoid 0/0 below
	};
	private _multiplier = 0.3 + (1 - 0.3)*(count _FIAbases)/(count _allBases);
	_time = _time * _multiplier;
};

private _current = AS_P("secondsForAAFAttack");
AS_Pset("secondsForAAFAttack", (_current + round _time) max 0);
