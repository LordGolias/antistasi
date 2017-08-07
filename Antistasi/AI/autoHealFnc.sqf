if (player != leader group player) exitWith {hint "You must be leader of your group to enable Auto Heal"};

if autoHeal then {
    autoHeal = false;
    hint "Auto Healing disabled";
} else {
    autoHeal = true;
    hint "Auto Heal enabled";
};
/*
while {({alive _x} count _units > {isPlayer _x} count _units) and (autoheal)} do
	{
	{
	if ((damage _x > 0.25) and (alive _x) and (vehicle _x == _x)) then
		{
		_ayudado = _x getVariable "ayudado";
		if (isNil "_ayudado") then {[_x] call pedirAyuda;};
		};
	} forEach _units;
	sleep 1;
	_units = units group player;
	};
if ({alive _x} count _units == {isPlayer _x} count _units) then
	{
	hint "Auto Heal Disabled";
	autoHeal = false;
	};
