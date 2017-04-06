if (!isServer and hasInterface) exitWith{};

_tskTitle = localize "STR_tsk_resPrisoners";
_tskDesc = localize "STR_tskDesc_resPrisoners";

private ["_unit","_marcador","_posicion"];

_marcador = _this select 0;
_posicion = getMarkerPos _marcador;

_POWs = [];

_tiempolim = 120;//120
_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_nombredest = [_marcador] call localizar;

_tsk = ["RES",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_marcador],_posicion,"CREATED",5,true,true,"run"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

_blacklistbld = ["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F"];
_poscasa = [];
_cuenta = 0;
_casas = nearestObjects [_posicion, ["house"], 50];
_casa = "";
_posibles = [];
for "_i" from 0 to (count _casas) - 1 do
	{
	_casa = (_casas select _i);
	_poscasa = [_casa] call BIS_fnc_buildingPositions;
	if ((count _poscasa > 1) and (not (typeOf _casa in _blacklistbld))) then {_posibles = _posibles + [_casa];};
	};

if (count _posibles > 0) then
	{
	_casa = _posibles call BIS_Fnc_selectRandom;
	_poscasa = [_casa] call BIS_fnc_buildingPositions;
	_cuenta = (count _poscasa) - 1;
	if (_cuenta > 10) then {_cuenta = 10};
	}
else
	{
	_cuenta = round random 10;
	for "_i" from 0 to _cuenta do
		{
		_postmp = [_posicion, 5, random 360] call BIS_Fnc_relPos;
		_poscasa = _poscasa + [_postmp];
		};
	};
_grpPOW = createGroup side_blue;
for "_i" from 0 to _cuenta do
	{
	_unit = _grpPOW createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, (_poscasa select _i), [], 0, "NONE"];
	_unit allowDamage false;
	_unit setCaptive true;
	_unit disableAI "MOVE";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "TARGET";
	_unit setUnitPos "UP";
	_unit setBehaviour "CARELESS";
	_unit allowFleeing 0;
	//_unit disableAI "ANIM";
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	sleep 1;
	//if (alive _unit) then {_unit playMove "UnaErcPoslechVelitele1";};
	_POWS = _POWS + [_unit];
	[[_unit,"prisionero"],"flagaction"] call BIS_fnc_MP;
	};

sleep 5;

{_x allowDamage true} forEach _POWS;

waitUntil {sleep 1; ({alive _x} count _POWs == 0) or ({(alive _x) and (_x distance getMarkerPos "respawn_west" < 50)} count _POWs > 0) or (dateToNumber date > _fechalimnum)};

if (dateToNumber date > _fechalimnum) then
	{
	if (not (spawner getVariable _marcador)) then
		{
		{
		if (group _x == _grpPOW) then
			{
			_x setDamage 1;
			};
		} forEach _POWS;
		}
	else
		{
		{
		if (group _x == _grpPOW) then
			{
			_x setCaptive false;
			_x enableAI "MOVE";
			_x doMove _posicion;
			};
		} forEach _POWS;
		};
	};

waitUntil {sleep 1; ({alive _x} count _POWs == 0) or ({(alive _x) and (_x distance getMarkerPos "respawn_west" < 50)} count _POWs > 0)};

if ({alive _x} count _POWs == 0) then
	{
	_tsk = ["RES",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_marcador],_posicion,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
	{_x setCaptive false} forEach _POWs;
	_cuenta = 2 * (count _POWs);
	[_cuenta,0] remoteExec ["prestige",2];
	[-10,AS_commander] call playerScoreAdd;
	};

if ({(alive _x) and (_x distance getMarkerPos "respawn_west" < 50)} count _POWs > 0) then
	{
	_tsk = ["RES",[side_blue,civilian],[format [_tskDesc,_nombredest,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4],_tskTitle,_marcador],_posicion,"SUCCEEDED",5,true,true,"run"] call BIS_fnc_setTask;
	_cuenta = {(alive _x) and (_x distance getMarkerPos "respawn_west" < 150)} count _POWs;
	_hr = 2 * (_cuenta);
	_resourcesFIA = 100 * _cuenta;
	[_hr,_resourcesFIA] remoteExec ["resourcesFIA",2];
	[0,10,_posicion] remoteExec ["citySupportChange",2];
	[_cuenta,0] remoteExec ["prestige",2];
	{if (_x distance getMarkerPos "respawn_west" < 500) then {[_cuenta,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[round (_cuenta/2),AS_commander] call playerScoreAdd;
	{[_x] join _grpPOW; [_x] orderGetin false} forEach _POWs;
	// BE module
	if (hayBE) then {
		["mis"] remoteExec ["fnc_BE_XP", 2];
	};
	// BE module
	};

sleep 60;
{deleteVehicle _x} forEach _POWs;
deleteGroup _grpPOW;

[1200,_tsk] spawn borrarTask;
