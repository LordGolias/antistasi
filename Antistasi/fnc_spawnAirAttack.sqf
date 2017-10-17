params ["_toUse", "_origin", "_destination"];

private _groups = [];
private _vehicles = [];

// This is expected to return a unit by a check done, but we are extra safe.
private _vehicleType = selectRandom (_toUse call AS_AAFarsenal_fnc_valid);

// get a valid position to spawn vehicle.
private _size = 100;
private _pos = [];
while {count _pos == 0} do {
	_pos = _origin findEmptyPosition [0, _size, _vehicleType];
};

// spawn and init vehicle and crew
([_pos, random 360, _vehicleType, side_red] call bis_fnc_spawnvehicle) params ["_vehicle", "_vehCrew", "_vehicleGroup"];
_groups pushBack _vehicleGroup;
_vehicles pushBack _vehicle;
{[_x] call AS_fnc_initUnitAAF} forEach units _vehicleGroup;
[_vehicle, "AAF"] call AS_fnc_initVehicle;

// create waypoints and cargo depending on the type
if (_toUse in ["planes", "helis_armed"]) then {
	private _Hwp0 = _vehicleGroup addWaypoint [_destination, 0];
	_Hwp0 setWaypointBehaviour "AWARE";
	_Hwp0 setWaypointType "SAD";
	[_vehicle,"Air Attack"] spawn AS_fnc_setConvoyImmune;
} else {
	private _seats = ([_vehicleType,true] call BIS_fnc_crewCount) - ([_vehicleType,false] call BIS_fnc_crewCount);
	private _tipoGrupo = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
	if (_seats <= 7) then {
		_tipoGrupo = [["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
	};
	private _grupo = [_origin, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
	{[_x] spawn AS_fnc_initUnitAAF;_x assignAsCargo _vehicle;_x moveInCargo _vehicle;} forEach units _grupo;
	_groups pushBack _grupo;

	[_origin, _position, _grupoheli, _group] call AS_tactics_fnc_heli_disembark;

	[_vehicle,"Air Transport"] spawn AS_fnc_setConvoyImmune;
};
[_groups,  _vehicles]
