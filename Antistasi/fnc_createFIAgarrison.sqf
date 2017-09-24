#include "macros.hpp"
private _location = _this;

private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;
private _estaticas = AS_P("vehicles") select {_x distance _posicion < _size};
private _garrison = _location call AS_location_fnc_garrison;

private _grupoMort = grpNull;
private _grupoEst = grpNull;

private _grupo = createGroup side_blue;
_grupos = _grupos + [_grupo];
{
	if !(_location call AS_location_fnc_spawned) exitWith {};
	private _unit = objNull;
	call {
		if (_x == "Crew") exitWith {
            if (isNull _grupoMort) then {
                _grupoMort = createGroup side_blue;
            };
			_unit = _grupoMort createUnit [_x call AS_fnc_getFIAUnitClass, _posicion, [], 0, "NONE"];
			private _veh = "B_G_Mortar_01_F" createVehicle ([_posicion] call AS_fnc_findMortarCreatePosition);
			_vehiculos = _vehiculos + [_veh];
			[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
			_unit assignAsGunner _veh;
			_unit moveInGunner _veh;
			[_veh, "FIA"] call AS_fnc_initVehicle;
		};
		if ((_x == "Rifleman") and (count _estaticas > 0)) exitWith {
			private _estatica = _estaticas select 0;
			if (typeOf _estatica == "B_G_Mortar_01_F") then {
                if (isNull _grupoMort) then {
                    _grupoMort = createGroup side_blue;
                };
				_unit = _grupoMort createUnit [_x call AS_fnc_getFIAUnitClass, _posicion, [], 0, "NONE"];
				_unit moveInGunner _estatica;
				[_estatica] execVM "scripts\UPSMON\MON_artillery_add.sqf";
			} else {
                if (isNull _grupoEst) then {
                    _grupoEst = createGroup side_blue;
                };
				_unit = _grupoEst createUnit [_x call AS_fnc_getFIAUnitClass, _posicion, [], 0, "NONE"];
				_unit moveInGunner _estatica;
			};
			_estaticas = _estaticas - [_estatica];
		};

		_unit = _grupo createUnit [_x call AS_fnc_getFIAUnitClass, _posicion, [], 0, "NONE"];
		if (_x == "Squad Leader") then {_grupo selectLeader _unit};
	};
	[_unit,false,_location] call AS_fnc_initUnitFIA;
	_soldados pushBack _unit;
	sleep 0.5;

	// create a new group for every 8 units
	if (count units _grupo == 8) then {
		_grupo = createGroup side_blue;
		_grupos pushBack _grupo;
	};
} forEach _garrison;

// give orders to the groups
{
	[leader _x, _location, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] spawn UPSMON;
} forEach _grupos;

if !(isNull _grupoMort) then {
	_grupos pushBack _grupoMort;
};
if !(isNull _grupoEst) then {
	_grupos pushBack _grupoEst;
};

[_soldados, _grupos, _vehiculos]
