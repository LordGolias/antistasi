if (_this getVariable ["owner", _this] != _this) exitWith {
    diag_log format ["[AS] Error: AS_fnc_setAIControl: trying to control a controlled unit", _this];
};
if (call AS_fnc_controlsAI) exitWith {
    diag_log format ["[AS] Error: AS_fnc_setAIControl: trying to control unit while controlling a unit", player];
};

_this setVariable ["owner", player, true];
selectPlayer _this;
