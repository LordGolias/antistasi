#include "../macros.hpp"
AS_SERVER_ONLY("fnc_sendEnemyQRF");
/*
parameters
0: base/airport/carrier to start from (marker)
1: target location (position)
2: marker for dismounts to patrol (marker)
3: patrol duration (time in minutes)
4: composition: transport/destroy/mixed (string)
5: size: large/small (string)
6: source of the QRF request (optional)

If origin is an airport/carrier, the QRF will consist of air cavalry. Otherwise it'll be ground forces in MRAPs/trucks.
*/
params ["_orig", "_dest", "_mrk", "_duration", "_composition", "_size", ["_source", ""]];

// FIA bases/airports
private _bases = ["base", "AAF"] call AS_location_fnc_TS;

private _posComp = ["transport", "destroy", "mixed"];
if !(_composition in _posComp) exitWith {};

// define type of QRF and vehicles by type of origin, plus method of troop insertion by air (rope or land)
private _type = "air";
private _method = "rope";
private _side = side_red;
private _lead = selectRandom (["CSAT", "helis_armed"] call AS_fnc_getEntity);
private _transport = selectRandom (["CSAT", "helis_fastrope"] call AS_fnc_getEntity);
private _dismountGroup = [opGroup_Recon_Team, "CSAT"] call AS_fnc_pickGroup;
if (_size == "large") then {
	_dismountGroup = [opGroup_Squad, "CSAT"] call AS_fnc_pickGroup;
};
private _dismountGroupEscort = [["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
if !(_orig == "spawnCSAT") then {
	_method = "land";
	_side = side_red;
	_lead = selectRandom ("armedHelis" call AS_AAFarsenal_fnc_valid);
	if (_size == "small") then {
		_transport = selectRandom ("transportHelis" call AS_AAFarsenal_fnc_valid);
		_dismountGroup = [["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		if (_orig in _bases) then {
			_type = "land";
			_lead = selectRandom (["AAF", "leadVehicles"] call AS_fnc_getEntity, "AAF"]);
			_transport = selectRandom ("trucks" call AS_AAFarsenal_fnc_valid);
			_dismountGroup = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		};
	} else {
		_transport = selectRandom ("transportHelis" call AS_AAFarsenal_fnc_valid);
		_dismountGroup = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		_method = "rope";
		if (_orig in _bases) then {
			_type = "land";
			_lead = selectRandom ("apcs" call AS_AAFarsenal_fnc_valid);
			_transport = selectRandom ("trucks" call AS_AAFarsenal_fnc_valid);
			_dismountGroup = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		};
	};
};

// get the position of the target marker
if !(typeName _orig == "ARRAY") then {
	_orig = _orig call AS_location_fnc_position;
};

// create a patrol marker if none provided
if (_mrk == "none") then {
	_mrk = createMarkerLocal [format ["Patrol-%1", random 100],_dest];
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [150,150];
	_mrk setMarkerTypeLocal "hd_warning";
	_mrk setMarkerColorLocal "ColorRed";
	_mrk setMarkerBrushLocal "DiagGrid";
    _mrk setMarkerAlpha 0;
};

private _endTime = dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + _duration];

// arrays of all spawned units/groups
private _grupos = [];
private _soldados = [];
private _vehiculos = [];

// initialise groups, two for vehicles, three for dismounts
private _grpVeh1 = createGroup _side;
_grupos pushBack _grpVeh1;

private _grpVeh2 = createGroup _side;
_grupos pushBack _grpVeh2;

private _grpDis1 = createGroup _side;
_grupos pushBack _grpDis1;

private _grpDis2 = createGroup _side;
_grupos pushBack _grpDis2;

private _grpDisEsc = createGroup _side;
_grupos pushBack _grpDisEsc;

private _dir = [_orig, _dest] call BIS_fnc_dirTo;

// initialisation of vehicles
private _initVehs = {
	params ["_specs"];
	_specs = _specs + [_dir, _side, _vehiculos, _grupos, _soldados, true];
	_specs call AS_fnc_spawnRedVehicle;
};

// air cav
if (_type == "air") then {

	if ((_composition == "destroy") || (_composition == "mixed")) then {
		// attack chopper/armed escort

		private _vehData = [[_orig, _lead]] call _initVehs;
		_vehiculos = _vehData select 0;
		_grupos = _vehData select 1;
		_soldados = _vehData select 2;

		private _heli1 = (_vehData select 3) select 0;
		_grpVeh1 = (_vehData select 3) select 1;

		_heli1 lock 3;

		// spawn loiter script for armed escort
		[_grpVeh1, _orig, _dest, _duration*60] spawn AS_QRF_fnc_gunship;
	};

	// small delay to prevent crashes when both helicopters are spawned
	if (_composition == "mixed") then {
		sleep 5;
	};

	if ((_composition == "transport") || (_composition == "mixed")) then {
		// landing pad, to allow for dismounts
		private _landpos1 = [];
		if (_source == "campQRF") then {
			_landpos1 = [_dest, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		}
		else {
			_landpos1 = [_dest, 50, 300, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		};
		_landpos1 set [2, 0];
		private _pad1 = createVehicle ["Land_HelipadEmpty_F", _landpos1, [], 0, "NONE"];
		_vehiculos pushBack _pad1;

		// shift the spawn position of second chopper to avoid crash
		private _pos2 = _orig;
		private _zshift2 = (_orig select 2) + 50;
		_pos2 set [2, _zshift2];

		// troop transport chopper
		private _vehData = [[_pos2, _transport]] call _initVehs;
		_vehiculos = _vehData select 0;
		_grupos = _vehData select 1;
		_soldados = _vehData select 2;

		private _heli2 = (_vehData select 3) select 0;
		_grpVeh2 = (_vehData select 3) select 1;

		_heli2 lock 3;

		// spawn dismounts
		_grpDis2 = [_orig, _side, _dismountGroup] call BIS_Fnc_spawnGroup;
		[_grpDis2, _side] call AS_fnc_initRedUnits;
		{
			_soldados pushBack _x;
			_x assignAsCargo _heli2;
			_x moveInCargo _heli2;
		} forEach units _grpDis2;
		_grpDis2 selectLeader (units _grpDis2 select 0);

		// spawn dismount script
		if ((_size == "large") && !(_side == side_red)) then {
			_grpDis1 = [_orig, _side, _dismountGroup] call BIS_Fnc_spawnGroup;
			[_grpDis1, _side] call AS_fnc_initRedUnits;
			{
				_soldados pushBack _x;
				_x assignAsCargo _heli2;
				_x moveInCargo _heli2;
			} forEach units _grpDis1;
			_grpDis1 selectLeader (units _grpDis1 select 0);

			[_grpVeh2, _pos2, _landpos1, _mrk, [_grpDis1,_grpDis2], _duration*60, _method] call AS_QRF_fnc_airCavalry;
		}
		else {
			[_grpVeh2, _pos2, _landpos1, _mrk, _grpDis2, _duration*60, _method] spawn AS_QRF_fnc_airCavalry;
		};

		// if the QRF is dispatched to an FIA camp, provide the group
		if (_source == "campQRF") then {
			if (_size == "large") then {
				AS_Sset("campQRF", [_grpDis1,_grpDis2]);
			} else {
				AS_Sset("campQRF", [_grpDis2]);
			};
		};
	};
}

// ground QRF
else {
	// find spawn positions on a road
	private _posData = [_orig, _dest] call AS_fnc_findSpawnSpots;
	private _posRoad = _posData select 0;
	_dir = _posData select 1;

	if ((_composition == "destroy") || (_composition == "mixed")) then {
		// first MRAP, escort
		private _vehData = [[_posRoad, _lead]] call _initVehs;
		_vehiculos = _vehData select 0;
		_grupos = _vehData select 1;
		_soldados = _vehData select 2;

		private _veh1 = (_vehData select 3) select 0;
		_grpVeh1 = (_vehData select 3) select 1;
		_grpDisEsc = [];

		if (_size == "large") then {
			_grpDisEsc = [_orig, _side, _dismountGroupEscort] call BIS_Fnc_spawnGroup;
			[_grpDisEsc, _side] call AS_fnc_initRedUnits;
			{
				_soldados pushBack _x;
				_x assignAsCargo _veh1;
				_x moveInCargo _veh1;
			} forEach units _grpDisEsc;
			_grpDisEsc selectLeader (units _grpDisEsc select 0);
		};

		// add waypoints
		[_grpVeh1, _orig, _dest, _mrk, _grpDisEsc, _duration*60] spawn AS_QRF_fnc_leadVehicle;
	};

	// small delay to allow for AI pathfinding shenanigans
	if (_composition == "mixed") then {
		sleep 25;
	};

	if ((_composition == "transport") || (_composition == "mixed")) then {
		// dismount position
		private _landpos1 = [_dest, _posRoad, 0] call AS_fnc_getSafeRoadToUnload;

		// second vehicle
		private _vehData = [[_posRoad, _transport]] call _initVehs;
		_vehiculos = _vehData select 0;
		_grupos = _vehData select 1;
		_soldados = _vehData select 2;

		private _veh2 = (_vehData select 3) select 0;
		_grpVeh2 = (_vehData select 3) select 1;

		// add dismounts
		_grpDis2 = [_orig, _side, _dismountGroup] call BIS_Fnc_spawnGroup;
		[_grpDis2, _side] call AS_fnc_initRedUnits;
		{
			_soldados pushBack _x;
			_x assignAsCargo _veh2;
			_x moveInCargo _veh2;
		} forEach units _grpDis2;
		_grpDis2 selectLeader (units _grpDis2 select 0);

		if (_size == "large") then {
			_grpDis1 = [_orig, _side, _dismountGroup] call BIS_Fnc_spawnGroup;
			[_grpDis1, _side] call AS_fnc_initRedUnits;
			{
				_soldados pushBack _x;
				_x assignAsCargo _veh2;
				_x moveInCargo _veh2;
			} forEach units _grpDis1;
			_grpDis1 selectLeader (units _grpDis1 select 0);
		};

		// spawn dismount script
		[_grpVeh2, _orig, _landpos1, _mrk, [_grpDis1, _grpDis2], _duration*60] spawn AS_QRF_fnc_truck;
	};
};

waitUntil {sleep 10; (dateToNumber date > _endTime) or ({alive _x} count _soldados == 0)};

[_grupos, _vehiculos, []] call AS_fnc_cleanResources;
