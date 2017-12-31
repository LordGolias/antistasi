params ["_unit", "_player"];

[[_unit, "remove"],"AS_fnc_addAction"] call BIS_fnc_MP;

_player globalChat "You are free. Come with us!";
if captive _player then {
	[_player, false] remoteExec ["setCaptive", _player];
};
sleep 1;

_unit sideChat "Thank you. I owe you my life!";
_unit enableAI "MOVE";
_unit enableAI "AUTOTARGET";
_unit enableAI "TARGET";
_unit enableAI "ANIM";
_unit setCaptive false;
[_unit] join group _player;
[_unit] call AS_fnc_initUnitFIA;
