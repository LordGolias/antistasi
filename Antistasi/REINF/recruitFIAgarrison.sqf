params ["_tipo"];
private _location = posicionGarr;  // sent via global variable
private ["_hr","_resourcesFIA","_coste","_marcador","_garrison","_posicion","_unit","_grupo","_veh","_pos","_salir"];

_hr = server getVariable "hr";

if (_hr < 1) exitWith {hint "You lack of HR to make a new recruitment"};

_resourcesFIA = server getVariable "resourcesFIA";

if (closeMarkersUpdating > 0) exitWith {hint format ["We are currently adding garrison units to this zone. HQ nearby zones require more time to add garrisons.\n\nPlease try again in %1 seconds.",closeMarkersUpdating]};

_coste = AS_data_allCosts getVariable _tipo;
_salir = false;

if (_tipo == "b_g_soldier_unarmed_f") then{
	_coste = _coste + (["B_G_Mortar_01_F"] call vehiclePrice);
};

if (_coste > _resourcesFIA) exitWith {hint format ["You do not have enough money for this kind of unit (%1 € needed)",_coste]};

_marcador = [marcadores, _location] call BIS_fnc_nearestPosition;
_posicion = getMarkerPos _marcador;

private _enemiesClose = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance _posicion < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;
if (_enemiesClose) exitWith {Hint "You cannot Recruit Garrison Units with enemies near the zone"};

[-1,-_coste] remoteExec ["resourcesFIA",2];
_garrison = garrison getVariable [_marcador,[]];
_garrison = _garrison + [_tipo];
garrison setVariable [_marcador,_garrison,true];
[_marcador] call mrkUpdate;
hint format ["Soldier recruited.%1",[_marcador] call garrisonInfo];

if (spawner getVariable _marcador) then {
	closeMarkersUpdating = 10;
	_forzado = false;
	if (_marcador in forcedSpawn) then {forcedSpawn = forcedSpawn - [_marcador]; publicVariable "forcedSpawn"; _forzado = true};
	[_marcador] remoteExec ["tempMoveMrk",2];
	[_marcador] spawn {
		params ["_marcador"];
		while {closeMarkersUpdating > 1} do
			{
			sleep 1;
			closeMarkersUpdating = closeMarkersUpdating - 1;
			};
		waitUntil {getMarkerPos _marcador distance [0,0,0] > 10};
		closeMarkersUpdating = 0;
	};
	if (_forzado) then {forcedSpawn pushBackUnique _marcador; publicVariable "forcedSpawn"};
};
