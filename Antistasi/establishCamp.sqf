if (!isServer) exitWith {};

private ["_tipo","_coste","_grupo","_unit","_tam","_roads","_road","_pos","_camion","_hr","_unidades","_formato"];

_tipo = _this select 0;
_posicionTel = _this select 1;

if (_tipo == "delete") exitWith {
	private _location = [["camp", "FIA"] call AS_fnc_location_TS,_posicionTel] call BIS_fnc_nearestPosition;
	private _position = _location call AS_fnc_location_position;
	private _name = [_location,"name"] call AS_fnc_location_get;
	_location call AS_fnc_location_delete;
	campNames pushBack _name;
	hint format ["Deleting %1", _name];
};

_tipogrupo = "Sentry Team";
_tipoVeh = "B_G_Van_01_transport_F";

_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 60];
_fechalimnum = dateToNumber _fechalim;

private _mrk = createMarker [format ["FIACamp%1", random 1000], _posicionTel];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [50,50];
_mrk setMarkerAlpha 0;

_tsk = ["campsFIA",[side_blue,civilian],["We are sending a team to establish a camp. Send and cover the team until reaches it's destination.","Camp Setup",_mrk],_posicionTel,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;
misiones pushBackUnique _tsk; publicVariable "misiones";
_grupo = [getMarkerPos "FIA_HQ", side_blue, [_tipogrupo] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
_grupo setGroupId ["Watch"];

_tam = 10;
while {true} do {
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

_crate = "Box_FIA_Support_F" createVehicle _pos;
_crate attachTo [_camion,[0.0,-1.2,0.5]];

private _success = false;
waitUntil {sleep 1;
	_success = ({(alive _x) and (_x distance _posicionTel < 10)} count units _grupo > 0);
	({alive _x} count units _grupo == 0) or
	_success or
	(dateToNumber date > _fechalimnum)
};

if (_success) then {
	if (isPlayer leader _grupo) then {
		_owner = (leader _grupo) getVariable ["owner",leader _grupo];
		(leader _grupo) remoteExec ["removeAllActions",leader _grupo];
		_owner remoteExec ["selectPlayer",leader _grupo];
		(leader _grupo) setVariable ["owner",_owner,true];
		{[_x] joinsilent group _owner} forEach units group _owner;
		[group _owner, _owner] remoteExec ["selectLeader", _owner];
		"" remoteExec ["hint",_owner];
		waitUntil {!(isPlayer leader _grupo)};
	};

	// create the camp
	[_mrk, "camp"] call AS_fnc_location_add;
	[_mrk, "side","FIA"] call AS_fnc_location_set;
	private _name = selectRandom campNames;
	campNames = campNames - [_name];
	[_mrk, "name", _name] call AS_fnc_location_set;

	// add the team to the garrison
	private _garrison = [_mrk, "garrison"] call AS_fnc_location_get;
	{
		if (alive _x) then {
			_garrison pushBack (_x call AS_fnc_getFIAUnitType);
		};
	} forEach units _grupo;
	[_mrk, "garrison", _garrison] call AS_fnc_location_set;

	_mrk call AS_fnc_location_updateMarker; // creates the visible marker

	_tsk = ["campsFIA",[side_blue,civilian],["We are sending a team to establish a camp. Send and cover the team until reaches it's destination.","Camp Setup",_mrk],_posicionTel,"SUCCEEDED",5,true,true,"Move"] call BIS_fnc_setTask;
}
else {
	_tsk = ["campsFIA",[side_blue,civilian],["We are sending a team to establish a camp. Send and cover the team until reaches it's destination.","Camp Setup",_mrk],_posicionTel,"FAILED",5,true,true,"Move"] call BIS_fnc_setTask;
	deleteMarker _mrk;
	sleep 3;
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
deleteVehicle _crate;
sleep 15;

[0,_tsk] spawn borrarTask;
