if (isDedicated) exitWith {};
private ["_nuevo","_viejo"];
_nuevo = _this select 0;
_viejo = _this select 1;

if (isNull _viejo) exitWith {};

waitUntil {alive player};

[_viejo] remoteExec ["postmortem", 2];

private _owner = _viejo getVariable ["owner",_viejo];

if (_owner != _viejo) exitWith {
	hint "Died while AI Remote Control";
	selectPlayer _owner;
	disableUserInput false;
	deleteVehicle _nuevo;
};

[0,-1,getPos _viejo] remoteExec ["citySupportChange",2];

private _score = _viejo getVariable ["score",0];
private _punish = _viejo getVariable ["punish",0];
private _dinero = _viejo getVariable ["money",0];
private _elegible = _viejo getVariable ["elegible",true];
private _rank = _viejo getVariable ["rank", AS_ranks select 0];
_viejo setVariable ["BLUFORSpawn",nil,true];

_dinero = (round (_dinero - (_dinero * 0.1))) max 0;

_nuevo setVariable ["score",_score -1,true];
_nuevo setVariable ["punish",_punish,true];
_nuevo setVariable ["respawning",false];
_nuevo setVariable ["money",_dinero,true];
_nuevo setVariable ["compromised",0];
_nuevo setVariable ["elegible",_elegible,true];
_nuevo setVariable ["BLUFORSpawn",true,true];
_nuevo setCaptive false;
_nuevo setUnitRank _rank;
_nuevo setVariable ["rank",_rank,true];

disableUserInput false;
//_nuevo enableSimulation true;
if (_viejo == AS_commander) then {
	[_nuevo] call AS_fnc_setCommander;
};

[_nuevo] call AS_fnc_emptyUnit;

[] call AS_fnc_initPlayer;

[0,true] remoteExec ["pBarMP",player];
