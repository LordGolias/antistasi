private _owner = player getVariable ["AS_controller", player];
if (_owner == player) exitWith {
    diag_log format ["[AS] Error: AS_fnc_dropAIcontrol: cannot drop control without controlling a unit", player];
};

player setVariable ["AS_controller", nil, true];
selectPlayer _owner;
