#include "macros.hpp"
AS_SERVER_ONLY("spawnLoop.sqf");

private _tiempo = time;

while {true} do {
	// maintain a rate of checks of "AS_spawnLoopTime" seconds.
	sleep AS_spawnLoopTime;
	//if (time - _tiempo >= AS_spawnLoopTime) then {sleep (AS_spawnLoopTime/5)} else {sleep (AS_spawnLoopTime - (time - _tiempo))};
	//_tiempo = time;

	waitUntil {!isNil "AS_commander"};

	// get units that spawn locations
	private _spawningBLUFORunits = [];
	private _spawningOPFORunits = [];
	{
		if (_x getVariable ["BLUFORSpawn",false]) then {
			_spawningBLUFORunits pushBack _x;
			if (isPlayer _x) then {
				if (!isNull (getConnectedUAV _x)) then {
					_spawningBLUFORunits pushBack (getConnectedUAV _x);
				};
			};
		} else {
			if (_x getVariable ["OPFORSpawn",false]) then {
				_spawningOPFORunits pushBack _x;
			};
		};
	} forEach allUnits;

	// check whether a location is spawned or not
	{ // forEach location
		private _position = _x call AS_fnc_location_position;
		private _isSpawned = _x call AS_fnc_location_spawned;

		if (_x call AS_fnc_location_side == "AAF") then {
			private _spawnCondition = (_x call AS_fnc_location_forced_spawned) or {{(_x distance _position < AS_P("spawnDistance"))} count _spawningBLUFORunits > 0};
			if (!_isSpawned and _spawnCondition) then {
				_x call AS_fnc_location_spawn;
				private _type = _x call AS_fnc_location_type;
				switch (true) do {
					case (_type == "hill"): {
						[_x, "AAFhill"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "hillAA"): {
						[_x, "AAFhillAA"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "city"): {
						[[_x], "createCIV"] call AS_scheduler_fnc_execute;

						[_x, "AAFcity"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type in ["resource", "powerplant", "factory"]): {
						[_x, "AAFgeneric"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "base"): {
						[_x, "AAFbase"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "roadblock"): {[[_x], "createRoadblock"] call AS_scheduler_fnc_execute};
					case (_type == "airfield"): {
						[_x, "AAFairfield"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type in ["outpost", "seaport"]): {
						[_x, "AAFoutpost"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "outpostAA"): {
						[_x, "AAFoutpostAA"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "minefield"): {[[_x], "AS_fnc_createMinefield"] call AS_scheduler_fnc_execute};
				};
			};
			if (_isSpawned and !_spawnCondition) then {
				_x call AS_fnc_location_despawn;
			};
		};
		if (_x call AS_fnc_location_side == "FIA") then {
			// not clear what this is doing. owner is about who controls it, not something else.
			private _playerIsClose = (_x call AS_fnc_location_forced_spawned) or
							         {{((_x getVariable ["owner", _x]) == _x) and {_x distance _position < AS_P("spawnDistance")}} count _spawningBLUFORunits > 0};
			// enemies are close.
			private _spawnCondition = _playerIsClose or {{_x distance _position < AS_P("spawnDistance")} count _spawningOPFORunits > 0};
			if (!_isSpawned and _spawnCondition) then {
				_x call AS_fnc_location_spawn;

				private _type = _x call AS_fnc_location_type;
				switch (true) do {
					case (_type == "city"): {
						if (_playerIsClose) then {
							[[_x], "createCIV"] call AS_scheduler_fnc_execute;
						};
						[_x, "FIAgeneric"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type in ["resource","powerplant","factory","fia_hq","outpost","outpostAA"]): {
						[_x, "FIAgeneric"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "airfield"): {
						[_x, "FIAairfield"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type == "base"): {
						[_x, "FIAbase"] call AS_spawn_fnc_add;
						[[_x], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
					};
					case (_type in ["roadblock","watchpost","camp"]): {[[_x], "AS_fnc_createFIA_built_location"] call AS_scheduler_fnc_execute};
					case (_type == "NATOwatchpost"): {[[_x], "createNATOpuesto"] call AS_scheduler_fnc_execute};
					case (_type == "minefield"): {[[_x], "AS_fnc_createMinefield"] call AS_scheduler_fnc_execute};
				};
			};
			if (_isSpawned and !_spawnCondition) then {
				_x call AS_fnc_location_despawn;
			};
		};
	} forEach (call AS_fnc_locations);
};
