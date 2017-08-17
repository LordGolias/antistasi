#include "../macros.hpp"
// Used to spawn "city","fia_hq","factory","resource","powerplant"
params ["_location"];

// Spawned stuff
private _soldados = [];
private _grupos = [];
private _vehiculos = [];
private _civs = [];
// buildings that can be destroyed
private _buildings = [];

private _posicion = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
private _size = _location call AS_fnc_location_size;
private _isDestroyed = _location in AS_P("destroyedLocations");

if (_type != "fia_hq") then {
	// The flag
	private _veh = createVehicle ["Flag_FIA_F", _posicion, [],0, "CAN_COLLIDE"];
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
				_civ = _grupo createUnit ["C_man_w_worker_F", _posicion, [],0, "NONE"];
				[_civ] spawn AS_fnc_initUnitCIV;
				_civs pushBack _civ;
				sleep 0.5;
			};
			[_location,_civs] spawn destroyCheck;  // power shuts if everyone is killed
			[leader _grupo, _location, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX","NOVEH2"] execVM "scripts\UPSMON.sqf";
		};
	};
};

if (_type == "outpost") then {
	// populate military buildings
	_buildings append (nearestObjects [_posicion, AS_destroyable_buildings, _size*1.5]);

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
	_civs pushBack ([_location, _grupos] call AS_fnc_createJournalist);
};

if !(_type in ["fia_hq","city"]) then {
	// wait for successful attack to lose the marker
	private _wasCaptured = false;
	waitUntil {sleep 1;
		private _AAFcount = ({not(vehicle _x isKindOf "Air")} count ([_size, _posicion, "OPFORSpawn"] call AS_fnc_unitsAtDistance));
		private _FIAcount = (({alive _x} count _soldados) + count ([_size, _posicion, "BLUFORSpawn"] call AS_fnc_unitsAtDistance));

		_wasCaptured = (_AAFcount > 3*_FIAcount);

		!(_location call AS_fnc_location_spawned) or _wasCaptured
	};

	// successful attack => lose marker
	if (_wasCaptured) then {
		[_location] remoteExec ["AS_fnc_location_lose",2];
	};
};

// wait for despawn
waitUntil {sleep 1; !(_location call AS_fnc_location_spawned)};

/////////////////////////////////////////////////////////////////
////////////////////// clean everything /////////////////////////
/////////////////////////////////////////////////////////////////

[_buildings] remoteExec ["AS_fnc_updatedDestroyedBuildings", 2];

{
	if (_location call AS_fnc_location_side == "FIA") then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach _soldados;
{deleteGroup _x} forEach _grupos;
{if (!(_x in AS_P("vehicles"))) then {deleteVehicle _x}} forEach _vehiculos;

{deleteVehicle _x} forEach _civs;
