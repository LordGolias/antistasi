#include "../macros.hpp"
params ["_location", "_base", ["_aeropuerto", ""], ["_useCSAT", false], ["_isDirectAttack", true], ["_threatEval", 0]];

private _isLocation = false;
private _position = "";
if (typeName _location == typeName "") then {
	_isLocation = true;
	_position = _location call AS_fnc_location_position;
} else {
	_position = _location;
};

// save the marker or position
if _isLocation then {
	AS_Pset("patrollingLocations", AS_P("patrollingLocations") + [_location]);
} else {
	AS_Pset("patrollingPositions", AS_P("patrollingPositions") + [_position]);
};

// lists of spawned stuff to delete in the end.
private _soldados = [];
private _vehiculos = [];
private _grupos = [];

if (_base != "") then {
	private _posorigen = _base call AS_fnc_location_position;
	_aeropuerto = "";
	if (!_isDirectAttack) then {[_base,20] call AS_fnc_location_increaseBusy;};

	private _toUse = "trucks";
	if (_threatEval > 3 and (["apcs"] call AS_fnc_AAFarsenal_count > 0)) then {
		_toUse = "apcs";
	};
	if (_threatEval > 5 and (["tanks"] call AS_fnc_AAFarsenal_count > 0)) then {
		_toUse = "tanks";
	};

	([_toUse, _posorigen, _position, _threatEval, _isLocation] call AS_fnc_createLandAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
	_soldados append _soldiers1;
	_grupos append _groups1;
	_vehiculos append _vehicles1;
};

if (_aeropuerto != "") then {
	if (!_isDirectAttack) then {[_aeropuerto,20] call AS_fnc_location_increaseBusy;};
	private _posorigen = _aeropuerto call AS_fnc_location_position;
	private _cuenta = 1;
	if (_isLocation) then {_cuenta = 2};
	for "_i" from 1 to _cuenta do {  // the attack has 2 units for a non-marker
		private _toUse = "transportHelis";  // last attack is always a transport

		// first attack (1/2) can be any unit, stronger the higher the treat
		if (_i < _cuenta) then {
			if (["armedHelis"] call AS_fnc_AAFarsenal_count > 0) then {
				_toUse = "armedHelis";
			};
			if (_threatEval > 15 and (["planes"] call AS_fnc_AAFarsenal_count > 0)) then {
				_toUse = "planes";
			};
		};
		([_toUse, _posorigen, _position] call AS_fnc_createAirAttack) params ["_soldiers1", "_groups1", "_vehicles1"];
		_soldados = _soldados + _soldiers1;
		_grupos = _grupos + _groups1;
		_vehiculos = _vehiculos + _vehicles1;
		sleep 30;
		};
	};

if _useCSAT then {
	private _posorigen = getMarkerPos "spawnCSAT";
	_posorigen set [2,300];  // high in the skies
	for "_i" from 1 to 3 do {
		private _tipoVeh = "";
		if (_i == 3) then {
			_tipoVeh = selectRandom opHeliTrans;
		} else {
			if (_threatEval > 10) then {_tipoVeh = selectRandom (opAir - opHeliTrans)} else {_tipoVeh = selectRandom opAir};
		};
		private _pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
		if (count _pos == 0) then {_pos = _posorigen};

		([_pos, 0,_tipoVeh, side_red] call bis_fnc_spawnvehicle) params ["_heli", "_heliCrew", "_grupoheli"];
		_soldados = _soldados + _heliCrew;
		_grupos = _grupos + [_grupoheli];
		_vehiculos = _vehiculos + [_heli];
		[_heli, "CSAT"] spawn AS_fnc_initVehicle;
		{[_x] call AS_fnc_initUnitCSAT} forEach _heliCrew;
		if (!(_tipoVeh in opHeliTrans)) then {  // attack heli
			private _wp1 = _grupoheli addWaypoint [_position, 0];
			_wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
		} else {  // transport heli
			{_x setBehaviour "CARELESS";} forEach units _grupoheli;
			private _groupType = [opGroup_Squad, "CSAT"] call fnc_pickGroup;
			private _group = createGroup side_red;
			[_groupType call AS_fnc_groupCfgToComposition, _group, _posorigen, _heli call AS_fnc_availableSeats] call AS_fnc_createGroup;
			{
				_x assignAsCargo _heli;
				_x moveInCargo _heli;
				_soldados pushBack _x;
				_x call AS_fnc_initUnitCSAT;
			} forEach units _group;
			_grupos pushBack _group;
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;

			if (((_location call AS_fnc_location_type) in ["base", "airfield"]) or
			    (random 10 < _threatEval)) then {
				[_heli,_group,_position,_threatEval] spawn airdrop;
			} else {
				if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then {
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
					private _landpos = [];
					_landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
					_vehiculos = _vehiculos + [_pad];

					[_grupoheli, _posorigen, _landpos, _location, _group, 25*60, "air"] call fnc_QRF_dismountTroops;
				} else {
					[_grupoheli, _pos, _position, _location, [_group], 25*60] call fnc_QRF_fastrope;
				};
			};
		};
		sleep 15;  // time between spawning choppers
	};
};

//// All units sent. Cleanup below.

if _isLocation then {
	private _solMax = round ((count _soldados)/3);
	private _tiempo = time + 3600;

	waitUntil {sleep 5;
		(({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or
		({alive _x} count _soldados < _solMax) or
		(_location call AS_fnc_location_side == "AAF") or
		(time > _tiempo)
	};

	AS_Pset("patrollingLocations", AS_P("patrollingLocations") - [_location]);
	waitUntil {sleep 1; not (_location call AS_fnc_location_spawned)};
} else {
	waitUntil {sleep 1; !([AS_P("spawnDistance"), _position, "BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance)};
	AS_Pset("patrollingPositions", AS_P("patrollingPositions") - [_position]);
};

[_grupos, _vehiculos] call AS_fnc_cleanResources;
