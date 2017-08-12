params ["_toUse", "_posorigen", "_posdestino", "_threatEval"];

private _soldiers = [];
private _groups = [];
private _vehicles = [];

// This is expected to return a unit by a check done, but we are extra safe.
private _tipoVeh = selectRandom ([_toUse] call AS_fnc_AAFarsenal_all);
if (isNil "_tipoVeh") then {
	diag_log format ["[AS] ERROR: AAF has not enough units of '%1' but is spawning one.", _toUse];
	_toUse = "trucks";
	_tipoVeh = selectRandom (AS_AAFarsenal getVariable "valid_trucks");
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

([_pos, random 360,_tipoVeh, side_red] call bis_fnc_spawnvehicle) params ["_veh", "_vehCrew", "_grupoVeh"];
_soldiers append _vehCrew;
_groups pushBack _grupoVeh;
_vehicles pushBack _veh;
{[_x] call AS_fnc_initUnitAAF} forEach _vehCrew;
[_veh,"AAF"] call AS_fnc_initVehicle;

private _landPos = [_posdestino, position _road,_threatEval] call findSafeRoadToUnload;

if (_toUse == "tanks") then {
	private _Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
	_Vwp0 setWaypointBehaviour "SAFE";
	[_veh,"Tank"] spawn inmuneConvoy;
	_Vwp0 setWaypointType "SAD";
	_veh allowCrewInImmobile true;
} else {
	// todo: to a better job at selecting groups/units here: they may not fit.
	private _seats = ([_tipoVeh,true] call BIS_fnc_crewCount) - ([_tipoVeh,false] call BIS_fnc_crewCount);
	private _tipoGrupo = [infSquad, "AAF"] call fnc_pickGroup;
	if (_seats <= 7) then {
		_tipoGrupo = [infTeam, "AAF"] call fnc_pickGroup;
	};

	if (_toUse == "apcs") then {
		private _group = [_posorigen, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
		{[_x] spawn AS_fnc_initUnitAAF; _x assignAsCargo _veh; _x moveInCargo _veh; _soldiers pushBack _x} forEach units _group;
		_groups pushBack _group;
		private _Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		_Vwp0 setWaypointType "TR UNLOAD";
		private _Vwp1 = _grupoVeh addWaypoint [_posdestino, 1];
		_Vwp1 setWaypointType "SAD";
		_Vwp1 setWaypointBehaviour "COMBAT";
		private _Vwp2 = _group addWaypoint [_landPos, 0];
		_Vwp2 setWaypointType "GETOUT";
		_Vwp0 synchronizeWaypoint [_Vwp2];
		private _Vwp3 = _group addWaypoint [_posdestino, 1];
		_Vwp3 setWaypointType "SAD";
		[_veh] spawn smokeCover;
		[_veh,"APC"] spawn inmuneConvoy;
		_veh allowCrewInImmobile true;
	}
	else {  // is truck
		private _group = [_posorigen, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;

		// extend group to fill truck
		private _gSize = (_veh emptyPositions "cargo") - (count units _group);
		for "_i" from 1 to _gSize do {
			private _unitType = (infList_sniper + infList_special + infList_auto + infList_regular + infList_regular) call BIS_fnc_selectRandom;
			_group createUnit [_unitType, getPos _veh, [], 0, "NONE"];
		};
		{[_x] spawn AS_fnc_initUnitAAF; _x assignAsCargo _veh; _x moveInCargo _veh; _soldiers pushBack _x} forEach units _group;
		(units _group) join _grupoVeh;
		deleteGroup _group;

		private _Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		_Vwp0 setWaypointType "GETOUT";
		private _Vwp1 = _grupoVeh addWaypoint [_posdestino, 1];
		_Vwp1 setWaypointType "SAD";
		_Vwp1 setWaypointBehaviour "COMBAT";
		[_veh,"Inf Truck."] spawn inmuneConvoy;
	};
};
[_soldiers, _groups, _vehicles]
