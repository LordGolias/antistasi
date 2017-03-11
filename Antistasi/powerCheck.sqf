private ["_marcador","_result","_power"];
_marcador = _this select 0;

_result = false;

_power = [power,getMarkerPos _marcador] call BIS_fnc_nearestPosition;

if (_power in destroyedCities) then
	{
	_result = false;
	}
else
	{
	if ((_marcador in mrkAAF) and (_power in mrkAAF)) then {_result = true} else {if ((_marcador in mrkFIA) and (_power in mrkFIA)) then {_result = true}};
	};
_result