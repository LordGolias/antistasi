params ["_toUse", "_origin", "_patrol_marker", "_threatEval"];

private _groups = [];
private _vehicles = [];

private _vehicleType = selectRandom (_toUse call AS_AAFarsenal_fnc_valid);

// find a position to spawn the vehicle.
private _tam = 10;
private _roads = [];
while {count _roads == 0} do {
	_roads = _origin nearRoads _tam;
	_tam = _tam + 10;
};
private _road = _roads select 0;
private _pos = (position _road) findEmptyPosition [0,100,_vehicleType];
if (count _pos == 0) then {
	_pos = (position _road)
};

// spawn the vehicle and crew
([_pos, random 360,_vehicleType, side_red] call bis_fnc_spawnvehicle) params ["_vehicle", "_vehCrew", "_vehicleGroup"];
_groups pushBack _vehicleGroup;
_vehicles pushBack _vehicle;
{[_x] call AS_fnc_initUnitAAF} forEach _vehCrew;
[_vehicle,"AAF"] call AS_fnc_initVehicle;

// set waypoints
if (_toUse == "tanks") then {
	[_vehicle,"Tank"] spawn AS_fnc_setConvoyImmune;
	_vehicle allowCrewInImmobile true;
	[_origin, getMarkerPos _patrol_marker, _vehicleGroup, _patrol_marker, _threatEval] call AS_tactics_fnc_ground_attack;
} else {
	private _groupType = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
	private _group = createGroup side_red;
	[_groupType call AS_fnc_groupCfgToComposition, _group, _pos, _vehicle call AS_fnc_availableSeats] call AS_fnc_createGroup;

	{
		[_x] call AS_fnc_initUnitAAF;
		_x assignAsCargo _vehicle;
		_x moveInCargo _vehicle
	} forEach units _group;

	// APC drops the group in the safe position and moves to SAD (Search and Destroy)
	if (_toUse == "apcs") then {
		{
			_x joinSilent _vehicleGroup;
		} forEach units _group;
		deleteGroup _group;

		[_vehicle] spawn AS_AI_fnc_activateUnloadUnderSmoke;
		[_vehicle,"APC"] spawn AS_fnc_setConvoyImmune;
		_vehicle allowCrewInImmobile true;
		[_origin, getMarkerPos _patrol_marker, _vehicleGroup, _patrol_marker, _threatEval] call AS_tactics_fnc_ground_combined;
	} else {  // is truck
		_groups pushBack _group;
		[_vehicle, "Inf Truck."] spawn AS_fnc_setConvoyImmune;

		[_origin, getMarkerPos _patrol_marker, _vehicleGroup, _patrol_marker, _group, _threatEval] call AS_tactics_fnc_ground_disembark;
	};
};
[_groups, _vehicles]
