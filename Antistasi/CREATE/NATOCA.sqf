#include "../macros.hpp"
params ["_location"];
if (!isServer and hasInterface) exitWith {};

private _posicion = _location call AS_fnc_location_position;
private _name = [_location] call localizar;

private _aeropuertos = ["airfield", "FIA"] call AS_fnc_location_TS;
_aeropuertos pushBack "spawnNATO";

private _origin = [_aeropuertos,_posicion] call BIS_fnc_nearestPosition;
private _origpos = _origin call AS_fnc_location_position;
private _origname = "the NATO Carrier";
if (_origin != "spawnNATO") then {_origname = [_origin] call localizar};

private _threatEval = [_posicion] call AAthreatEval;

_tsk = ["NATOCA",
	[side_blue,civilian],
	[format ["Our Commander asked NATO for an attack on %1. Help them in order to have success in this operation. Their attack will depart from %2",_name,_origname],
	"NATO Attack",_location],_posicion,"CREATED",5,true,true,"Attack"] call BIS_fnc_setTask;
misiones pushBackUnique _tsk; publicVariable "misiones";
private _soldados = [];
private _grupos = [];
private _vehiculos = [];

private _cuenta = round (AS_P("prestigeNATO")/10);

[-20,0] remoteExec ["prestige",2];

if ((_origin call AS_location_type) in ["base", "airfield"]) then {
	[_location] spawn artilleriaNATO;
};

for "_i" from 1 to _cuenta do {
	private _tipoveh = planesNATOTrans call BIS_fnc_selectRandom;
	private _vehicle = [_origpos, 0, _tipoveh, side_blue] call bis_fnc_spawnvehicle;
	private _heli = _vehicle select 0;
	private _heliCrew = _vehicle select 1;
	private _grupoheli = _vehicle select 2;
	{[_x] spawn NATOinitCA} forEach _heliCrew;
	[_heli, "NATO"] call AS_fnc_initVehicle;
	_soldados append _heliCrew;
	_grupos pushBack _grupoheli;
	_vehiculos pushBack _heli;

	{_x setBehaviour "CARELESS";} forEach units _grupoheli;
	[_heli,"NATO Air Transport"] spawn inmuneConvoy;

	if (_tipoveh in bluHeliDis) then {
		_tipoGrupo = [bluSquadWeapons, side_blue] call fnc_pickGroup;
		_grupo = [_orig, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados pushBack _x; [_x] spawn NATOinitCA} forEach units _grupo;
		_grupos pushBack _grupo;
		if ((_origin call AS_location_type == "airfield") or (random 10 < _threatEval)) then {
			[_heli,_grupo,_posicion,_threatEval] spawn airdrop;
		} else {
			if ((_location call AS_location_type) in ["base","watchpost"]) then {[_heli,_grupo,_posicion,_orig,_grupoheli] spawn fastropeNATO;};
			if ((_location call AS_location_type) in ["resource","factory", "powerplant"]) then {
				{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
				_landpos = [];
				_landpos = [_posicion, 0, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
				_landPos set [2, 0];
				_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
				_vehiculos = _vehiculos + [_pad];
				_wp0 = _grupoheli addWaypoint [_landpos, 0];
				_wp0 setWaypointType "TR UNLOAD";
				_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
				[_grupoheli,0] setWaypointBehaviour "CARELESS";
				_wp3 = _grupo addWaypoint [_landpos, 0];
				_wp3 setWaypointType "GETOUT";
				_wp0 synchronizeWaypoint [_wp3];
				_wp4 = _grupo addWaypoint [_posicion, 1];
				_wp4 setWaypointType "SAD";
				_wp2 = _grupoheli addWaypoint [_origpos, 1];
				_wp2 setWaypointType "MOVE";
				_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
				[_grupoheli,1] setWaypointBehaviour "AWARE";
				[_heli,true] spawn puertasLand;
			};
		};
	};
	if (_tipoveh in bluHeliTS) then {
		{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
		_tipoGrupo = [bluTeam, side_blue] call fnc_pickGroup;
		_grupo = [_origpos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados pushBack _x; [_x] spawn NATOinitCA} forEach units _grupo;
		_grupos pushBack _grupo;
		_landpos = [];
		_landpos = [_posicion, 0, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		_landPos set [2, 0];
		_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
		_vehiculos = _vehiculos + [_pad];
		_wp0 = _grupoheli addWaypoint [_landpos, 0];
		_wp0 setWaypointType "TR UNLOAD";
		_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
		[_grupoheli,0] setWaypointBehaviour "CARELESS";
		_wp3 = _grupo addWaypoint [_landpos, 0];
		_wp3 setWaypointType "GETOUT";
		_wp0 synchronizeWaypoint [_wp3];
		_wp4 = _grupo addWaypoint [_posicion, 1];
		_wp4 setWaypointType "SAD";
		_wp2 = _grupoheli addWaypoint [_origpos, 1];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
		[_grupoheli,1] setWaypointBehaviour "AWARE";
		[_heli,true] spawn puertasLand;
	};
	if (_tipoveh in bluHeliRope) then {
		{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
		_tipoGrupo = [bluSquad, side_blue] call fnc_pickGroup;
		_grupo = [_orig, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados pushBack _x; [_x] spawn NATOinitCA} forEach units _grupo;
		_grupos pushBack _grupo;
		if ((_location call AS_location_type) in ["airfield","base", "watchpost"] or (random 10 < _threatEval)) then {
			[_heli,_grupo,_posicion,_threatEval] spawn airdrop;
		} else {
			_landpos = [];
			_landpos = [_posicion, 0, 300, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
			_landPos set [2, 0];
			_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
			_vehiculos = _vehiculos + [_pad];
			_wp0 = _grupoheli addWaypoint [_landpos, 0];
			_wp0 setWaypointType "TR UNLOAD";
			_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
			[_grupoheli,0] setWaypointBehaviour "CARELESS";
			_wp3 = _grupo addWaypoint [_landpos, 0];
			_wp3 setWaypointType "GETOUT";
			_wp0 synchronizeWaypoint [_wp3];
			_wp4 = _grupo addWaypoint [_posicion, 1];
			_wp4 setWaypointType "SAD";
			_wp2 = _grupoheli addWaypoint [_origpos, 1];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
			[_grupoheli,1] setWaypointBehaviour "AWARE";
			[_heli,true] spawn puertasLand;
		};
	};
	sleep 30;
};

private _solMax = round ((count _soldados) / 4);

waitUntil {sleep 1; (_location call AS_fnc_location_side == "FIA") or ({alive _x} count _soldados < _solMax)};

if ({alive _x} count _soldados < _solMax) then {
	_tsk = ["NATOCA",[side_blue,civilian],[format ["Our Commander asked NATO for an attack on %1. Help them in order to have success in this operation. Their attack will depart from %2",_nombredest,_nombreorig],
		"NATO Attack",_location],_posicion,"FAILED",5,true,true,"Attack"] call BIS_fnc_setTask;
	[-10,0] remoteExec ["prestige",2];
};

sleep 15;

[0,_tsk] spawn borrarTask;
{
_soldado = _x;
waitUntil {sleep 1; {_x distance _soldado < AS_P("spawnDistance")} count (allPlayers - hcArray) == 0};
deleteVehicle _soldado;
} forEach _soldados;
{deleteGroup _x} forEach _grupos;
{
_vehiculo = _x;
waitUntil {sleep 1; {_x distance _vehiculo < AS_P("spawnDistance")/2} count (allPlayers - hcArray) == 0};
deleteVehicle _x} forEach _vehiculos;
