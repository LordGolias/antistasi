params ["_toUse", "_posorigen", "_posdestino"];

private _soldiers = [];
private _groups = [];
private _vehicles = [];

// This is expected to return a unit by a check done, but we are extra safe.
private _tipoVeh = selectRandom ([_toUse] call AS_fnc_AAFarsenal_all);
if (isNil "_tipoVeh") then {
	diag_log format ["[AS] ERROR: AAF has not enough units of '%1' but is spawning one.", _toUse];
	_tipoVeh = selectRandom (AS_AAFarsenal getVariable "valid_transportHelis");
};

// get a valid position to spawn vehicle.
private _timeOut = 0;
private _pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
while {_timeOut < 60} do {
	if (count _pos > 0) exitWith {};
	_timeOut = _timeOut + 1;
	_pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
	sleep 1;
};
if (count _pos == 0) then {_pos = _posorigen};

// spawn and init vehicle and crew
([_pos, random 360, _tipoVeh, side_green] call bis_fnc_spawnvehicle) params ["_veh", "_vehCrew", "_grupoVeh"];
_soldiers = _soldiers + _vehCrew;
_groups pushBack _grupoVeh;
_vehicles pushBack _veh;
{[_x] call AS_fnc_initUnitAAF} forEach units _grupoVeh;
[_veh] call genVEHinit;

// create waypoints and cargo depending on the type
if (_airType in ["planes","armedHelis"]) then {
	private _Hwp0 = _grupoVeh addWaypoint [_posdestino, 0];
	_Hwp0 setWaypointBehaviour "AWARE";
	_Hwp0 setWaypointType "SAD";
	[_veh,"Air Attack"] spawn inmuneConvoy;
} else {
	private _seats = ([_tipoVeh,true] call BIS_fnc_crewCount) - ([_tipoVeh,false] call BIS_fnc_crewCount);
	if (_seats <= 15) then {
		if (_seats <= 7) then {
			_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
		}
		else {
			_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		};
		_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		{[_x] spawn AS_fnc_initUnitAAF;_x assignAsCargo _veh;_x moveInCargo _veh; _soldiers = _soldiers + [_x]} forEach units _grupo;
		//[_mrkDestino,_grupo] spawn attackDrill;
		_groups pushBack _grupo;
		_landpos = [];
		_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		_landPos set [2, 0];
		_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
		_vehicles pushBack _pad;

		[_grupoVeh, _posorigen, _landpos, _location, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;

		/* _wp0 = _grupoVeh addWaypoint [_landpos, 0];
		_wp0 setWaypointType "TR UNLOAD";
		_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
		_wp0 setWaypointBehaviour "CARELESS";
		_wp3 = _grupo addWaypoint [_landpos, 0];
		_wp3 setWaypointType "GETOUT";
		_wp0 synchronizeWaypoint [_wp3];
		_wp4 = _grupo addWaypoint [_posdestino, 1];
		_wp4 setWaypointType "SAD";
		_wp2 = _grupoVeh addWaypoint [_posorigen, 1];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
		_wp2 setWaypointBehaviour "AWARE"; */
		[_veh,"Air Transport"] spawn inmuneConvoy;

	} else {
		_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		{[_x] spawn AS_fnc_initUnitAAF;_x assignAsCargo _veh;_x moveInCargo _veh; _soldiers = _soldiers + [_x]} forEach units _grupo;
		_groups pushBack _grupo;
		_grupo1 = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		{[_x] spawn AS_fnc_initUnitAAF;_x assignAsCargo _veh;_x moveInCargo _veh; _soldiers = _soldiers + [_x]} forEach units _grupo1;
		_groups pushBack _grupo;
		[_grupoVeh, _pos, _posdestino, _location, [_grupo, _grupo1], 25*60] call fnc_QRF_fastrope;
	};
};
[_soldiers, _groups,  _vehicles]
