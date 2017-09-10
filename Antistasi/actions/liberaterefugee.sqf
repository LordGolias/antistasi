private _unit = _this select 0;
private _jugador = _this select 1;

[[_unit,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;

_jugador globalChat "You are free. Come with us!";
if (captive _jugador) then {
	[_jugador,false] remoteExec ["setCaptive",_jugador];
};
sleep 1;
_unit globalChat "Thank you. I owe you my life!";
_unit enableAI "MOVE";
_unit enableAI "AUTOTARGET";
_unit enableAI "TARGET";
_unit enableAI "ANIM";
[_unit] join group _jugador;
[_unit] call AS_fnc_initUnitFIA;
