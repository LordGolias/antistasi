if (!isServer and hasInterface) exitWith{};
params ["_location"];

private _posicion = _location call AS_fnc_location_position;
private _nombredest = [_location] call localizar;
private _size = _location call AS_fnc_location_size;

_tskTitle = localize "STR_tsk_resRefugees";
_tskDesc = localize "STR_tskDesc_resRefugees";

_POWs = [];

_casas = nearestObjects [_posicion, ["house"], _size];
_poscasa = [];
_casa = _casas select 0;
while {count _poscasa < 5} do
	{
	_casa = _casas call BIS_Fnc_selectRandom;
	_poscasa = [_casa] call BIS_fnc_buildingPositions;
	if (count _poscasa < 5) then {_casas = _casas - [_casa]};
	};

_tsk = ["RES",[side_blue,civilian],[format [_tskDesc,_nombredest, A3_STR_INDEP],
	_tskTitle,_location],getPos _casa,"CREATED",5,true,true,"run"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

_grupo = createGroup side_blue;

_num = count _poscasa;
if (_num > 8) then {_num = 8};

for "_i" from 1 to (_num) - 1 do
	{
	_unit = _grupo createUnit [["Survivor"] call AS_fnc_getFIAUnitClass, _poscasa select _i, [], 0, "NONE"];
	_unit allowdamage false;
	_unit disableAI "MOVE";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "TARGET";
	_unit setBehaviour "CARELESS";
	_unit allowFleeing 0;
	_unit setSkill 0;
	_POWs = _POWs + [_unit];
	[[_unit,"refugiado"],"flagaction"] call BIS_fnc_MP;
	};

sleep 5;

{_x allowDamage true} forEach _POWs;

sleep 30;

[_casa] spawn
	{
	private ["_casa"];
	_casa = _this select 0;
	sleep 300 + (random 1800);
	if ("RES" in misiones) then {[position _casa] remoteExec ["patrolCA",HCattack]};
	};

waitUntil {sleep 1; ({alive _x} count _POWs == 0) or ({(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 50)} count _POWs > 0)};

if ({alive _x} count _POWs == 0) then
	{
	_tsk = ["RES",[side_blue,civilian],[format [_tskDesc,_location, A3_STR_INDEP],_tskTitle,_nombredest],getPos _casa,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
	_cuenta = count _POWs;
	[_cuenta,0] remoteExec ["prestige",2];
	[0,-15,_posicion] remoteExec ["citySupportChange",2];
	[-10,AS_commander] call playerScoreAdd;
	}
else
	{
	_tsk = ["RES",[side_blue,civilian],[format [_tskDesc,_location, A3_STR_INDEP],_tskTitle,_nombredest],getPos _casa,"SUCCEEDED",5,true,true,"run"] call BIS_fnc_setTask;
	_cuenta = {(alive _x) and (_x distance getMarkerPos "FIA_HQ" < 150)} count _POWs;
	_hr = _cuenta;
	_resourcesFIA = 100 * _cuenta;
	[_hr,_resourcesFIA] remoteExec ["resourcesFIA",2];
	[0,_cuenta,_location] remoteExec ["citySupportChange",2];
	[_cuenta,0] remoteExec ["prestige",2];
	{if (_x distance getMarkerPos "FIA_HQ" < 500) then {[_cuenta,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
	[round (_cuenta/2),AS_commander] call playerScoreAdd;
	{[_x] join _grupo; [_x] orderGetin false} forEach _POWs;
	["mis"] remoteExec ["fnc_BE_XP", 2];
	};


sleep 60;
{deleteVehicle _x} forEach _POWs;
deleteGroup _grupo;

[1200,_tsk] spawn borrarTask;
