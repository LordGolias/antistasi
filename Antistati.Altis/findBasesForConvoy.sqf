private ["_marcador","_pos","_basesAAF","_bases","_base","_posbase","_busy"];

_marcador = _this select 0;
_pos = getMarkerPos _marcador;
_basesAAF = bases - mrkFIA;
_bases = [];
_base = "";
{
_base = _x;
_posbase = getMarkerPos _base;
_busy = if (dateToNumber date > server getVariable _base) then {false} else {true};
if ((_pos distance _posbase < 7500) and (_pos distance _posbase > 1500) and (not (spawner getVariable _base)) and (not _busy)) then {_bases = _bases + [_base]}
} forEach _basesAAF;
if (count _bases > 0) then {_base = [_bases,_pos] call BIS_fnc_nearestPosition;} else {_base = ""};
_base