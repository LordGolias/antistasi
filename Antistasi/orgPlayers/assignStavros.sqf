private ["_puntMax","_texto","_multiplicador","_newRank","_selectable","_disconnected","_owner","_puntos","_datos"];
_puntMax = 0;
_texto = "";
_multiplicador = 1;
//_newRank = "CORPORAL";
_disconnected = false;

_jugadores = [];
_miembros = [];
_elegibles = [];

_lider = objNull;

[] remoteExec ["fnc_BE_pushVariables", 2];

{
_jugadores pushBack (_x getVariable ["owner",_x]);
if (_x != _x getVariable ["owner",_x]) then {waitUntil {_x == _x getVariable ["owner",_x]}};
if ([_x] call isMember) then
	{
	_miembros pushBack _x;
	if (_x getVariable ["elegible",true]) then
		{
		_elegibles pushBack _x;
		if (_x == AS_commander) then
			{
			_lider = _x;
			_datos = [_lider] call numericRank;
			_puntMax = _datos select 0;
			};
		};
	};
} forEach playableUnits;

if (isNull _lider) then
	{
	_puntMax = 0;
	_disconnected = true;
	};
_texto = "Promoted Players:\n\n";
_promoted = false;

_proceder = false;

if ((isNull _lider) or switchCom) then
	{
	if (count _miembros > 0) then
		{
		_proceder = true;
		if (count _elegibles == 0) then {_elegibles = _miembros};
		};
	};

if (!_proceder) exitWith {};

_selectable = objNull;
{
_datos = [_x] call numericRank;
_multiplicador = _datos select 0;
if ((_multiplicador > _puntMax) and (_x!=_lider)) then
	{
	_selectable = _x;
	_puntMax = _multiplicador;
	};
} forEach _elegibles;

if (!isNull _selectable) then
	{
	if (_disconnected) then {_texto = format ["Player Commander disconnected or renounced. %1 is our new leader. Greet him!", name _selectable]} else {_texto = format ["%1 is no longer leader of the FIA Forces.\n\n %2 is our new leader. Greet him!", name AS_commander, name _selectable]};
	[_selectable] call stavrosInit;
	sleep 5;
	[[petros,"hint",_texto],"commsMP"] call BIS_fnc_MP;
	};