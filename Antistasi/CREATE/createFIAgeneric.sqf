if (!isServer and hasInterface) exitWith{};
params ["_marcador"];

private _soldados = [];
private _grupos = [];
private _vehiculos = [];
private _civs = [];

private _posicion = getMarkerPos (_marcador);
private _size = [_marcador] call sizeMarker;

if (_marcador != "FIA_HQ") then {
	// The flag
	private _veh = createVehicle ["Flag_FIA_F", _posicion, [],0, "CAN_COLLIDE"];
	_veh allowDamage false;
	_vehiculos pushBack _veh;
	[[_veh,"unit"],"flagaction"] call BIS_fnc_MP;
	[[_veh,"vehicle"],"flagaction"] call BIS_fnc_MP;
	[[_veh,"garage"],"flagaction"] call BIS_fnc_MP;
	if (_marcador in puertos) then {
		[[_veh,"seaport"],"flagaction"] call BIS_fnc_MP;
	};

	// worker civilians in non-military non-destroyed markers
	if (!(_marcador in puestos) and !(_marcador in destroyedCities)) then {
		if ((daytime > 8) and (daytime < 18)) then {
			private _grupo = createGroup civilian;
			_grupos pushBack _grupo;
			for "_i" from 1 to 8 do {
				_civ = _grupo createUnit ["C_man_w_worker_F", _posicion, [],0, "NONE"];
				[_civ] spawn AS_fnc_initUnitCIV;
				_civs pushBack _civ;
				sleep 0.5;
			};
			[_marcador,_civs] spawn destroyCheck;  // power shuts if everyone is killed
			[leader _grupo, _marcador, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX","NOVEH2"] execVM "scripts\UPSMON.sqf";
		};
	};
};

private _buildings = [];
if (_marcador in puestos) then {
	// populate military buildings
	_buildings = nearestObjects [_posicion, listMilBld, _size*1.5];

	// if close to an antenna, add jam option
	private _ant = [antenas,_posicion] call BIS_fnc_nearestPosition;
	if (getPos _ant distance _posicion < 100) then {
		[[_veh,"jam"],"flagaction"] call BIS_fnc_MP;
	};
};

// Create the garrison
(_marcador call AS_fnc_createFIAgarrison) params ["_soldados1", "_grupos1", "_vehiculos1"];
_soldados append _soldados1;
_grupos append _grupos1;
_vehiculos append _vehiculos1;

private _journalist = [_marcador, _grupos] call AS_fnc_createJournalist;

// wait for despawn due to despawn or successful attack
waitUntil {sleep 1;
	(!(spawner getVariable _marcador)) or
	(({not(vehicle _x isKindOf "Air")} count ([_size,0,_posicion,"OPFORSpawn"] call distanceUnits)) > 3*(({alive _x} count _soldados) + count ([_size,0,_posicion,"BLUFORSpawn"] call distanceUnits)))};

if (_marcador != "FIA_HQ") then {
	// successful attack => lose marker
	if (spawner getVariable _marcador) then {
		[_marcador] remoteExec ["mrkLOOSE",2];
	};
};

// wait to despawn
waitUntil {sleep 1; !(spawner getVariable _marcador)};

{
	if ((!alive _x) and !(_x in destroyedBuildings)) then {
		destroyedBuildings pushBack (position _x);
	};
	publicVariableServer "destroyedBuildings";
} forEach _buildings;

{
	if (_marcador in mrkFIA) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach _soldados;

{deleteGroup _x} forEach _grupos;
{deleteVehicle _x} forEach _civs;
if (!isNull _journalist) then {deleteVehicle _journalist};
{if (!(_x in staticsToSave)) then {deleteVehicle _x}} forEach _vehiculos;
