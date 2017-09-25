params ["_toUse", "_origin", "_destination", "_threatEval"];

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

private _safePosition = [_destination, position _road, _threatEval] call AS_fnc_getSafeRoadToUnload;

// set waypoints
if (_toUse == "tanks") then {
	// tanks stay in a safe position to shoot from afar
	private _Vwp0 = _vehicleGroup addWaypoint [_safePosition, 0];
	_Vwp0 setWaypointBehaviour "SAFE";
	[_vehicle,"Tank"] spawn AS_fnc_setConvoyImmune;
	_Vwp0 setWaypointType "MOVE";
	_vehicle allowCrewInImmobile true;
} else {
	// todo: to a better job at selecting groups/units here: they may not fit.
	private _seats = ([_vehicleType,true] call BIS_fnc_crewCount) - ([_vehicleType,false] call BIS_fnc_crewCount);
	private _tipoGrupo = [infSquad, "AAF"] call AS_fnc_pickGroup;
	if (_seats <= 7) then {
		_tipoGrupo = [infTeam, "AAF"] call AS_fnc_pickGroup;
	};

	private _group = [_origin, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
	{[_x] spawn AS_fnc_initUnitAAF; _x assignAsCargo _vehicle; _x moveInCargo _vehicle} forEach units _group;

	// APC drops the group in the safe position and moves to SAD (Search and Destroy)
	if (_toUse == "apcs") then {
		_groups pushBack _group;

		// 1-APC go to safe position
		private _Vwp0 = _vehicleGroup addWaypoint [_safePosition, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		_Vwp0 setWaypointType "TR UNLOAD";
		// 2-APC SAD destination
		private _Vwp1 = _vehicleGroup addWaypoint [_destination, 1];
		_Vwp1 setWaypointType "SAD";
		_Vwp1 setWaypointBehaviour "COMBAT";
		// 1-Group disembark in safe position (sync with 1-APC)
		private _Vwp2 = _group addWaypoint [_safePosition, 0];
		_Vwp2 setWaypointType "GETOUT";
		_Vwp0 synchronizeWaypoint [_Vwp2];
		// 2-Group SAD destination
		private _Vwp3 = _group addWaypoint [_destination, 1];
		_Vwp3 setWaypointType "SAD";

		[_vehicle] spawn AS_AI_fnc_activateUnloadUnderSmoke;
		[_vehicle,"APC"] spawn AS_fnc_setConvoyImmune;
		_vehicle allowCrewInImmobile true;
	} else {  // is truck
		(units _group) join _vehicleGroup;
		deleteGroup _group;

		// 1 group moves to safe position
		private _Vwp0 = _vehicleGroup addWaypoint [_safePosition, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		_Vwp0 setWaypointType "GETOUT";
		// 2 group SADs destionation
		private _Vwp1 = _vehicleGroup addWaypoint [_destination, 1];
		_Vwp1 setWaypointType "SAD";
		_Vwp1 setWaypointBehaviour "COMBAT";

		[_vehicle,"Inf Truck."] spawn AS_fnc_setConvoyImmune;
	};
};
[_groups, _vehicles]
