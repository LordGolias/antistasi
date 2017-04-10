params ["_toUse", "_posorigen", "_posdestino", "_threatEval", "_isMarker"];

private _soldiers = [];
private _groups = [];
private _vehicles = [];

// This is expected to return a unit by a check done, but we are extra safe.
private _tipoVeh = selectRandom ([_toUse] call AS_fnc_AAFarsenal_all);
if (isNil "_tipoVeh") then {
	dial_log ["[AS] ERROR: AAF has not enough units of '%1' but is spawning one.", _toUse];
	_tipoVeh = selectRandom (AAFarsenal getVariable "valid_trucks");
};

// find a road to spawn the vehicle.
private _tam = 10;
private _roads = [];
while {true} do {
	_roads = _posorigen nearRoads _tam;
	if (count _roads < 1) then {_tam = _tam + 10};
	if (count _roads > 0) exitWith {};
};
private _road = _roads select 0;
private _pos = (position _road) findEmptyPosition [0,100,_tipoVeh];
if (count _pos == 0) then {_pos = (position _road)};

([_pos, random 360,_tipoVeh, side_green] call bis_fnc_spawnvehicle) params ["_veh", "_vehCrew", "_grupoVeh"];
_soldiers = _soldiers + _vehCrew;
_groups pushBack _grupoVeh;
_vehicles pushBack _veh;
{[_x] call AS_fnc_initUnitAAF} forEach _vehCrew;
[_veh,"AAF"] call AS_fnc_initVehicle;

if (_toUse in ["tanks"]) then {
	_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
	_Vwp0 setWaypointBehaviour "SAFE";
	[_veh,"Tank"] call inmuneConvoy;
	_Vwp0 setWaypointType "SAD";
	_veh allowCrewInImmobile true;
} else {
	private _landPos = [_posdestino, position _road,_threatEval] call findSafeRoadToUnload;

	// todo: to a better job at selecting groups/units here: they may not fit.
	private _seats = ([_tipoVeh,true] call BIS_fnc_crewCount) - ([_tipoVeh,false] call BIS_fnc_crewCount);
	private _tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
	if (_seats <= 7) then {
		_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
	};

	_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;

	{[_x] spawn AS_fnc_initUnitOPFOR; _x assignAsCargo _veh; _x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo;

	if (_toUse in ["apcs"]) then {
		_grupos = _grupos + [_grupo];
		_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		_Vwp0 setWaypointType "TR UNLOAD";
		//_Vwp0 setWaypointStatements ["true", "[vehicle this] call smokeCoverAuto"];
		_Vwp1 = _grupoVeh addWaypoint [_posdestino, 1];
		_Vwp1 setWaypointType "SAD";
		_Vwp1 setWaypointBehaviour "COMBAT";
		_Vwp2 = _grupo addWaypoint [_landPos, 0];
		_Vwp2 setWaypointType "GETOUT";
		_Vwp0 synchronizeWaypoint [_Vwp2];
		_Vwp3 = _grupo addWaypoint [_posdestino, 1];
		_Vwp3 setWaypointType "SAD";
		[_veh] spawn smokeCover;
		[_veh,"APC"] spawn inmuneConvoy;
		_veh allowCrewInImmobile true;
	}
	else {  // is truck
		{[_x] join _grupoVeh} forEach units _grupo;
		deleteGroup _grupo;

		private _tempInfo = [_veh, _grupoVeh, _soldados, _posorigen] call generateCrew;
		_veh = _tempInfo select 0;
		_grupoVeh = _tempInfo select 1;
		_soldados = _tempInfo select 2;

		_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		_Vwp0 setWaypointType "GETOUT";
		_Vwp1 = _grupoVeh addWaypoint [_posdestino, 1];
		_Vwp1 setWaypointType "SAD";
		_Vwp1 setWaypointBehaviour "COMBAT";
		[_veh,"Inf Truck."] spawn inmuneConvoy;
	};
};
_soldiers, _groups,  _vehicles
