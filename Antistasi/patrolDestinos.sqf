params ["_location"];

private _posHQ = getMarkerPos "FIA_HQ";

private _validLocations = [];
private _allLocations = [
	["base", "airfield", "resource", "factory", "powerplant", "outpost", "outpostAA"],
	"AAF"] call AS_fnc_location_TS;
{
	private _pos = _x call AS_fnc_location_position;
	if (_posHQ distance _pos < 3000) then {_validLocations pushBack _x};
} forEach _allLocations;
_validLocations
