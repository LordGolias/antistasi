#include "../../macros.hpp"

private _fnc_spawn = {
	params ["_location"];

	// Spawned stuff
	private _soldados = [];
	private _grupos = [];
	private _vehiculos = [];
	private _civs = [];

	_vehiculos append (_location call AS_fnc_spawnComposition);

	private _posicion = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	private _type = _location call AS_location_fnc_type;
	private _isDestroyed = _location in AS_P("destroyedLocations");

	if (_type != "fia_hq") then {
		// The flag
		private _veh = createVehicle [["FIA", "flag"] call AS_fnc_getEntity, _posicion, [],0, "CAN_COLLIDE"];
		_veh allowDamage false;
		_vehiculos pushBack _veh;
		[[_veh,"unit"],"AS_fnc_addAction"] call BIS_fnc_MP;
		[[_veh,"vehicle"],"AS_fnc_addAction"] call BIS_fnc_MP;
		[[_veh,"garage"],"AS_fnc_addAction"] call BIS_fnc_MP;
		if (_type == "seaport") then {
			[[_veh,"seaport"],"AS_fnc_addAction"] call BIS_fnc_MP;
		};

		// worker civilians in non-military non-destroyed markers
		if ((_type in ["powerplant","resource","factory"]) and !_isDestroyed) then {
			if ((daytime > 8) and (daytime < 18)) then {
				private _grupo = createGroup civilian;
				_grupos pushBack _grupo;
				for "_i" from 1 to 8 do {
					private _civ = _grupo createUnit ["C_man_w_worker_F", _posicion, [],0, "NONE"];
					[_civ] spawn AS_fnc_initUnitCIV;
					_civs pushBack _civ;
					sleep 0.5;
				};
				[_location,_civs] spawn AS_fnc_location_canBeDestroyed;  // power shuts if everyone is killed
				[leader _grupo, _location, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX","NOVEH2"] spawn UPSMON;
			};
		};
	};

	if (_type == "outpost") then {
		// if close to an antenna, add jam option
		private _antennaPos = [AS_P("antenasPos_alive"),_posicion] call BIS_fnc_nearestPosition;
		if (_antennaPos distance _posicion < 100) then {
			[[nearestBuilding _antennaPos,"jam"],"AS_fnc_addAction"] call BIS_fnc_MP;
		};
	};

	// Create the garrison
	(_location call AS_fnc_createFIAgarrison) params ["_soldados1", "_grupos1", "_vehiculos1"];
	_soldados append _soldados1;
	_grupos append _grupos1;
	_vehiculos append _vehiculos1;

	// no journalist in the HQ
	if (_type != "fia_hq") then {
		[_location, _grupos] call AS_fnc_spawnJournalist;
	};

	[_location, "resources", [taskNull, _grupos, _vehiculos, []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
	[_location, "FIAsoldiers", _soldados] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_location"];
	private _type = _location call AS_location_fnc_type;

	if !(_type in ["fia_hq","city"]) then {
		_location call AS_location_spawn_fnc_FIAwait_capture;
	} else {
		waitUntil {sleep 1; !(_location call AS_location_fnc_spawned)};
	};
};

AS_spawn_createFIAgeneric_states = ["spawn", "run", "clean"];
AS_spawn_createFIAgeneric_state_functions = [
	_fnc_spawn,
	_fnc_run,
	AS_location_spawn_fnc_FIAlocation_clean
];
