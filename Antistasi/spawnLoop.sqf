#include "macros.hpp"
AS_SERVER_ONLY("spawnLoop.sqf");

private _tiempo = time;

while {true} do {
	// maintain a rate of checks of "AS_spawnLoopTime" seconds.
	if (time - _tiempo >= AS_spawnLoopTime) then {sleep AS_spawnLoopTime/5} else {sleep AS_spawnLoopTime - (time - _tiempo)};
	_tiempo = time;

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
			_spawnCondition = ({(_x distance _position < AS_P("spawnDistance"))} count _spawningBLUFORunits > 0) or (_x call AS_fnc_location_forced_spawned);
			if (!_isSpawned and _spawnCondition) then {
				_x call AS_fnc_location_spawn;
				private _type = _x call AS_fnc_location_type;
				switch (true) do {
					case (_type == "hill"): {[_x] remoteExec ["createWatchpost",HCGarrisons]};
					case (_type == "hillAA"): {[_x] remoteExec ["createAAsite",HCGarrisons]};
					case (_type == "city"): {
						[_x] remoteExec ["createCIV",HCciviles];
						[_x] remoteExec ["createCity",HCGarrisons]
					};
					case (_type in ["resource", "powerplant", "factory"]): {
						[_x] remoteExec ["AS_fnc_createAAFgeneric",HCGarrisons];
					};
					case (_type == "base"): {[_x] remoteExec ["createBase",HCGarrisons]};
					case (_type == "roadblock"): {[_x] remoteExec ["createRoadblock",HCGarrisons]};
					case (_type == "airfield"): {[_x] remoteExec ["createAirbase",HCGarrisons]};
					case (_type in ["outpost", "seaport"]): {[_x] remoteExec ["createOutpost",HCGarrisons]};
					case (_type == "outpostAA"): {[_x] remoteExec ["createOutpostAA",HCGarrisons]};
				};
			};
			if (_isSpawned and !_spawnCondition) then {
				_x call AS_fnc_location_despawn;
			};
		};
		if (_x call AS_fnc_location_side == "FIA") then {
			// not clear what this is doing. owner is about who controls it, not something else.
			_playerIsClose = (_x call AS_fnc_location_forced_spawned) or
							 ({((_x getVariable ["owner", objNull]) == _x) and
							   (_x distance _position < AS_P("spawnDistance"))} count _spawningBLUFORunits > 0);
			// enemies are close.
			_spawnCondition = (_playerIsClose or
							   ({_x distance _position < AS_P("spawnDistance")} count _spawningOPFORunits > 0));
			if (!_isSpawned and _spawnCondition) then {
				_x call AS_fnc_location_spawn;

				private _type = _x call AS_fnc_location_type;
				switch (true) do {
					case (_type == "city"): {
						if (_playerIsClose) then {
							[_x] remoteExec ["createCIV",HCciviles];
						};
						[_x] remoteExec ["AS_fnc_createFIAgeneric",HCGarrisons]
					};
					case (_type in ["resource","powerplant","factory","fia_hq","outpost","outpostAA"]): {
						[_x] remoteExec ["AS_fnc_createFIAgeneric",HCGarrisons]
					};
					case (_type == "airfield"): {[_x] remoteExec ["createNATOaerop",HCGarrisons]};
					case (_type == "base"): {[_x] remoteExec ["createNATObases",HCGarrisons]};
					case (_type in ["roadblock","watchpost","camp"]): {
						[_x] remoteExec ["AS_fnc_createFIA_built_location",HCGarrisons];
					};
					case (_type == "NATOwatchpost"): {[_x] remoteExec ["createNATOpuesto",HCGarrisons]};
				};
			};
			if (_isSpawned and !_spawnCondition) then {
				_x call AS_fnc_location_despawn;
			};
		};
	} forEach (call AS_fnc_location_all);
};
