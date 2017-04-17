#include "../macros.hpp"
if (!isServer and hasInterface) exitWith{};

/*
parameters
0: base/airport/carrier to start from
1: target location

If origin is an airport/carrier, the QRF will consist of air cavalry. Otherwise it'll be ground forces in MRAPs.
*/

private _orig = _this select 0;
private _dest = _this select 1;

// names of locations for the task description
private _origName = "the NATO carrier";
private _destName = [([ciudades, _dest] call BIS_fnc_nearestPosition)] call localizar;

// kind of QRF: air/land
private _type = "air";

// FIA bases
private _bases = bases arrayIntersect mrkFIA;

// define type of QRF by type of origin
if (_orig != "spawnNATO") then {
	_origName = [_orig] call localizar;
	if (_orig in _bases) then {
		_type = "land";
	};
};

private _posOrig = getMarkerPos _orig;

// marker on the map, required for the UPS script
private _mrk = createMarker ["NATOQRF", _dest];
_mrk setMarkerShape "ICON";
_mrk setMarkerType "b_support";
_mrk setMarkerText "NATO QRF";

// mission time restricted to 30 minutes
private _tiempolim = 30;
private _fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
private _fechalimnum = dateToNumber _fechalim;

_tsk = ["NATOQRF",
	[side_blue,civilian],
	[format ["Our Commander asked NATO for reinforcements near %1. Their troops will depart from %2.",_destName,_origName],
	"NATO QRF",_mrk],
	_dest,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;
misiones pushBackUnique _tsk; publicVariable "misiones";

// cost: 10 NATO
[-10,0] remoteExec ["prestige",2];

// arrays of all spawned units/groups
private _soldados = [];
private _grupos = [];
private _vehiculos = [];

// initialise groups, two for vehicles, two for dismounts
private _grpVeh1 = createGroup side_blue;
_grupos pushBack _grpVeh1;

private _grpVeh2 = createGroup side_blue;
_grupos pushBack _grpVeh2;

private _grpDis1 = createGroup side_blue;
_grupos pushBack _grpDis1;

private _grpDis2 = createGroup side_blue;
_grupos pushBack _grpDis2;

// air cav
if (_type == "air") then {
	// landing pad, to allow for dismounts
	private _landpos1 = [];
	_landpos1 = [_dest, 0, 150, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
	_landpos1 set [2, 0];
	private _pad1 = createVehicle ["Land_HelipadEmpty_F", _landpos1, [], 0, "NONE"];
	_vehiculos pushBack _pad1;

	// first chopper
	private _vehicle = [_posOrig, 0, selectRandom bluHeliArmed, side_blue] call bis_fnc_spawnvehicle;
	private _heli1 = _vehicle select 0;
	private _heliCrew1 = _vehicle select 1;
	private _grpVeh1 = _vehicle select 2;
	{[_x] spawn NATOinitCA} forEach _heliCrew1;
	[_heli1, "NATO"] call AS_fnc_initVehicle;
	_soldados append _heliCrew1;
	_grupos pushBack _grpVeh1;
	_vehiculos pushBack _heli1;

	// spawn loiter script for armed escort
	[_grpVeh1, _posOrig, _dest, 15*60] spawn fnc_QRF_gunship;

	sleep 5;

	// shift the spawn position of second chopper to avoid crash
	private _pos2 = _posOrig;
	_pos2 set [0, (_posOrig select 0) + 30];
	_pos2 set [2, (_posOrig select 2) + 50];
	private _vehicle2 = [_pos2, 0, selectRandom bluHeliTS, side_blue] call bis_fnc_spawnvehicle;
	private _heli2 = _vehicle2 select 0;
	private _heliCrew2 = _vehicle2 select 1;
	private _grpVeh2 = _vehicle2 select 2;
	{[_x] spawn NATOinitCA} forEach _heliCrew2;
	[_heli2, "NATO"] call AS_fnc_initVehicle;
	_soldados append _heliCrew2;
	_grupos pushBack _grpVeh2;
	_vehiculos pushBack _heli2;

	// add dismounts
	{
		private _soldier = ([_posOrig, 0, _x, _grpDis2] call bis_fnc_spawnvehicle) select 0;
		_soldier assignAsCargo _heli2;
		_soldier moveInCargo _heli2;

		[_soldier] spawn NATOinitCA;
		_soldados pushBack _soldier;
	} forEach bluAirCav;
	_grpDis2 selectLeader (units _grpDis2 select 0);

	// spawn dismount script
	[_grpVeh2, _posOrig, _landpos1, _mrk, _grpDis2, 25*60, "land"] spawn fnc_QRF_airCavalry;
} else { // ground convoy
	private _tam = 10;
	private _roads = [];

	while {true} do {
		_roads = _posOrig nearRoads _tam;
		if (count _roads > 2) exitWith {};
		_tam = _tam + 10;
	};

	// first MRAP, escort
	private _vehicle1 = [position (_roads select 0), 0, bluMRAPHMG select 0, side_blue] call bis_fnc_spawnvehicle;
	private _veh1 = _vehicle1 select 0;
	[_veh1, "NATO"] call AS_fnc_initVehicle;
	[_veh1,"NATO Armor"] spawn inmuneConvoy;
	private _vehCrew1 = _vehicle1 select 1;
	private _grpVeh1 = _vehicle1 select 2;
	{[_x] spawn NATOinitCA; _soldados pushBack _x} forEach _vehCrew1;
	_vehiculos pushBack _veh1;

	// add dismounts
	{
		private _soldier = ([_posOrig, 0, _x, _grpDis1] call bis_fnc_spawnvehicle) select 0;
		_soldier assignAsCargo _veh1;
		_soldier moveInCargo _veh1;

		[_soldier] spawn NATOinitCA;
		_soldados pushBack _soldier;
	} forEach bluMRAPHMGgroup;
	_grpDis1 selectLeader (units _grpDis1 select 0);

	// spawn dismount script
	[_grpVeh1, _posOrig, _dest, _mrk, _grpDis1, 25*60] spawn fnc_QRF_leadVehicle;

	sleep 15;

	// second MRAP
	private _vehicle2 = [position (_roads select 1), 0, selectRandom bluMRAP, side_blue] call bis_fnc_spawnvehicle;
	private _veh2 = _vehicle2 select 0;
	[_veh2, "NATO"] call AS_fnc_initVehicle;
	[_veh2,"NATO Armor"] spawn inmuneConvoy;
	private _vehCrew2 = _vehicle2 select 1;
	private _grpVeh2 = _vehicle2 select 2;
	{[_x] spawn NATOinitCA; _soldados pushBack _x} forEach _vehCrew2;
	_vehiculos pushBack _veh2;

	// add dismounts
	{
		private _soldier = ([_posOrig, 0, _x, _grpDis2] call bis_fnc_spawnvehicle) select 0;
		_soldier assignAsCargo _veh2;
		_soldier moveInCargo _veh2;

		[_soldier] spawn NATOinitCA;
		_soldados pushBack _soldier;
	} forEach bluMRAPgroup;
	_grpDis2 selectLeader (units _grpDis2 select 0);

	// spawn dismount script
	private _pos3 = +_dest;
	_xshift3 = (_dest select 0) + 30;
	_pos3 set [0, _xshift3];
	[_grpVeh2, _posOrig, _pos3, _mrk, _grpDis2, 25, "assault"] call fnc_QRF_dismountTroops;
};

{
	_x setVariable ["esNATO",true,true];
} foreach _grupos;


// you lose if all soldiers die before the timer runs out
waitUntil {sleep 10; (dateToNumber date > _fechalimnum) or ({alive _x} count _soldados == 0)};

if (dateToNumber date > _fechalimnum) then {
	_tsk = ["NATOQRF",[side_blue,civilian],[format ["Our Commander asked NATO for reinforcements near %1. Their troops will depart from %2",_destName,_origName],"NATO QRF",_mrk],_dest,"SUCCEEDED",5,true,true,"Move"] call BIS_fnc_setTask;
}
else {
	_tsk = ["NATOQRF",[side_blue,civilian],[format ["Our Commander asked NATO for reinforcements near %1. Their troops will depart from %2",_destName,_origName],"NATO QRF",_mrk],_dest,"FAILED",5,true,true,"Move"] call BIS_fnc_setTask;
	[-5,0] remoteExec ["prestige",2];
};

sleep 15;
deleteMarker "NATOQRF";
[0,_tsk] spawn borrarTask;

// despawn everything
{
	_soldado = _x;
	waitUntil {sleep 1; {_x distance _soldado < AS_P("spawnDistance")} count (allPlayers - hcArray) == 0};
	deleteVehicle _soldado;
} forEach _soldados;

{deleteGroup _x} forEach _grupos;

{
	_vehiculo = _x;
	waitUntil {sleep 1; {_x distance _vehiculo < AS_P("spawnDistance")/2} count (allPlayers - hcArray) == 0};
	deleteVehicle _x
} forEach _vehiculos;
