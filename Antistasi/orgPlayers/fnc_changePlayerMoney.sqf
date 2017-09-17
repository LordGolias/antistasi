params ["_value"];

_value = _value + (player getVariable "money");
if (_value < 0) then {_value = 0};
player setVariable ["money", _value, true];
