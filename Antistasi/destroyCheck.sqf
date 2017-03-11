private ["_marcador","_civs","_nombre"];

_marcador = _this select 0;
_civs = _this select 1;

while {spawner getVariable _marcador} do
	{
	if ({(alive _x) and (not(isNull _x))} count _civs == 0) exitWith
		{
		_nombre = [_marcador] call localizar;
		destroyedCities pushBack _marcador;
		publicVariable "destroyedCities";
		[["TaskFailed", ["", format ["%1 Destroyed",_nombre]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		if (_marcador in power) then {/*[_marcador] call powerReorg*/[_marcador] remoteExec ["powerReorg",2]};
		};
	sleep 1;
	};