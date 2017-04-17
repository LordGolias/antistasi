if (!isServer and hasInterface) exitWith {};
params ["_location"];

private _posicion = _location call AS_fnc_location_position;

private _vehicles = [];

private _escarretera = false;
if (isOnRoad _posicion) then {_escarretera = true};

private _advanced = false;
// BE module
if (hayBE) then {
	if (BE_current_FIA_RB_Style == 1) exitWith {_advanced = true};
};
// BE module

if (_escarretera) then {
	if (_advanced) then {
		_data = [_posicion] call fnc_RB_placeDouble;
		_vehicles = _data select 0;
		sleep 1;

		_infData = _data select 2;
		_grupo = [(_infData select 0), side_blue, ["AT Team"] call AS_fnc_getFIASquadConfig, [], [], [], [], [], (_infData select 1)] call BIS_Fnc_spawnGroup;
		(_data select 1) joinSilent _grupo;
	} else {
		_tam = 1;

		while {true} do
			{
			_road = _posicion nearRoads _tam;
			if (count _road > 0) exitWith {};
			_tam = _tam + 5;
			};

		_roadcon = roadsConnectedto (_road select 0);
		_dirveh = [_road select 0, _roadcon select 0] call BIS_fnc_DirTo;


		_veh = "B_G_Offroad_01_armed_F" createVehicle getPos (_road select 0);
		_vehicles pushBack _veh;
		_veh setDir _dirveh + 90;
		_veh lock 3;
		[_veh, "FIA"] call AS_fnc_initVehicle;
		sleep 1;

		_grupo = [_posicion, side_blue, ["AT Team"] call AS_fnc_getFIASquadConfig, [], [], [], [], [], _dirveh] call BIS_Fnc_spawnGroup;
		_unit = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
	};
}
else {
	_grupo = [_posicion, side_blue, ["Sniper Team"] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
	_grupo setBehaviour "STEALTH";
	_grupo setCombatMode "GREEN";
	if (_advanced) then {
		private _posDes = [_posicion, 5, round (random 359)] call BIS_Fnc_relPos;
		private _remDes = ([_posDes, 0,"B_Static_Designator_01_F", side_blue] call bis_fnc_spawnvehicle) select 0;
		_remDes setVectorUp (surfaceNormal (position _remDes));
		_vehicles pushBack _remDes;
	};
};

{[_x,false] spawn AS_fnc_initUnitFIA;} forEach units _grupo;

waitUntil {sleep 5;
	!(_location call AS_fnc_location_spawned) or
	({alive _x} count units _grupo == 0) or
	!(_location call AS_fnc_location_exists)
};

if ({alive _x} count units _grupo == 0) then {
	_location call AS_fnc_location_delete;
	[5,-5,_posicion] remoteExec ["citySupportChange",2];
	if (_escarretera) then {
		[["TaskFailed", ["", "Roadblock Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	} else {
		[["TaskFailed", ["", "Watchpost Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
};

waitUntil {sleep 1;
	!(_location call AS_fnc_location_spawned) or
	!(_location call AS_fnc_location_exists)
};

if ((_advanced) || (_escarretera)) then {
	{deleteVehicle _x;} forEach _vehicles;
};

{
	if (_location call AS_fnc_location_exists) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach units _grupo;
deleteGroup _grupo;
