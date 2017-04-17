if (!isServer) exitWith {};

private ["_tipo","_coste","_grupo","_unit","_tam","_roads","_road","_pos","_camion","_hr","_unidades","_formato"];

_tipo = _this select 0;
_posicionTel = _this select 1;

if (_tipo == "delete") exitWith {
	private _location = [[["roadblock","watchpost"],"FIA"] call AS_fnc_location_TS,_posicionTel] call BIS_fnc_nearestPosition;
	private _type = _location call AS_fnc_location_type;
	_coste = 0;
	_hr = 0;
	_tipogrupo = "Sniper Team";
	if (_type == "roadblock") then {
		_tipogrupo = "AT Team";
	};
	([_tipogrupo] call AS_fnc_getFIASquadCost) params ["_cost1", "_hr1"];
	_coste = _coste + _cost1;
	_hr = _hr + _hr1;
	[_hr,_coste] remoteExec ["resourcesFIA",2];

	[_location] call AS_fnc_location_delete;
};

_escarretera = isOnRoad _posicionTel;

private _locationType = "watchpost";
_tipogrupo = "Sniper Team";
_tipoVeh = "B_G_Quadbike_01_F";

if (_escarretera) then {
	_locationType = "roadblock";
	_tipogrupo = "AT Team";
	_tipoVeh = "B_G_Offroad_01_F";
};

_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 60];
_fechalimnum = dateToNumber _fechalim;

// this is a hidden marker used by the task and for location
private _mrk = createMarker [format ["FIAroadblock%1", random 1000], _posicionTel];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [50,50];
_mrk setMarkerAlpha 0;

_tsk = ["PuestosFIA",[side_blue,civilian],["The team to establish an Observation Post or Roadblock is ready. Send it to the destination.","Post \ Roadblock Deploy",_mrk],_posicionTel,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;
misiones pushBackUnique _tsk; publicVariable "misiones";
_grupo = [getMarkerPos "FIA_HQ", side_blue, [_tipogrupo] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
_grupo setGroupId ["Watch"];

_tam = 10;
while {true} do
	{
	_roads = getMarkerPos "FIA_HQ" nearRoads _tam;
	if (count _roads < 1) then {_tam = _tam + 10};
	if (count _roads > 0) exitWith {};
	};
_road = _roads select 0;
_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
_camion = _tipoVeh createVehicle _pos;
[_grupo] spawn dismountFIA;
_grupo addVehicle _camion;
{[_x] call AS_fnc_initUnitFIA} forEach units _grupo;
leader _grupo setBehaviour "SAFE";
AS_commander hcSetGroup [_grupo];
_grupo setVariable ["isHCgroup", true, true];

waitUntil {sleep 1; ({alive _x} count units _grupo == 0) or ({(alive _x) and (_x distance _posicionTel < 10)} count units _grupo > 0) or (dateToNumber date > _fechalimnum)};

if ({(alive _x) and (_x distance _posicionTel < 10)} count units _grupo > 0) then
	{
	if (isPlayer leader _grupo) then
		{
		_owner = (leader _grupo) getVariable ["owner",leader _grupo];
		(leader _grupo) remoteExec ["removeAllActions",leader _grupo];
		_owner remoteExec ["selectPlayer",leader _grupo];
		(leader _grupo) setVariable ["owner",_owner,true];
		{[_x] joinsilent group _owner} forEach units group _owner;
		[group _owner, _owner] remoteExec ["selectLeader", _owner];
		"" remoteExec ["hint",_owner];
		waitUntil {!(isPlayer leader _grupo)};
		};

	[_mrk,_locationType] call AS_fnc_location_add;
	[_mrk,"side","FIA"] call AS_fnc_location_set;
	_mrk call AS_fnc_location_updateMarker; // creates the visible marker

	_tsk = ["PuestosFIA",[side_blue,civilian],["The team to establish an Observation Post or Roadblock is ready. Send it to the destination.","Post \ Roadblock Deploy",_mrk],_posicionTel,"SUCCEEDED",5,true,true,"Move"] call BIS_fnc_setTask;
	[-5,5,_posiciontel] remoteExec ["citySupportChange",2];
	}
else {
	_tsk = ["PuestosFIA",[side_blue,civilian],["The team to establish an Observation Post or Roadblock is ready. Send it to the destination.","Post \ Roadblock Deploy",_mrk],_posicionTel,"FAILED",5,true,true,"Move"] call BIS_fnc_setTask;
	sleep 3;
	deleteMarker _mrk;
};

AS_commander hcRemoveGroup _grupo;
{
	if (alive _x) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;

		deleteVehicle _x;
	};
} forEach units _grupo;
deleteVehicle _camion;
deleteGroup _grupo;
sleep 15;

[0,_tsk] spawn borrarTask;
