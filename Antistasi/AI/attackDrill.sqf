params ["_location", "_group"];

private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;

waitUntil {sleep 5; (leader _group distance _posicion < _size) or ({alive _x} count units _group == 0)};

if (leader _group distance _posicion < _size) then {
	[leader _group, _location, "COMBAT","SPAWNED","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
};
