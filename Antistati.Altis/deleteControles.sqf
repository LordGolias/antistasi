private ["_marcador","_control","_cercano","_pos"];

_marcador = _this select 0;
_control = _this select 1;

_pos = getMarkerPos _control;

_cercano = [marcadores,_pos] call BIS_fnc_nearestPosition;

if (_cercano == _marcador) then
	{
	waitUntil {sleep 1;not (spawner getVariable _control)};
	mrkAAF = mrkAAF - [_control];
	mrkFIA = mrkFIA + [_control];
	publicVariable "mrkAAF";
	publicVariable "mrkFIA";
	};