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
	[_origin, _destination, _vehicleGroup] call AS_tactics_fnc_heli_attack;
} else {
	private _groupType = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
	private _group = createGroup side_red;
	[_groupType call AS_fnc_groupCfgToComposition, _group, _pos, _vehicle call AS_fnc_availableSeats] call AS_fnc_createGroup;
	{
		[_x] call AS_fnc_initUnitAAF;
		_x assignAsCargo _vehicle;
		_x moveInCargo _vehicle;
	} forEach units _group;
	_groups pushBack _group;

	[_vehicle,"Air Transport"] spawn AS_fnc_setConvoyImmune;
	[_origin, _destination, _vehicleGroup, _group] call AS_tactics_fnc_heli_disembark;
};
[_groups,  _vehicles]
