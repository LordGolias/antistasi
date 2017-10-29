if (_this call AS_fnc_controlsAI) exitWith {
    diag_log format ["[AS] Error: AS_fnc_setAIControl: trying to control a controlled unit", _this];
};
if (player call AS_fnc_controlsAI) exitWith {
    diag_log format ["[AS] Error: AS_fnc_setAIControl: trying to control unit while controlling a unit", player];
};

_this setVariable ["AS_controller", player, true];
selectPlayer _this;
