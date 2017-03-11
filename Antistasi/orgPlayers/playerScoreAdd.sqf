//if (!isMultiplayer) exitWith {};

private ["_puntos","_jugador","_puntosJ","_dineroJ"];
_puntos = _this select 0;
_jugador = _this select 1;
_notification = true;

if (!isPlayer _jugador) exitWith {};

if (count _this > 2) then {_notification = false};

//if (rank _jugador == "COLONEL") exitWith {};
_jugador = _jugador getVariable ["owner",_jugador];
//if (typeName _jugador == typeName "") exitWith {diag_log format ["Antistasi Error: Intento de asignar puntos a un %1 siendo en realidad %2",_jugador, _this select 1]};
if (isMultiplayer) exitWith {
	_puntosJ = _jugador getVariable ["score",0];
	_dineroJ = _jugador getVariable ["dinero",0];
	if (_puntos > 0) then {
		_dineroJ = _dineroJ + (_puntos * 10);
		_jugador setVariable ["dinero",_dineroJ,true];
		_texto = format ["<br/><br/><br/><br/><br/><br/>Money +%1 €",_puntos*10];
		if (_notification) then {
			[petros,"income",_texto] remoteExec ["commsMP",_jugador];
		};
	};
	_puntos = _puntos + _puntosJ;
	_jugador setVariable ["score",_puntos,true];
};

if (_puntos > 0) then {
	[0,(_puntos * 5)] remoteExec ["resourcesFIA",2];
};