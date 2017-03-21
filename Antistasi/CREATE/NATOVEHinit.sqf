private ["_veh"];

_veh = _this select 0;

if ((_veh isKindOf "FlagCarrier") or (_veh isKindOf "Building")) exitWith {};

[_veh] call emptyCrate;
_veh lock 3;
_veh addEventHandler ["GetIn",
	{
	_unit = _this select 2;
	if ({isPlayer _x} count units group _unit > 0) then {moveOut _unit;};
	}];
_veh addEventHandler ["killed",{if ((side (_this select 0) == side_green) or (side (_this select 0) == side_green)) then {[-2,0] remoteExec ["prestige",2]; [2,-2,position (_this select 0)] remoteExec ["citySupportChange",2]}}];

[_veh] spawn cleanserVeh;

if ((count crew _veh) > 0) then
	{
	[_veh] spawn VEHdespawner
	};



