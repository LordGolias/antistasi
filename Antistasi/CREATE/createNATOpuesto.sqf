if (!isServer and hasInterface) exitWith {};

private ["_marcador","_posicion","_escarretera","_tam","_road","_veh","_grupo","_unit","_roadcon"];

_marcador = _this select 0;
_posicion = getMarkerPos _marcador;

_NATOSupp = server getVariable "prestigeNATO";

_grupo = createGroup side_blue;


_tam = 1;

while {true} do {
	_road = _posicion nearRoads _tam;
	if (count _road > 0) exitWith {};
	_tam = _tam + 5;
};

_roadcon = roadsConnectedto (_road select 0);
_dirveh = [_road select 0, _roadcon select 0] call BIS_fnc_DirTo;

_objs = [];

if (hayUSAF) then {
	_objs = [getpos (_road select 0), _dirveh, call (compile (preprocessFileLineNumbers "Compositions\cmpUSAF_RB.sqf"))] call BIS_fnc_ObjectsMapper;
}
else {
	_objs = [getpos (_road select 0), _dirveh, call (compile (preprocessFileLineNumbers "Compositions\cmpNATO_RB.sqf"))] call BIS_fnc_ObjectsMapper;
};


_vehArray = [];
_turretArray = [];
_tempPos = [];
{
	call {
		if (typeOf _x in bluAPC) exitWith {_vehArray pushBack _x;};
		if (typeOf _x in bluStatHMG) exitWith {_turretArray pushBack _x;};
		if (typeOf _x in bluStatAA) exitWith {_turretArray pushBack _x;};
		if (typeOf _x == "Land_Camping_Light_F") exitWith {_tempPos = _x;};
	};
} forEach _objs;

_veh = _vehArray select 0;
_HMG = _turretArray select 0;
_AA1 = _turretArray select 1;
_AA2 = _turretArray select 2;

if (_NATOSupp < 50) then {
	_AA1 enableSimulation false;
    _AA1 hideObjectGlobal true;

	if !(hayUSAF) then {
   		_AA2 enableSimulation false;
    	_AA2 hideObjectGlobal true;
	};
}
else {
	_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
	_unit moveInGunner _AA1;

	if !(hayUSAF) then {
		_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _AA2;
	};
};

sleep 1;

_veh lock 3;

[_veh] spawn NATOVEHinit;
_veh allowCrewInImmobile true;
sleep 1;

_tipoGrupo = [bluATTeam, side_blue] call fnc_pickGroup;
_grupoInf = [getpos _tempPos, side_blue, _tipoGrupo] call BIS_Fnc_spawnGroup;

_infdir = _dirveh + 180;
if (_infdir >= 360) then {_infdir = _infdir - 360};
_grupoInf setFormDir _infdir;

_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
_unit moveInGunner _HMG;
_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
_unit moveInGunner _veh;
_unit = ([_posicion, 0, bluCrew, _grupo] call bis_fnc_spawnvehicle) select 0;
_unit moveInCommander _veh;

{[_x] spawn NATOinitCA} forEach units _grupo;
{[_x] spawn NATOinitCA} forEach units _grupoInf;


waitUntil {sleep 1; (not(spawner getVariable _marcador)) or (({alive _x} count units _grupo == 0) && ({alive _x} count units _grupoInf == 0)) or (not(_marcador in puestosNATO))};

if ({alive _x} count units _grupo == 0) then {
	puestosNATO = puestosNATO - [_marcador]; publicVariable "puestosNATO";
	marcadores = marcadores - [_marcador]; publicVariable "marcadores";
	[5,-5,_posicion] remoteExec ["citySupportChange",2];
	deleteMarker _marcador;
	[["TaskFailed", ["", "Roadblock Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
};

waitUntil {sleep 1; (not(spawner getVariable _marcador)) or (not(_marcador in puestosNATO))};

{deleteVehicle _x} forEach _vehArray + _turretArray;
{deleteVehicle _x} forEach units _grupo;
deleteGroup _grupo;

{deleteVehicle _x} forEach units _grupoInf;
deleteGroup _grupoInf;

{deleteVehicle _x} forEach _objs;