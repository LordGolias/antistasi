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
params ["_origin", "_destination", "_location", "_duration", "_composition", "_size", ["_source", ""]];

// FIA bases/airports
private _bases = ["base", "AAF"] call AS_location_fnc_TS;

private _posComp = ["transport", "destroy", "mixed"];
if !(_composition in _posComp) exitWith {};

// define type of QRF and vehicles by type of origin, plus method of troop insertion by air (rope or land)
private _type = "air";
private _method = "fastrope";
private _faction = "CSAT";
private _side = side_red;
private _attackVehicle = selectRandom (["CSAT", "helis_armed"] call AS_fnc_getEntity);
private _transportVehicle = selectRandom (["CSAT", "helis_transportVehicle"] call AS_fnc_getEntity);
private _dismountGroup = [["CSAT", "recon_team"] call AS_fnc_getEntity, "CSAT"] call AS_fnc_pickGroup;
if not (_origin isEqualTo "spawnCSAT") then {
	_method = "disembark";
	_faction = "AAF";
	if (_size == "small") then {
		_transportVehicle = selectRandom (["AAF", "helis_transportVehicle"] call AS_fnc_getEntity);
		_dismountGroup = [["AAF", "teams"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		if (_origin in _bases) then {
			_type = "land";
			_attackVehicle = selectRandom [["AAF", "cars_armed"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
			_transportVehicle = selectRandom ("trucks" call AS_AAFarsenal_fnc_valid);
			_dismountGroup = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		};
	} else {
		_transportVehicle = selectRandom (["AAF", "helis_transportVehicle"] call AS_fnc_getEntity);
		_dismountGroup = [["AAF", "squads"] call AS_fnc_getEntity, "AAF"] call AS_fnc_pickGroup;
		_method = "fastrope";
		if (_origin in _bases) then {
			_type = "land";
			_attackVehicle = selectRandom ("apcs" call AS_AAFarsenal_fnc_valid);
			_transportVehicle = selectRandom ("trucks" call AS_AAFarsenal_fnc_valid);
		};
	};
};

// get the position of the target marker
if (typeName _origin != "ARRAY") then {
	_origin = _origin call AS_location_fnc_position;
};

// arrays of all resources (resources owned by this script)
private _grupos = [];
private _soldados = [];
private _vehiculos = [];
private _markers = [];

// create a patrol marker if none provided
if (_location == "none") then {
	_location = createMarkerLocal [format ["Patrol-%1", random 100],_destination];
	_location setMarkerShapeLocal "RECTANGLE";
	_location setMarkerSizeLocal [150,150];
	_location setMarkerTypeLocal "hd_warning";
	_location setMarkerColorLocal "ColorRed";
	_location setMarkerBrushLocal "DiagGrid";
    _location setMarkerAlpha 0;
	_markers pushBack _location;
};

private _spawnGroup = {
	params ["_groupType"];
	private _group = [_origin, _side, _groupType] call BIS_Fnc_spawnGroup;
	if (_faction == "AAF") then {
		{_x call AS_fnc_initUnitAAF} forEach units _group;
	} else {
		{_x call AS_fnc_initUnitCSAT} forEach units _group;
	};
	_grupos pushBack _group;
	_soldados append units _group;
	_group
};

private _spawnVehicle = {
	params ["_vehicleType", "_position", "_direction"];
	([_position, _direction, _vehicleType, _side] call bis_fnc_spawnvehicle) params ["_vehicle", "_group"];
	if (_faction == "AAF") then {
		{_x call AS_fnc_initUnitAAF} forEach units _group;
	} else {
		{_x call AS_fnc_initUnitCSAT} forEach units _group;
	};
	_grupos pushBack _group;
	_soldados append units _group;
	_vehiculos pushBack _vehicle;
	_group
};

if (_type == "air") then {
	private _dir = [_origin, _destination] call BIS_fnc_dirTo;

	if ((_composition == "destroy") || (_composition == "mixed")) then {
		private _grpVeh1 = [_attackVehicle, _origin, _dir] call _spawnVehicle;
		[_origin, _destination, _grpVeh1] call AS_tactics_fnc_heli_attack;
	};

	// small delay to prevent crashes when both helicopters are spawned
	if (_composition == "mixed") then {
		sleep 5;
	};

	if ((_composition == "transport") || (_composition == "mixed")) then {
		// shift the spawn position of second chopper (in `mixed`) to avoid crash
		private _pos2 = +_origin;
		_pos2 set [2, (_origin select 2) + 50];

		// troop transport chopper
		private _crew_group = [_transportVehicle, _pos2, _dir] call _spawnVehicle;
		private _heli2 = _vehiculos select (count _vehiculos - 1); // last spawned vehicle is the one

		// spawn dismounts
		private _cargo_group = _dismountGroup call _spawnGroup;
		{
			_x assignAsCargo _heli2;
			_x moveInCargo _heli2;
		} forEach units _cargo_group;

		if (_method == "fastrope") then {
			[_origin, _destination, _crew_group, _cargo_group] spawn AS_tactics_fnc_heli_fastrope;
		} else {
			_vehiculos append ([_origin, _destination, _crew_group, _cargo_group] call AS_tactics_fnc_heli_disembark);
		};

		// if the QRF is dispatched to an FIA camp, provide the group
		if (_source == "campQRF") then {
			AS_Sset("campQRF", [__cargo_group]);
		};
	};
} else { // ground
	// find a road to spawn
	private _posData = [_origin, _destination] call AS_fnc_findSpawnSpots;
	private _posRoad = _posData select 0;
	private _dir = _posData select 1;

	// spawn the attack vehicle
	if ((_composition == "destroy") || (_composition == "mixed")) then {
		private _crew_group = [_attackVehicle, _posRoad, _dir] call _spawnVehicle;

		[_origin, _destination, _crew_group, _location] spawn AS_tactics_fnc_ground_attack;
	};

	// small delay to allow for AI pathfinding
	if (_composition == "mixed") then {
		sleep 5;
	};

	// spawn the transport vehicle
	if ((_composition == "transport") || (_composition == "mixed")) then {
		// transport vehicle
		private _crew_group = [_transportVehicle, _posRoad, _dir] call _spawnVehicle;
		private _transport = _vehiculos select (count _vehiculos - 1); // last spawned vehicle is the one

		// dismount group
		private _grpDis2 = _dismountGroup call _spawnGroup;
		{
			_x assignAsCargo _transport;
			_x moveInCargo _transport;
		} forEach units _grpDis2;

		[_origin, _destination, _crew_group, _location, _grpDis2] spawn AS_tactics_fnc_ground_disembark;
	};
};

private _endTime = dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + _duration];
waitUntil {sleep 10; (dateToNumber date > _endTime) or ({_x call AS_fnc_canFight} count _soldados == 0)};

[_grupos, _vehiculos, _markers] call AS_fnc_cleanResources;
